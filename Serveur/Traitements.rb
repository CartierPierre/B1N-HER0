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
	# Renvoi la liste des ressource du utilisateur (sauvegarde et scores)
	#
	def listeRessources()
		return Reponse.creer(nil)
	end
	
end
