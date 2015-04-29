##
# Classe Traitement	
#
# Version 8
#
class Traitement

	### Attributs de classe
	
	@@instance = nil
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def Traitement.instance()
		if(@@instance == nil)
			@@instance = new
		end
		
		return @@instance;
	end
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize()
	end
	
	### Méthodes d'instances
	
	##
	# Renvoi la chaîne de carractère pong en réponse
	#
	def ping( arguments )
		# Renvoi réponse au client
		return Reponse.creer( 'pong' )
	end
	
	##
	# Renvoi un utilisateur s'il a été trouvé dans la bdd
	#
	def connexionUtilisateur( arguments )
		# Lecture des arguments
		nom, motDePasse = arguments
		
		# Debug
		# puts "nom = #{ nom }"
		# puts "motDePasse = #{ motDePasse }"
		
		# Recherche de l'utilisateur
		utilisateur = GestionnaireUtilisateur.instance().connexionUtilisateur( nom, motDePasse )
		
		# Renvoi réponse au client
		return Reponse.creer( utilisateur ) 
	end
	
	##
	# Renvoi un couple identifiant/version de la totalitée des ressources d'un utilisateur
	#
	def listeRessources( arguments )
		# Lecture des arguments
		uuidUtilisateur = arguments[0]
		
		# Debug
		# puts "uuidUtilisateur = #{ uuidUtilisateur }"
		
		# Variables
		gut = GestionnaireUtilisateur.instance()
		gsc = GestionnaireScore.instance()
		gsa = GestionnaireSauvegarde.instance()
		versionUtilisateur = nil
		listeScores = nil
		listeCoupleScore = Array.new()
		listeSauvegardes = nil
		listeCoupleSauvegarde = Array.new()
		
		# Recherche de l'utilisateur
		utilisateur = gut.recupererUtilisateur( uuidUtilisateur )
		if( utilisateur == nil )
			return nil
		end
		versionUtilisateur = utilisateur.version
		
		# Recherche des scores
		listeScores = gsc.recupererListeScoreUtilisateur( utilisateur, 0, gsc.recupererNombreScoreUtilisateur( utilisateur ) )
		# puts "#{ listeScores.count } scores trouvées pour l'utilisateur #{ utilisateur.nom }"
		listeScores.each do | score |
			couple = Array.new( 2 )
			couple[0] = score.id
			couple[1] = score.version
			listeCoupleScore.push( couple )
		end
		
		# Recherche des sauvegardes
		listeSauvegardes = gsa.recupererSauvegardeUtilisateur( utilisateur, 0, gsa.recupererNombreSauvegardeUtilisateur( utilisateur ) )
		# puts "#{ listeSauvegardes.count } sauvegardes trouvées pour l'utilisateur #{ utilisateur.nom }"
		listeSauvegardes.each do | sauvegarde |
			couple = Array.new( 2 )
			couple[0] = sauvegarde.id
			couple[1] = sauvegarde.version
			listeCoupleSauvegarde.push( couple )
		end
		
		# Renvoi réponse au client
		return Reponse.creer([ versionUtilisateur, listeCoupleScore, listeCoupleSauvegarde ])
	end
	
	##
	# Renvoi l'intégralité des ressources demandées
	#
	def recupererRessources( arguments )
		# Lecture des arguments
		uuidUtilisateur, listeUuidScores, listeUuidSauvegardes = arguments
		
		# Debug
		# puts "uuidUtilisateur : #{ uuidUtilisateur }"
		# puts "listeUuidScores : #{ listeUuidScores.count }"
		# puts "listeUuidSauvegardes : #{ listeUuidSauvegardes.count }"
		
		# Variables
		gut = GestionnaireUtilisateur.instance()
		gsc = GestionnaireScore.instance()
		gsa = GestionnaireSauvegarde.instance()
		
		# Lecture de l'utilisateur
		utilisateur = ( uuidUtilisateur == nil ) ? nil : gut.recupererUtilisateur( uuidUtilisateur )
		
		# Lecture des scores
		listeScores = ( listeUuidScores == nil ) ? nil : gsc.recupererEnsembleScore( listeUuidScores )
		
		# Lecture des sauvegardes
		listeSauvegardes = ( listeUuidSauvegardes == nil ) ? nil : gsa.recupererEnsembleSauvegardes( listeUuidSauvegardes )
		
		# Renvoi réponse au client
		return Reponse.creer([ utilisateur, listeScores, listeSauvegardes ])
	end
	
	##
	# Met a jour les ressources
	#
	def envoyerRessources( arguments )
		# Lecture des arguments
		utilisateur, scores, sauvegardes = arguments
		
		# Debug
		# puts "utilisateur : #{ utilisateur.nom }"
		# puts "scores : #{ scores.count }"
		# puts "sauvegardes : #{ sauvegardes.count }"
		
		# Variables
		uuidUtilisateur = nil
		listeUuidScores = nil
		listeUuidSauvegardes = nil
		couple = nil
		
		## Utilisateur
		
		# Adaptation
		utilisateur.id = utilisateur.uuid
		
		# Sauvegarde
		begin
			GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
			uuidUtilisateur = utilisateur.id
		rescue SQLite3::ConstraintException => erreur
			uuidUtilisateur = -1
		end
		
		## Score
		listeUuidScores = Array.new()
		couple = Array.new( 2 )
		scores.each do | score |
			couple[0] = score.id # id client
			score.id = score.uuid
			score.idUtilisateur = utilisateur.id
			GestionnaireScore.instance().sauvegarderScore( score )
			couple[1] = score.id # id serveur (uuid)
			listeUuidScores.push( couple )
		end
		
		## Sauvegardes
		listeUuidSauvegardes = Array.new()
		couple = Array.new( 2 )
		sauvegardes.each do | sauvegarde |
			couple[0] = sauvegarde.id
			sauvegarde.id = sauvegarde.uuid
			sauvegarde.idUtilisateur = utilisateur.id
			GestionnaireSauvegarde.instance().sauvegarderSauvegarde( sauvegarde )
			couple[1] = sauvegarde.id
			listeUuidSauvegardes.push( couple )
		end
		
		# Renvoi réponse au client
		return Reponse.creer([ uuidUtilisateur, listeUuidScores, listeUuidSauvegardes ])
	end
	
	##
	# Supprime des ressources
	#
	def supprimerRessources( arguments )
		# Lecture des arguments
		uuidUtilisateur, listeUuidScores, listeUuidSauvegardes = arguments
		
		# Debug
		puts "uuidUtilisateur : #{ uuidUtilisateur }"
		puts "listeUuidScores : #{ listeUuidScores.count }"
		puts "listeUuidSauvegardes : #{ listeUuidSauvegardes.count }"
		
		# Suppressions
		if( uuidUtilisateur != nil )
			GestionnaireUtilisateur.instance().supprimerUtilisateur( uuidUtilisateur )
		end
		
		if( listeUuidSauvegardes != nil )
			GestionnaireScore.instance().supprimerEnsembleScores( listeUuidScores )
		end
		
		if( listeUuidSauvegardes != nil )
			GestionnaireSauvegarde.instance().supprimerEnsembleSauvegardes( listeUuidSauvegardes )
		end
		
		# Renvoi réponse au client
		return Reponse.creer( "ok" )
	end
	
	##
	# Supprimer toutes les ressources liées à un utilisateur du serveur
	#
	def supprimerTracesUtilisateur( arguments )
		# Lecture des arguments
		uuidUtilisateur = arguments
		
		# Debug
		puts "uuidUtilisateur : #{ uuidUtilisateur }"
		
		# Suppressions
		if( uuidUtilisateur != nil )
			GestionnaireUtilisateur.instance().supprimerUtilisateur( uuidUtilisateur )
		end
		
		if( listeUuidSauvegardes != nil )
			GestionnaireScore.instance().supprimerScoreUtilisateur( uuidUtilisateur )
		end
		
		if( listeUuidSauvegardes != nil )
			GestionnaireSauvegarde.instance().supprimerSauvegardeUtilisateur( uuidUtilisateur )
		end
		
		# Renvoi réponse au client
		return Reponse.creer( "ok" )
	end
	
end
