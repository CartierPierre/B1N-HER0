##
# Classe Score
#
# Version 1
#
class Score

    ### Attributs d'instances

	# int
	# Identifiant du score
	@id

	# int
	# Version de l'entitée
	@version

	# int
	# Temps qu'il a fallut au joueur pour résoudre le problème
	@tempsTotal

	# int
	# Nombre de coups joué lors de la partie
	@nbCoups

	# int
	# Nombre de conseils demandées lors de la partie
	@nbConseils

	# int
	# Nombre d'aides demandées lors de la partie
	@nbAides

	# int
	# Identifiant de l'utilisateur à qui appartient se score
	@idUtilisateur

	# int
	# Identifiant du niveau sur lequel porte le score
	@idNiveau

	attr_accessor :id, :version, :tempsTotal, :nbCoups, :nbConseils, :nbAides, :idUtilisateur, :idNiveau

    ### Méthodes de classe

    ##
    # Instancie un score
    #
    def Score.creer(*args)
        case args.size
            when 0 # Vide
                new(nil, nil, nil, nil, nil, nil, nil, nil)
            when 8 # Gestionnaire
                new(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7])
            else
                puts "Score.creer n'accepte que O ou 8 arguments"
        end
    end

    ##
    # Constructeur
    #
    private_class_method :new
    def initialize(id, version, tempsTotal, nbCoups, nbConseils, nbAides, idUtilisateur, idNiveau)
		@id = id
		@version = version;
		@tempsTotal = tempsTotal
		@nbCoups = nbCoups
		@nbConseils = nbConseils
		@nbAides = nbAides
		@idUtilisateur = idUtilisateur
		@idNiveau = idNiveau
    end

    ### Méthodes d'instances

    ##
    # Renvoi le nombre de point du score
    #
    def nbPoints(niveau)
        return (
            ( (niveau.dimention**2) * (niveau.difficulte**2) * 10000 ) / ( @tempsTotal + ( 2 ** @nbConseils) * 10 - 39 + ( 2 ** @nbAides ) * 30 + ( @nbCoups / 10 ) ** 2 )
        )
    end

end
