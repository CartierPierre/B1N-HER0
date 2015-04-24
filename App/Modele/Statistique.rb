##
# Classe statistiqe
#
# Version 2
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
	@partieParfaites
	@succes
	
	attr_reader :nbCoups, :nbConseils, :nbAides, :tempsTotal, :scoreTotal, :nbGrillesReso, :partieParfaites, :succes
	
	### Méthodes de classe
	
	##
	# Constructeur
	#
	def initialize(utilisateur)
		@utilisateur = utilisateur
		@nbCoups = nil
		@nbConseils = nil
		@nbAides = nil
		@tempsTotal = nil
		@scoreTotal = nil
		@nbGrillesReso = nil
	    @partieParfaites = nil
		@succes = nil
	end
	private_class_method :new
	
	##
	# Instancie un objet statistique
	#
	def Statistique.creer(utilisateur)
		new(utilisateur)
	end
	
	### Méthodes d'instance
	
	##
	# Calcule les statistiques du joueur et sauvegarde le résultat dans les attributs de l'objet
	#
	def mettreAJour()
		
		# RAZ des attributs
		@nbCoups = 0
		@nbConseils = 0
		@nbAides = 0
		@tempsTotal = 0
		@scoreTotal = 0
		@nbGrillesReso = 0
	    @partieParfaites = 0
		@succes = []
		
		# Récupération des geetionnaires d'entitées
		gs = GestionnaireScore.instance()
		gn = GestionnaireNiveau.instance()
		
		# Lecture des scores de l'utilisateur
		@nbGrillesReso = gs.recupererNombreScoreUtilisateur(@utilisateur)
		scores = gs.recupererListeScoreUtilisateur(@utilisateur, 0, @nbGrillesReso)
		
		# Calcul des statistiques
		scores.each do |score|
		
			@nbCoups = @nbCoups + score.nbCoups
			@nbConseils = @nbConseils + score.nbConseils
			@nbAides = @nbAides + score.nbAides
			@tempsTotal = @tempsTotal + score.tempsTotal
			
			niveau = gn.recupererNiveau(score.idNiveau)
			@scoreTotal = @scoreTotal + score.nbPoints(niveau)
			
			if( score.nbAides == 0 && score.nbConseils == 0 )
				@partieParfaites = @partieParfaites + 1
			end
			
		end
		
		# Succès
		
		if( @nbGrillesReso == 10 )
			@succes.push( Succes::S_10_PARTIES )
		end
		
		if( @nbGrillesReso == 50 )
			@succes.push( Succes::S_50_PARTIES )
		end
		
		if( @nbGrillesReso == 100 )
			@succes.push( Succes::S_100_PARTIES )
		end
		
		if( @nbGrillesReso == 500 )
			@succes.push( Succes::S_500_PARTIES )
		end
		
		if( @nbGrillesReso == 1000 )
			@succes.push( Succes::S_1000_PARTIES )
		end
		
		if( @partieParfaites == 10 )
			@succes.push( Succes::S_10_PARFAIT )
		end
		
		if( @partieParfaites == 50 )
			@succes.push( Succes::S_50_PARFAIT )
		end
		
		if( @partieParfaites == 100 )
			@succes.push( Succes::S_100_PARFAIT )
		end
		
		if( @partieParfaites == 500 )
			@succes.push( Succes::S_500_PARFAIT )
		end
		
		if( @partieParfaites == 1000 )
			@succes.push( Succes::S_1000_PARFAIT )
		end
		
	end
	
end
