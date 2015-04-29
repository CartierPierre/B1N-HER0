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
			# puts "Utilisateur hors ligne trouvé en local -> jeu"
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
					# puts "Le compte local est du type ONLINE mais pas de compte trouve sur le serveur, donc compte local passe en OFFLINE -> jeu"
					return [ 1, utilLocal ]
				end
				
				# puts "Utilisateur en ligne trouve en local et verifie sur le serveur (tout ok)"
				return [ 2, utilLocal ]
			rescue
				# puts "Utilisateur en ligne trouve en local mais non verifie sur le serveur -> message sync plus tard -> jeu"
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
				# puts "Utilisateur ONLINE trouve sur le serveur et copie faite en local -> jeu"
				return [ 4, nouvelUtil ]
			end
			
		rescue
			# puts "Utilisateur non trouve en local et impossible de se connecter au serveur -> message compte temporaire -> page inscription"
			return [ 5, nil ]
		end
		
		# Aucun utilisateur trouvé
		# puts "Utilisateur non trouve, ni en local ni sur le serveur -> page inscription"
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
				reponse = Serveur.instance().envoyerRessources( utilisateur, [], [] )
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
		
		#
		#
		# Variables
		#
		#
		
		listeScoresEnvoiServeur = Array.new() # Liste d'objets socres à envoyer au serveur
		listeScoresRecupererServeur = Array.new() # Liste d'uuid de scores à récupérer sur le serveur
		listeSauvegardesEnvoiServeur = Array.new()
		listeSauvegardesRecupererServeur = Array.new()
		
		compareScores = Hash.new() # Table d'objets scores à comparer avec les version du serveur
		compareSauvegardes = Hash.new()
		
		hashScoreLocalNouveau = Hash.new()
		hashSauvegardeLocalNouveau = Hash.new()
		
		serveur = Serveur.instance()
		gsc = GestionnaireScore.instance()
		gsa = GestionnaireSauvegarde.instance()
		gut = GestionnaireUtilisateur.instance()
		
		tmp = nil
		couple = nil
		
		#
		#
		# Lecture
		#
		#
		
		# Score
		tmp = gsc.recupererListeScoreUtilisateur( utilisateurLocal, 0, gsc.recupererNombreScoreUtilisateur( utilisateurLocal ) )
		tmp.each_with_index do | scoreL, index |
			# Si la rsc possède un uuid (donc présence sur le serveur)
			if( scoreL.uuid != nil )
				# On met la rsc dans une table de hashage selon uuid
				compareScores[ scoreL.uuid ] = scoreL
			# Sinon elle ne possède pas de uuid (jamais synchronisé pour le moment)
			else
				# On ajoute la rsc à la liste des rsc à envoyer au serveur
				listeScoresEnvoiServeur.push( scoreL )
				# On met la rsc dans une table de hashage selon id locale (pour maj des uuid client)
				hashScoreLocalNouveau[ scoreL.id ] = scoreL
			end
		end
		
		# Sauvegarde
		tmp = gsa.recupererSauvegardeUtilisateur( utilisateurLocal, 0, gsa.recupererNombreSauvegardeUtilisateur( utilisateurLocal ) )
		tmp.each_with_index do | sauvegardeL, index |
			if( sauvegardeL.uuid != nil )
				compareSauvegardes[ sauvegardeL.uuid ] = sauvegardeL
			else
				listeSauvegardesEnvoiServeur.push( sauvegardeL )
				hashSauvegardeLocalNouveau[ sauvegardeL.id ] = sauvegardeL
			end
		end
		
		# On demande la liste de toutes les ressource de l'utilisateur au serveur
		reponse = serveur.listeRessources( utilisateurLocal )
		versionUtilisateurServeur, listeCoupleScoresServeur, listeCoupleSauvegardesServeur = reponse
		# puts "listeRessources, reponse : #{ reponse }"
		
		#
		#
		# Calcul des différences
		#
		#
		
		# Scores
		listeCoupleScoresServeur.each do | scoreS |
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
				elsif( scoreS[1] < scoreL.version )
					listeScoresEnvoiServeur.push( scoreL )
				end
			end
			# compareScores.delete( scoreS[0] )
		end
		
		# Sauvegardes
		listeCoupleSauvegardesServeur.each do | sauvegardeS |
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
				elsif( sauvegardeS[1] < sauvegardeL.version )
					listeSauvegardesEnvoiServeur.push( sauvegardeL )
				end
			end
			# compareSauvegardes.delete( sauvegardeS[0] )
		end
		
		# Debug
		puts "listeScoresRecupererServeur : #{ listeScoresRecupererServeur }"
		puts "listeSauvegardesRecupererServeur : #{ listeSauvegardesRecupererServeur }"
		puts "listeScoresEnvoiServeur : #{ listeScoresEnvoiServeur }"
		puts "listeSauvegardesEnvoiServeur : #{ listeSauvegardesEnvoiServeur }"
		
		#
		#
		# Serveur -> local
		# Insert/Update rsc client
		#
		#
		
		# On demande les ressources que l'on veux mettre à jour en locale
		reponse = serveur.recupererRessources(
			(versionUtilisateurServeur > utilisateurLocal.version) ? utilisateurLocal.uuid : nil,
			listeScoresRecupererServeur,
			listeSauvegardesRecupererServeur
		)
		# puts "recupererRessources, reponse : #{ reponse }"
		utilisateur, listeScores, listeSauvegardes = reponse
		
		# Debug
		puts "versionUtilisateurServeur : #{ versionUtilisateurServeur }"
		puts "utilisateurLocal.version : #{ utilisateurLocal.version }"
		
		# Utilisateur
		if( versionUtilisateurServeur > utilisateurLocal.version )
			utilisateurLocal.version = utilisateur.version
			utilisateurLocal.nom = utilisateur.nom
			utilisateurLocal.motDePasse = utilisateur.motDePasse
			utilisateurLocal.dateInscription = utilisateur.dateInscription
			utilisateurLocal.option = Option.deserialiser( utilisateur.option )
			puts "sync maj user"
			# GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateurLocal )
		end
		
		# Scores
		listeScores.each do | scoreS |
			
			# On essai de lire la rsc depuis la bdd locale
			scoreL = compareScores[ scoreS.id ]
			
			# Si une version de la rsc existe dans la bdd local
			if( scoreL != nil ) 
				# On met à jour la rsc
				scoreL.version = scoreS.version
				scoreL.tempsTotal = scoreS.tempsTotal
				scoreL.nbCoups = scoreS.nbCoups
				scoreL.nbConseils = scoreS.nbConseils
				scoreL.nbAides = scoreS.nbAides
				
			# Sinon elle n'existe pas en locale
			elsif
				# On adapte la rsc du serveur pour l'ajouter à la bdd locale
				scoreL = scoreS
				scoreL.uuid = scoreS.id
				scoreL.id = nil
				scoreL.idUtilisateur = utilisateurLocal.id
			end
			
			# On met à jour la bdd locale
			GestionnaireScore.instance().sauvegarderScore( scoreL )
		end
		
		# Sauvegardes
		listeSauvegardes.each do | sauvegardeS |
			
			sauvegardeL = compareSauvegardes[ sauvegardeS.id ]
			
			if( sauvegardeL != nil ) 
				sauvegardeL.version = sauvegardeS.version
				sauvegardeL.description = sauvegardeS.description
				sauvegardeL.dateCreation = sauvegardeS.dateCreation
				sauvegardeL.contenu = sauvegardeS.contenu
			elsif
				sauvegardeL = sauvegardeS
				sauvegardeL.uuid = sauvegardeL.id
				sauvegardeL.id = nil
				sauvegardeL.idUtilisateur = utilisateurLocal.id
			end
			
			GestionnaireSauvegarde.instance().sauvegarderSauvegarde( sauvegardeL )
		end
		
		#
		#
		# Local -> serveur
		# Update/Insert rsc serveur
		# Update uuid client
		#
		#
		
		# Envoi des rsc au serveur
		reponse = serveur.envoyerRessources( utilisateurLocal, listeScoresEnvoiServeur, listeSauvegardesEnvoiServeur )
		# puts "envoyerRessources, reponse : #{ reponse }"
		uuidUtilisateur, listeUuidScores, listeUuidSauvegardes = reponse
		
		# Maj des uuid de rsc locales selon valeur renvoyé par le serveur
		listeUuidScores.each do | couple |
			scoreL = hashScoreLocalNouveau[ couple[0] ]
			scoreL.uuid = couple[1]
			GestionnaireScore.instance().sauvegarderScore( scoreL )
		end
		
		listeUuidSauvegardes.each do | couple |
			sauvegardeL = hashSauvegardeLocalNouveau[ couple[0] ]
			sauvegardeL.uuid = couple[1]
			GestionnaireSauvegarde.instance().sauvegarderSauvegarde( sauvegardeL )
		end
		
	end
end
