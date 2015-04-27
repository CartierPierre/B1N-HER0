##
# Classe Traitement	
#
# Version 2
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
	def ping()
		return Reponse.creer('pong')
	end
	
	##
	# Renvoi un couple identifiant/version de la totalitée des ressources d'un utilisateur
	#
	def listeRessources()
		return Reponse.creer([
			1, # version utilisateur
			[
				[12, 4],
				[20, 6]
			], # uuid/version scores
			[
				[123, 1],
				[20, 62]
			] # uuid/version sauvegardes
		])
	end
	
	##
	# Renvoi l'intégralité des ressources demandées
	#
	def recupererRessources()
		return Reponse.creer([
			[
				12,
				1235465,
				'toto',
				'azrty',
				'Serial'
			], # Utilisateur
			[
				'sauvegardes'
			], # Sauvegardes
			[
				'scores'
			] # Scores
		])
	end
	
	##
	# Met a jour les ressources
	#
	def envoyerRessources()
		return Reponse.creer( 'succes' )
	end
	
end
