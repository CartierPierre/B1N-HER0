##
# Classe Traitement	
#
# Version 1
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
	#
	#
	def ping()
		return Reponse.creer('pong')
	end
	
end
