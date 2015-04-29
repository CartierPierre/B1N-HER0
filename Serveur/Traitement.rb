##
# Classe Traitement	
#
# Version 4
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
		listeUuidScores = Array.new()
		listeSauvegardes = nil
		listeUuidSauvegardes = Array.new()
		
		# Recherche de l'utilisateur
		utilisateur = gut.recupererUtilisateur( uuidUtilisateur )
		if( utilisateur == nil )
			return nil
		end
		versionUtilisateur = utilisateur.version
		
		# Recherche des scores
		listeScores = gsc.recupererListeScoreUtilisateur( utilisateur, 0, gsc.recupererNombreScoreUtilisateur( utilisateur ) )
		listeScores.each do | score |
			listeUuidScores.push( Array.new( score.id, score.version ) )
		end
		
		# Recherche des sauvegardes
		listeSauvegardes = gsa.recupererSauvegardeUtilisateur( utilisateur, 0, gsa.recupererNombreSauvegardeUtilisateur( utilisateur ) )
		listeSauvegardes.each do | sauvegarde |
			listeUuidScores.push( Array.new( sauvegarde.id, sauvegarde.version ) )
		end
		
		
		# Renvoi réponse au client
		return Reponse.creer([ versionUtilisateur, listeUuidScores, listeUuidSauvegardes ])
	end
	
	##
	# Renvoi l'intégralité des ressources demandées
	#
	def recupererRessources( arguments )
		# Lecture des arguments
		uuidUtilisateur, listeUuidScores, listeUuidSauvegardes = arguments
		
		# Debug
		# puts "uuidUtilisateur = #{ uuidUtilisateur }"
		# puts "listeUuidScores = #{ listeUuidScores }"
		# puts "listeUuidSauvegardes = #{ listeUuidSauvegardes }"
		
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
		puts "utilisateur = #{ utilisateur }"
		puts "scores = #{ scores }"
		puts "sauvegardes = #{ sauvegardes }"
		
		# Variables
		uuidUtilisateur = nil
		listeUuidScores = nil
		listeUuidSauvegardes = nil
		tmp = nil
		
		# Si un utilisateur est transmit
		if( utilisateur != nil )
			utilisateur.id = utilisateur.uuid
			begin
				GestionnaireUtilisateur.instance().sauvegarderUtilisateur( utilisateur )
				uuidUtilisateur = utilisateur.id # Sauvegarde de l'id serveur de la ressource (uuid)
			rescue SQLite3::ConstraintException => erreur
				uuidUtilisateur = -1 # On indique l'erreur au client
			end
		end
		
		# Si des scores sont transmits
		if( scores != nil )
			listeUuidScores = Array.new()
			tmp = Array.new( 2 )
			scores.each do | score |
				tmp[0] = score.id
				score.id = score.uuid
				GestionnaireScore.instance().sauvegarderScore( score )
				tmp[1] = score.id
				listeUuidScores.push( tmp )
			end
		end
		
		# Si des sauvegardes sont transmises
		if( sauvegardes != nil )
			listeUuidSauvegardes = Array.new()
			tmp = Array.new( 2 )
			sauvegardes.each do | sauvegarde |
				tmp[0] = sauvegarde.id
				sauvegarde.id = sauvegarde.uuid
				GestionnaireSauvegarde.instance().sauvegarderSauvegarde( sauvegarde )
				tmp[1] = sauvegarde.id
				listeUuidSauvegardes.push( tmp )
			end
		end
		
		# Renvoi réponse au client
		return Reponse.creer([ uuidUtilisateur, listeUuidScores, listeUuidSauvegardes ])
	end
	
end
