##
# La classe Stockage permet d'utiliser le base de données local et de la syncroniser avec la base de données distante
# Utilise le DP Singleton
#
# Version 7
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
	# Synchronise les données d'un utilisateur avec serveur (WIP)
	#
	# ==== Paramètres
	# * +utilisateurLocal+ - (Utilisateur) Utilisateur dont l'on veux synchroniser les données
	#
	def syncroniser( utilisateurLocal )
	
		# Si c'est un compte offline, on ne va pas plus loin
		if( utilisateurLocal.type == 0 )
			return false
		end
		
		## Variables
		listeScoresInsertServeur = Array.new() # Liste d'objets socres à insérer dans la bdd du serveur
		listeScoresUpdateServeur = Array.new() # Liste d'objets scores à mettre à jour dans la bdd du serveur
		listeScoresSelectServeur = Array.new() # Liste d'uuid de scores à récupérer dans la bdd du serveur
		listeSauvegardesInsertServeur = Array.new()
		listeSauvegardesUpdateServeur = Array.new()
		listeSauvegardesSelectServeur = Array.new()
		compareScores = Hash.new() # Table d'objets scores à comparer avec les version du serveur
		compareSauvegardes = Hash.new()
		
		# Sinon c'est un compte online, donc au procède à la synchronisation
		serveur = Serveur.instance()
		gsc = GestionnaireScore.instance()
		gsa = GestionnaireSauvegarde.instance()
		
		# On récupère les scores locaux
		tmp = gsc.recupererListeScoreUtilisateur( utilisateurLocal, 0, gsc.recupererNombreScoreUtilisateur( utilisateurLocal ) )
		tmp.each_with_index do | scoreL, index |
			if( scoreL.uuid != nil )
				compareScores[ scoreL.uuid ] = scoreL
				tmp.delete_at( index )
			end
		end
		listeScoresInsertServeur.push( tmp )
		
		# On récupère les sauvegardes locales
		tmp = gsa.recupererSauvegardeUtilisateur( utilisateurLocal, 0, gsa.recupererNombreSauvegardeUtilisateur( utilisateurLocal ) )
		tmp.each_with_index do | sauvegardeL, index |
			if( sauvegardeL.uuid != nil )
				compareSauvegardes[ sauvegardeL.uuid ] = sauvegardeL
				tmp.delete_at( index )
			end
		end
		listeSauvegardesInsertServeur.push( tmp )
		
		# On demande la liste de toutes les ressource de l'utilisateur au serveur
		reponse = serveur.listeRessources( utilisateurLocal )
		if( !reponse )
			return false
		end
		versionUtilisateurServeur, versionScoresServeur, versionSauvegardesServeur = reponse
		
		# Comparaison scores
		versionScoresServeur.each do | scoreS |
			# Si score pas trouvé en locale
			if( !compareScores.has_key?( scoreS[0] ) )
				listeScoresSelectServeur.push( scoreS[0] )
			# Sinon score trouvé en locale
			else
				scoreL = compareScores[ scoreS[0] ]
				# Si version serveur supérieure
				if( scoreS[1] > scoreL.version )
					listeScoresSelectServeur.push( scoreS[0] )
				# Sinon version locale supérieur
				else
					listeScoresUpdateServeur.push( scoreL )
				end
			end
			compareScores.delete( scoreS[0] )
		end
		listeScoresInsertServeur.push( compareScores.values() )
		
		# Comparaison sauvegardes
		versionSauvegardesServeur.each do | sauvegardeS |
			# Si sauvegarde pas trouvé en locale
			if( !compareSauvegardes.has_key?( sauvegardeS[0] ) )
				listeSauvegardesSelectServeur.push( sauvegardeS[0] )
			# Sinon sauvegarde trouvé en locale
			else
				sauvegardeL = compareSauvegardes[ sauvegardeS[0] ]
				# Si version serveur supérieure
				if( sauvegardeS[1] > sauvegardeL.version )
					listeSauvegardesSelectServeur.push( sauvegardeS[0] )
				# Sinon version locale supérieur
				else
					listeSauvegardesUpdateServeur.push( sauvegardeL )
				end
			end
			compareSauvegardes.delete( sauvegardeS[0] )
		end
		listeSauvegardesInsertServeur.push( compareSauvegardes.values() )
		
		# Debug
		# puts "Select Scores : #{ listeScoresSelectServeur }"
		# puts "Insert Scores : #{ listeScoresInsertServeur }"
		# puts "Udates Scores : #{ listeScoresUpdateServeur }"
		# puts "Select Scores : #{ listeSauvegardesSelectServeur }"
		# puts "Insert Scores : #{ listeSauvegardesInsertServeur }"
		# puts "Udates Scores : #{ listeSauvegardesUpdateServeur }"
		
		# On demande les ressources que l'on veux mettre à jour en locale
		serveur.recupererRessources(
			(versionUtilisateurServeur > utilisateurLocal.version),
			listeScoresSelectServeur,
			listeSauvegardesSelectServeur
		)
		
		# On met à jour l'utilisateur
		
		# On met à jour les scores
		
		# On met à jour les sauvegardes
		
		# Envoi des ressources à inserts/updates au serveur
		reponse = serveur.envoyerRessources(
			(versionUtilisateurServeur < utilisateurLocal.version),
			listeScoresInsertServeur,
			listeScoresUpdateServeur,
			listeSauvegardesInsertServeur,
			listeSauvegardesUpdateServeur
		)
		
		return true
	end
end
