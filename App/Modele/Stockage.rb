##
# La classe Stockage permet d'utiliser le base de données local et de la syncroniser avec la base de données distante
# Utilise le DP Singleton
#
# Version 10
#
class Stockage

	### Attributs de classe
	
	@@instance = nil
	
	### Attributs d'instances
	
	@bddLocal
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def Stockage.instance
		if(@@instance == nil)
			@@instance = new
		end
		
		return @@instance;
	end
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize
		# puts "Ouverture de la base de données ..."
		begin
			# @bddLocal = SQLite3::Database.new( File.dirname(__FILE__) + "/../Ressources/bdd.sqlite" )
			@bddLocal = SQLite3::Database.new( "./Ressources/bdd.sqlite" )
			rescue SQLite3::Exception => err
				puts "Erreur"
				puts err
				abort
		end
		# puts "OK"
	end
	
	### Méthodes d'instances
	
	##
	# Execute une requête SQL sur la base de données locale
	#
	def executer(requete)
		# puts requete
		return @bddLocal.execute(requete)
	end
	
	##
	# Renvoi le dernier id créé lors d'une requête SQL sur la base de données locale
	#
	# ==== Retour
	# Renvoi un le dernier id inséré dans la base de données
	#
	def dernierId()
		return @bddLocal.last_insert_row_id
	end
	
	##
	# Gère l'inscription d'un utilisateur dans la base locale et le serveur selon les cas
	#
	def insciption( nouvelutilisateur )
		if( nouvelutilisateur.type == Utilisateur::ONLINE )
			# Sauvegarde serveur
			reponse = envoyerRessources( nouvelutilisateur )
			puts "Insert sur le serveur, uuid : #{ reponse[0] }"
			# Sauvegarde local
			nouvelUtil.uuid = reponse[0]
			GestionnaireUtilisateur.instance().sauvegarderUtilisateur( nouvelUtil )
			puts "Insert dans la bdd"
		elsif( nouvelutilisateur.type == Utilisateur::OFFLINE )
			GestionnaireUtilisateur.instance().sauvegarderUtilisateur( nouvelUtil )
		else
			raise "Mauvais type utilisateur !"
		end
	end
	
	##
	# Test si les identifiants sont correctes et authentifie un utilisateur. Synchronise la ressource utilisateur dans le cas d'un compte online.
	# La synchronisation des ressources n'est réalisé par cette fonction.
	#
	# ==== Paramètres
	# * +nom+ - (string) Nom de l'utilisateur
	# * +motDePasse+ - (string) Mot de passe de l'utilisateur
	#
	# ==== Retour
	# Renvoi un tableau à deux cases, la première contient le code de retour, le second un objet utilisateur ou nil selon code
	#
	def authentification( nom, motDePasse )
	
		# Lecture locale
		utilLocal = GestionnaireUtilisateur.instance().connexionUtilisateur( nom, motDePasse )
		
		# Si l'utilisateur est trouvé en local et que c'est un compte du type hors ligne
		if( utilLocal != nil && utilLocal.type == Utilisateur::OFFLINE )
			puts "Utilisateur hors ligne trouvé en local -> jeu"
			return [ 0, utilLocal ]
		end
		
		# Si l'utilisateur est trouvé en local et que c'est un compte du type en ligne
		if( utilLocal != nil && utilLocal.type == Utilisateur::ONLINE )
			begin
				# On test la présence du compte sur le serveur
				utilServeur = Serveur.instance().connexionUtilisateur( nom, motDePasse )
				
				# S'il n'est pas trouvé sur le serveur
				if( utilServeur == nil )
					utilLocal.type = Utilisateur::OFFLINE
					GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilLocal )
					puts "Le compte local est du type ONLINE mais pas de compte trouve sur le serveur, donc compte local passe en OFFLINE -> jeu"
					return [ 1, utilLocal ]
				end
				
				puts "Utilisateur en ligne trouve en local et verifie sur le serveur (tout ok)"
				return [ 2, utilLocal ]
			rescue
				puts "Utilisateur en ligne trouve en local mais non verifie sur le serveur -> message sync plus tard -> jeu"
				return [ 3, utilLocal ]
			end
		end
		
		# Lecture serveur
		begin
			utilServeur = Serveur.instance().connexionUtilisateur( nom, motDePasse )
			# Si l'utilisateur est trouvé sur le serveur
			if( utilServeur != nil )
				# On crée un nouvel utilisateur selon les données du serveur
				nouvelUtil = Utilisateur.creer(
					nil,
					utilServeur.id,
					utilServeur.version,
					utilServeur.nom,
					utilServeur.motDePasse,
					utilServeur.dateInscription,
					Option.deserialiser( utilServeur.option ),
					Utilisateur::ONLINE
				)
				# On sauvegarde se dernier dans la bdd locale
				GestionnaireUtilisateur.instance().sauvegarderUtilisateur( nouvelUtil )
				puts "Utilisateur ONLINE trouve sur le serveur et copie faite en local -> jeu"
				return [ 4, nouvelUtil ]
			end
			
		rescue
			puts "Utilisateur non trouve en local et impossible de se connecter au serveur -> message compte temporaire -> page inscription"
			return [ 5, nil ]
		end
		
		# Aucun utilisateur trouvé
		puts "Utilisateur non trouve, ni en local ni sur le serveur -> page inscription"
		return [ 6, nil ]
	end
	
	##
	# Inscrit un joueur au jeu
	#
	def inscription( utilisateur )
		# Si c'est un utilisateur du type hors ligne
		if( utilisateur.type == Utilisateur::OFFLINE )
			begin
				GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
			rescue SQLite3::ConstraintException => erreur
				raise "L'utilisateur existe déjà !"
			end
		# Sinon c'est un utilisateur du type en ligne
		elsif( utilisateur.type == Utilisateur::ONLINE )
			begin
				# Insertion de l'utilisateur en local
				begin
					GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
				rescue SQLite3::ConstraintException => erreur
					raise "L'utilisateur existe déjà"
				end
				
				# On envoi le nouvel utilisateur au serveur
				reponse = Serveur.instance().envoyerRessources( utilisateur, nil, nil )
				uuidUtilisateur = reponse[0]
				if( uuidUtilisateur == -1 )
					GestionnaireUtilisateur.instance().supprimerUtilisateur( utilisateur )
					raise "L'utilisateur existe déjà !"
				end
				utilisateur.uuid = uuidUtilisateur
				GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
			rescue Exception => e
				GestionnaireUtilisateur.instance().supprimerUtilisateur( utilisateur )
				raise "Erreur de connexion !"
			end
		# Sinon mauvais type
		else
			raise "Mauvais type utilisateur !"
		end
	end
	
	##
	# Synchronise les données d'un utilisateur avec serveur (WIP)
	#
	# ==== Paramètres
	# * +utilisateurLocal+ - (Utilisateur) Utilisateur dont l'on veux synchroniser les données
	#
	def syncroniser( utilisateurLocal )
	
		# Si c'est un compte hors ligne, on ne va pas plus loin
		if( utilisateurLocal.type == Utilisateur::OFFLINE )
			raise "Un compte hors ligne ne peut etre synchronise !"
		end
		
		# Sinon c'est un compte online, donc au procède à la synchronisation
		
		# Variables
		listeScoresEnvoiServeur = Array.new() # Liste d'objets socres à envoyer au serveur
		listeScoresRecupererServeur = Array.new() # Liste d'uuid de scores à récupérer sur le serveur
		listeSauvegardesEnvoiServeur = Array.new()
		listeSauvegardesRecupererServeur = Array.new()
		compareScores = Hash.new() # Table d'objets scores à comparer avec les version du serveur
		compareSauvegardes = Hash.new()
		serveur = Serveur.instance()
		gsc = GestionnaireScore.instance()
		gsa = GestionnaireSauvegarde.instance()
		tmp = nil
		
		# On récupère les scores locaux
		tmp = gsc.recupererListeScoreUtilisateur( utilisateurLocal, 0, gsc.recupererNombreScoreUtilisateur( utilisateurLocal ) )
		tmp.each_with_index do | scoreL, index |
			# Si le score possède un uuid
			if( scoreL.uuid != nil )
				# On le met dans une table de hashage pour procéder aux calculs de différences
				compareScores[ scoreL.uuid ] = scoreL
			# Sinon il ne possède pas de uuid
			else
				# On l'ajoute à la liste des envois serveur
				listeScoresEnvoiServeur.push( scoreL )
			end
		end
		
		# On récupère les sauvegardes locales
		tmp = gsa.recupererSauvegardeUtilisateur( utilisateurLocal, 0, gsa.recupererNombreSauvegardeUtilisateur( utilisateurLocal ) )
		tmp.each_with_index do | sauvegardeL, index |
			if( sauvegardeL.uuid != nil )
				compareSauvegardes[ sauvegardeL.uuid ] = sauvegardeL
			else
				listeSauvegardesEnvoiServeur.push( sauvegardeL )
			end
		end
		
		# On demande la liste de toutes les ressource de l'utilisateur au serveur
		reponse = serveur.listeRessources( utilisateurLocal )
		versionUtilisateurServeur, versionScoresServeur, versionSauvegardesServeur = reponse
		
		# Comparaison scores
		versionScoresServeur.each do | scoreS |
			# Si score pas trouvé en locale
			if( !compareScores.has_key?( scoreS[0] ) )
				listeScoresRecupererServeur.push( scoreS[0] )
			# Sinon score trouvé en locale
			else
				scoreL = compareScores[ scoreS[0] ]
				# Si version serveur supérieure
				if( scoreS[1] > scoreL.version )
					listeScoresRecupererServeur.push( scoreS[0] )
				# Sinon version locale supérieur
				else
					listeScoresEnvoiServeur.push( scoreL )
				end
			end
			# compareScores.delete( scoreS[0] )
		end
		
		# Comparaison sauvegardes
		versionSauvegardesServeur.each do | sauvegardeS |
			# Si sauvegarde pas trouvé en locale
			if( !compareSauvegardes.has_key?( sauvegardeS[0] ) )
				listeSauvegardesRecupererServeur.push( sauvegardeS[0] )
			# Sinon sauvegarde trouvé en locale
			else
				sauvegardeL = compareSauvegardes[ sauvegardeS[0] ]
				# Si version serveur supérieure
				if( sauvegardeS[1] > sauvegardeL.version )
					listeSauvegardesRecupererServeur.push( sauvegardeS[0] )
				# Sinon version locale supérieur
				else
					listeSauvegardesEnvoiServeur.push( sauvegardeL )
				end
			end
			# compareSauvegardes.delete( sauvegardeS[0] )
		end
		
		# Debug
		puts "versionUtilisateurServeur : #{ versionUtilisateurServeur }"
		puts "utilisateurLocal.version : #{ utilisateurLocal.version }"
		puts "listeScoresRecupererServeur : #{ listeScoresRecupererServeur }"
		puts "listeSauvegardesRecupererServeur : #{ listeSauvegardesRecupererServeur }"
		puts "listeScoresEnvoiServeur : #{ listeScoresEnvoiServeur }"
		puts "listeSauvegardesEnvoiServeur : #{ listeSauvegardesEnvoiServeur }"
		
		# On demande les ressources que l'on veux mettre à jour en locale
		reponse = serveur.recupererRessources(
			(versionUtilisateurServeur > utilisateurLocal.version) ? utilisateurLocal.uuid : nil,
			listeScoresRecupererServeur,
			listeSauvegardesRecupererServeur
		)
		puts "recupererRessources, reponse : #{ reponse }"
		utilisateur, listeScores, listeSauvegardes = reponse
		
		# On met à jour l'utilisateur
		if( versionUtilisateurServeur > utilisateurLocal.version )
			puts "utilisateur : #{ utilisateur } -> utilisateurLocal : #{ utilisateurLocal }"
			utilisateurLocal.version = utilisateur.version
			utilisateurLocal.nom = utilisateur.nom
			utilisateurLocal.motDePasse = utilisateur.motDePasse
			utilisateurLocal.option = utilisateur.dateInscription
			Option.deserialiser( utilServeur.option )
			# GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateurLocal )
		end
		
		# On met à jour les scores
		listeScores.each do | scoreS |
			scoreL = compareScores[ scoreS.id ]
			puts "scoreS : #{ scoreS } -> scoreL : #{ scoreL }"
			scoreL.version = scoreS.version
			scoreL.version = scoreS.tempsTotal
			scoreL.version = scoreS.nbCoups
			scoreL.version = scoreS.nbConseils
			scoreL.version = scoreS.nbAides
			# GestionnaireScore.instance().sauvegarderScore( scoreL )
		end
		
		# On met à jour les sauvegardes
		listeSauvegardes.each do | sauvegardeS |
			scoreL = compareScores[ sauvegardeS.id ]
			puts "sauvegardeS : #{ sauvegardeS } -> sauvegardeL : #{ sauvegardeL }"
			sauvegardeL.version = sauvegardeS.version
			sauvegardeL.description = sauvegardeS.description
			sauvegardeL.dateCreation = sauvegardeS.dateCreation
			sauvegardeL.contenu = sauvegardeS.contenu
			# GestionnaireSauvegarde.instance().sauvegarderSauvegarde( sauvegardeL )
		end
		
		# Envoi des ressources à inserts/updates au serveur
		reponse = serveur.envoyerRessources(
			(versionUtilisateurServeur < utilisateurLocal.version) ? utilisateurLocal : nil,
			listeScoresEnvoiServeur,
			listeSauvegardesEnvoiServeur
		)
		puts "envoyerRessources, reponse : #{ reponse }"
		uuidUtilisateur, listeUuidScores, listeUuidSauvegardes = reponse
		
	end
end
