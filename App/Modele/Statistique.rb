##
# Classe statistiqe
#
# Version 1
#
class Statistique
	
	### Attributs d'instances
	
	@utilisateur
	
	### M�thodes de classe
	
	def initialize(utilisateur)
		@utilisateur = utilisateur
	end
	
	def Statistique.creer(utilisateur)
		new(utilisateur)
	end
	
	### M�thodes d'instance
	
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
