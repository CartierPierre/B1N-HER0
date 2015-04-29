##
# La classe Stockage permet d'utiliser le base de données local et de la syncroniser avec la base de données distante
# Utilise le DP Singleton
#
# Version 11
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
		#puts requete
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
					
					# On met à jour l'utilisateur locale
					utilLocal.type = Utilisateur::OFFLINE
					utilLocal.uuid = nil
					GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilLocal )
					
					# On supprime les uuids des scores et sauvegardes locales
					GestionnaireSauvegarde.instance().supprimerUuidSauvegardeUtilisateur( utilLocal )
					GestionnaireScore.instance().supprimerUuidScoreUtilisateur( utilLocal )
					
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
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utilisateur à inscrire
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
	# Synchronise les données d'un utilisateur avec serveur
	#
	# ==== Paramètres
	# * +utilisateurLocal+ - (Utilisateur) Utilisateur auquel il faut synchroniser les données
	# * +mode+ - (boolean) true : synchronisation à la connexion, false : synchronisation à la dé-connexion
	#
	def syncroniser( utilisateurLocal, mode )
	
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
		
		listeEnvoiScoreServeur = Array.new() # Liste d'objets scores à envoyer au serveur
		listeRecupererScoreServeur = Array.new() # Liste d'uuid de scores à récupérer sur le serveur
		listeEnvoiSauvegardeServeur = Array.new()
		listeRecupererSauvegardeServeur = Array.new()
		
		compareScores = Hash.new() # Table d'objets scores, diminue au fur et a mesure du script, les scores restants sont finnalements supprimé de la bdd locale
		compareSauvegardes = Hash.new()
		
		hashNouveauScoreServeur = Hash.new() # Liste des nouveaux scores synchronisés du client vers le serveur
		hashNouvelleSauvegardeServeur = Hash.new()
		
		listeScorePasLocal = Array.new() # Liste de scores non trouvées en local mais présents sur le serveur
		listeSauvegardePasLocal = Array.new()
		
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
				listeEnvoiScoreServeur.push( scoreL )
				# On met la rsc dans une table de hashage selon id locale (pour maj des uuid client)
				hashNouveauScoreServeur[ scoreL.id ] = scoreL
			end
		end
		
		# Sauvegarde
		tmp = gsa.recupererSauvegardeUtilisateur( utilisateurLocal, 0, gsa.recupererNombreSauvegardeUtilisateur( utilisateurLocal ) )
		tmp.each_with_index do | sauvegardeL, index |
			if( sauvegardeL.uuid != nil )
				compareSauvegardes[ sauvegardeL.uuid ] = sauvegardeL
			else
				listeEnvoiSauvegardeServeur.push( sauvegardeL )
				hashNouvelleSauvegardeServeur[ sauvegardeL.id ] = sauvegardeL
			end
		end
		
		# On demande la liste de toutes les ressource de l'utilisateur au serveur
		reponse = serveur.listeRessources( utilisateurLocal )
		versionUtilisateurServeur, listeCoupleScoresServeur, listeCoupleSauvegardesServeur = reponse
		puts "listeRessources, reponse : #{ reponse }"
		
		#
		#
		# Calcul des différences
		#
		#
		
		# Scores
		listeCoupleScoresServeur.each do | scoreS |
			# Si score pas trouvé en locale
			if( !compareScores.has_key?( scoreS[0] ) )
				# listeRecupererScoreServeur.push( scoreS[0] )
				# Dans le cas d'une connexion il y a ajout sur client, et lors de la déconnexion il y a suppression serveur
				listeScorePasLocal.push( scoreS[0] )
			# Sinon score trouvé en locale
			else
				scoreL = compareScores[ scoreS[0] ]
				# Si version serveur supérieure
				if( scoreS[1] > scoreL.version )
					listeRecupererScoreServeur.push( scoreS[0] )
				# Sinon version locale supérieur
				elsif( scoreS[1] < scoreL.version )
					listeEnvoiScoreServeur.push( scoreL )
					compareScores.delete( scoreL.uuid )
				# Sinon rien à faire sur rcs
				else
					compareScores.delete( scoreS[0] )
				end
			end
		end
		
		# Sauvegardes
		listeCoupleSauvegardesServeur.each do | sauvegardeS |
			if( !compareSauvegardes.has_key?( sauvegardeS[0] ) )
				listeSauvegardePasLocal.push( sauvegardeS[0] )
			else
				sauvegardeL = compareSauvegardes[ sauvegardeS[0] ]
				if( sauvegardeS[1] > sauvegardeL.version )
					listeRecupererSauvegardeServeur.push( sauvegardeS[0] )
				elsif( sauvegardeS[1] < sauvegardeL.version )
					listeEnvoiSauvegardeServeur.push( sauvegardeL )
					compareSauvegardes.delete( sauvegardeL.uuid )
				else
					compareSauvegardes.delete( sauvegardeS[0] )
				end
			end
		end
		
		# Debug
		puts "listeRecupererScoreServeur : #{ listeRecupererScoreServeur }"
		puts "listeRecupererSauvegardeServeur : #{ listeRecupererSauvegardeServeur }"
		puts "listeEnvoiScoreServeur : #{ listeEnvoiScoreServeur }"
		puts "listeEnvoiSauvegardeServeur : #{ listeEnvoiSauvegardeServeur }"
		puts "listeScorePasLocal : #{ listeScorePasLocal }"
		puts "listeSauvegardePasLocal : #{ listeSauvegardePasLocal }"
		
		#
		#
		# Serveur -> local
		# Insert/Update/Delete rsc client
		#
		#
		
		# Si on est en mode connexion
		if( mode )
			# Les rcs non présententes en locale seront demandées au serveur
			listeRecupererScoreServeur = listeRecupererScoreServeur + listeScorePasLocal
			listeRecupererSauvegardeServeur = listeRecupererSauvegardeServeur + listeSauvegardePasLocal
		end
		
		# On demande les ressources que l'on veux mettre à jour en locale
		reponse = serveur.recupererRessources(
			(versionUtilisateurServeur > utilisateurLocal.version) ? utilisateurLocal.uuid : nil,
			listeRecupererScoreServeur,
			listeRecupererSauvegardeServeur
		)
		puts "recupererRessources, reponse : #{ reponse }"
		utilisateur, listeScores, listeSauvegardes = reponse
		
		# Debug
		# puts "versionUtilisateurServeur : #{ versionUtilisateurServeur }"
		# puts "utilisateurLocal.version : #{ utilisateurLocal.version }"
		
		# Utilisateur
		if( versionUtilisateurServeur > utilisateurLocal.version )
			utilisateurLocal.version = utilisateur.version
			utilisateurLocal.nom = utilisateur.nom
			utilisateurLocal.motDePasse = utilisateur.motDePasse
			utilisateurLocal.dateInscription = utilisateur.dateInscription
			utilisateurLocal.option = Option.deserialiser( utilisateur.option )
			gut.sauvegarderUtilisateur( utilisateurLocal )
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
				compareScores.delete( scoreS.id )
			# Sinon elle n'existe pas en locale
			elsif
				# On adapte la rsc du serveur pour l'ajouter à la bdd locale
				scoreL = scoreS
				scoreL.uuid = scoreS.id
				scoreL.id = nil
				scoreL.idUtilisateur = utilisateurLocal.id
			end
			
			# On met à jour la bdd locale
			gsc.sauvegarderScore( scoreL )
		end
		
		# On supprime toutes les rsc locales qui restes dans la liste (n'existe plus sur le serveur)
		compareScores.each do | key, scoreL |
			gsc.supprimerScore( scoreL )
		end
		
		# Sauvegardes
		listeSauvegardes.each do | sauvegardeS |
			
			sauvegardeL = compareSauvegardes[ sauvegardeS.id ]
			
			if( sauvegardeL != nil ) 
				sauvegardeL.version = sauvegardeS.version
				sauvegardeL.description = sauvegardeS.description
				sauvegardeL.dateCreation = sauvegardeS.dateCreation
				sauvegardeL.contenu = sauvegardeS.contenu
				compareSauvegardes.delete( sauvegardeS.id )
			elsif
				sauvegardeL = sauvegardeS
				sauvegardeL.uuid = sauvegardeL.id
				sauvegardeL.id = nil
				sauvegardeL.idUtilisateur = utilisateurLocal.id
			end
			
			gsa.sauvegarderSauvegarde( sauvegardeL )
		end
		
		compareSauvegardes.each do | key, sauvegardeL |
			gsa.supprimerSauvegarde( sauvegardeL )
		end
		
		#
		#
		# Local -> serveur
		# Update/Insert/Delete rsc serveur
		# Update uuid client
		#
		#
		
		# Envoi des rsc au serveur
		reponse = serveur.envoyerRessources( utilisateurLocal, listeEnvoiScoreServeur, listeEnvoiSauvegardeServeur )
		puts "envoyerRessources, reponse : #{ reponse }"
		uuidUtilisateur, listeUuidScores, listeUuidSauvegardes = reponse
		
		# Maj des uuid de rsc locales selon valeurs renvoyées par le serveur
		listeUuidScores.each do | couple |
			if( hashNouveauScoreServeur.has_key?( couple[0] ) )
				scoreL = hashNouveauScoreServeur[ couple[0] ]
				scoreL.uuid = couple[1]
				gsc.sauvegarderScore( scoreL )
			end
		end
		
		listeUuidSauvegardes.each do | couple |
			if( hashNouvelleSauvegardeServeur.has_key?( couple[0] ) )
				sauvegardeL = hashNouvelleSauvegardeServeur[ couple[0] ]
				sauvegardeL.uuid = couple[1]
				gsa.sauvegarderSauvegarde( sauvegardeL )
			end
		end
		
		# Si on est en mode dé-connexion
		if ( !mode )
			# Les rcs non présentes en locale seront supprimées sur le serveur
			serveur.supprimerRessources( nil, listeScorePasLocal, listeSauvegardePasLocal )
		end
		
	end
	
	##
	# Supprime tous les scores et sauvegardes d'un utilisateur. Remets les options par défaut.
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Utilisateur à ré-initialiser
	#
	def miseAZeroUtilisateur( utilisateur )
		GestionnaireSauvegarde.instance().supprimerSauvegardeUtilisateur( utilisateur )
		GestionnaireScore.instance().supprimerScoreUtilisateur( utilisateur )
		utilisateur.option = Option.creer(Option::TUILE_ROUGE, Option::TUILE_BLEUE, Langue::FR)
		GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
	end
	
	##
	# Fusionne deux compte en un seul
	#
	# ==== Paramètres
	# * +utilisateur1+ - (Utilisateur) Premier compte à fusionner
	# * +nom+ - (string) Nom du second compte à fusionner
	# * +motDePasse+ - (string) Mot de passe du second compte à fusionner
	# * +sortie+ - (boolean) true : le premier dans le second, false : le second dans le premier
	#
	# ==== Retour
	# Renvoi un objet utilisateur fusion des deux précèdents
	#
	def fusionUtilisateurs( utilisateur1, nom, motDePasse, sortie )
	
		# On récupère le second utilisateur
		resultat = authentification( nom, motDePasse )
		
		case resultat[0]
		when 3
			raise "Le second compte doit etre verifie avec internet !"
		when 0..4
			# ok
		when 5..6
			raise "Le second compte n'a pas ete trouve !"
        end
		
		utilisateur2 = resultat[1]
		
		# Si c'est le même utilisateur
        puts utilisateur1.nom
        puts utilisateur2.nom
		if( utilisateur1.id == utilisateur2.id || ((utilisateur1.uuid == utilisateur2.uuid) && (utilisateur1.uuid != nil) &&(utilisateur2.uuid != nil)))
			raise "Les utilisateurs sont identiques !"
		end
		
		# utilisateurMange -> utilsateurFinal
		if( sortie )
			utilisateurMange = utilisateur1
			utilsateurFinal = utilisateur2
		else
			utilisateurMange = utilisateur2
			utilsateurFinal = utilisateur1
		end
		
		# Fusion
		if( utilisateurMange.type == Utilisateur::ONLINE && utilsateurFinal.type == Utilisateur::ONLINE )
		
			# On fusionne sur le serveur
			Serveur.instance().fusion( utilisateurMange, utilsateurFinal )
			
			# On fusionne en local
			GestionnaireSauvegarde.instance().changerUtilisateurSauvegarde( utilisateurMange, utilsateurFinal )
			GestionnaireScore.instance().changerUtilisateurScore( utilisateurMange, utilsateurFinal )
			GestionnaireUtilisateur.instance().supprimerUtilisateur( utilisateurMange )
			
		elsif( utilisateurMange.type == Utilisateur::ONLINE && utilsateurFinal.type == Utilisateur::OFFLINE )
			
			# On supprime l'ancien utilisateur et toutes ses ressources du serveur
			Serveur.instance().supprimerTracesUtilisateur( utilisateur )
			
			# On change le propriétaire des scores et sauvegardes locales
			GestionnaireSauvegarde.instance().changerUtilisateurSauvegarde( utilisateurMange, utilsateurFinal )
			GestionnaireScore.instance().changerUtilisateurScore( utilisateurMange, utilsateurFinal )
			
			# On supprime les uuids des scores et sauvegardes locales
			GestionnaireSauvegarde.instance().supprimerUuidSauvegardeUtilisateur( utilsateurFinal )
			GestionnaireScore.instance().supprimerUuidScoreUtilisateur( utilsateurFinal )
			
			# On supprime l'ancien utilisateur locale
			GestionnaireUtilisateur.instance().supprimerUtilisateur( utilisateurMange )
			
		elsif( utilisateurMange.type == Utilisateur::OFFLINE && utilsateurFinal.type == Utilisateur::ONLINE )
		
			# On fusionne en local
			GestionnaireSauvegarde.instance().changerUtilisateurSauvegarde( utilisateurMange, utilsateurFinal )
			GestionnaireScore.instance().changerUtilisateurScore( utilisateurMange, utilsateurFinal )
			GestionnaireUtilisateur.instance().supprimerUtilisateur( utilisateurMange )
			
			# On synchronise
			self.synchronisation( utilsateurFinal )
			
		elsif( utilisateurMange.type == Utilisateur::OFFLINE && utilsateurFinal.type == Utilisateur::OFFLINE )
		
			# On fusionne en local
			GestionnaireSauvegarde.instance().changerUtilisateurSauvegarde( utilisateurMange, utilsateurFinal )
			GestionnaireScore.instance().changerUtilisateurScore( utilisateurMange, utilsateurFinal )
			GestionnaireUtilisateur.instance().supprimerUtilisateur( utilisateurMange )
			
		end
		
		# On renvoi l'utilisateur final
		return utilsateurFinal
	end
	
	##
	# Change le type d'un compte
	#
	# ==== Paramètres
	# * +utilisateur+ - (Utilisateur) Compte dont il faut changer le type
	#
	def changerTypeUtilisateur( utilisateur )
	
		# Si l'utilisateur est du type en ligne
		if( utilisateur.type == Utilisateur::ONLINE )
		
			# On supprime l'utilisateur et toutes ses ressources du serveur
			Serveur.instance().supprimerTracesUtilisateur( utilisateur )
			
			# On met à jour l'utilisateur local
			utilisateur.uuid = nil
			utilisateur.type = Utilisateur::OFFLINE
			GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
			
			# On supprime les uuid des scores et des sauvegardes locales
			GestionnaireSauvegarde.instance().supprimerUuidSauvegardeUtilisateur( utilisateur )
			GestionnaireScore.instance().supprimerUuidScoreUtilisateur( utilisateur )
		
		# Sinon si  l'utilisateur est du type hors ligne ligne
		elsif( utilisateur.type == Utilisateur::OFFLINE )
		
			# On envoi l'utilisateur au serveur
			reponse = Serveur.instance().envoyerRessources( utilisateur, [], [] )
			uuidUtilisateur = reponse[0]
			
			# Si il existe déjà sur le serveur
			if( uuidUtilisateur == -1 )
				raise "L'utilisateur existe déjà sur le serveur!"
			end
			
			# On met à jour l'utilisateur local
			utilisateur.uuid = uuidUtilisateur
			utilisateur.type = Utilisateur::ONLINE
			GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
			
			# On synchronise
			self.syncroniser( utilisateur, true )
			
		else
			raise "Mauvais type utilisateur !"
		end
	end
	
end
