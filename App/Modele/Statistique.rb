##
# Classe statistiqe
#
# Version 1
#
class Statistique
	
	### Attributs d'instances
	
	@utilisateur
	@nbCoups
	@nbConseils
	@nbAides
	@tempsTotal
	@scoreTotal
	@nbGrillesReso
	
	attr_reader :nbCoups, :nbConseils, :nbAides, :tempsTotal, :scoreTotal, :nbGrillesReso
	
	### Méthodes de classe
	
	def initialize(utilisateur)
		@utilisateur = utilisateur
		@nbCoups = nil
		@nbConseils = nil
		@nbAides = nil
		@tempsTotal = nil
		@scoreTotal = nil
		@nbGrillesReso = nil
	end
	
	def Statistique.creer(utilisateur)
		new(utilisateur)
	end
	
	### Méthodes d'instance
	
	def mettreAJour()
		
		@nbCoups = 0
		@nbConseils = 0
		@nbAides = 0
		@tempsTotal = 0
		@scoreTotal = 0
		@nbGrillesReso = 0
		
		gs = GestionnaireScore.instance()
		gn = GestionnaireNiveau.instance()
		
		@nbGrillesReso = gs.recupererNombreScoreUtilisateur(@utilisateur)
		scores = gs.recupererListeScoreUtilisateur(@utilisateur, 0, @nbGrillesReso)
		
		scores.each do |score|
			@nbCoups = @nbCoups + score.nbCoups
			@nbConseils = @nbConseils + score.nbConseils
			@nbAides = @nbAides + score.nbAides
			@tempsTotal = @tempsTotal + score.tempsTotal
			niveau = gn.recupererNiveau(score.idNiveau)
			@scoreTotal = @scoreTotal + score.nbPoints(niveau)
		end
		
	end
	
end
