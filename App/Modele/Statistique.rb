##
# Classe statistiqe
#
# Version 1
#
class Statistique
	
	### Attributs d'instances
	
	@utilisateur
	
	### Méthodes de classe
	
	def initialize(utilisateur)
		@utilisateur = utilisateur
	end
	
	def Statistique.creer(utilisateur)
		new(utilisateur)
	end
	
	### Méthodes d'instance
	
	def nbCoups()
		return 0
	end
	
	def nbConseils()
		return 0
	end
	
	def nbAides()
		return 0
	end
	
	def tempsTotal()
		return 0
	end
	
	def scoreTotal()
		return 0
	end
	
	def nbGrillesReso()
		return 0
	end
	
end
