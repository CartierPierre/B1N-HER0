##
# La classe GestionnaireSauvegarde permet d'intéragir avec entitées Sauvegarde
# Utilise le DP Singleton
#
# Version 1
#
# Résoudre le problème des private_class_method
# Passer la connexion BDD par une instance unique
#
class GestionnaireSauvegarde
	
	### Attributs de classe
	
	@@instance = nil
	
	
	### Attributs d'instances
	
	@bddLocal = nil
	
	
	### Méthodes de classe
	
	##
	# Renvoi l'instance unique de la classe
	#
	def GestionnaireSauvegarde.instance
		if(@@instance == nil)
			@@instance = new
		end
		
		return @@instance;
	end
	
	
	### Méthodes d'instances
	
	##
	# Constructeur
	#
	private_class_method :new
	def initialize
		@bddLocal = SQLite3::Database.new('./bdd-test.sqlite')
	end
	
end
