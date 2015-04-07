##
# Classe Score
#
# Version 4
#
class Score

    ### Attributs d'instances

    attr_reader :id, :uuid, :idUtilisateur, :idNiveau
    attr_accessor :tempsTotal, :nbCoups, :nbConseils, :nbAides,

    ### Méthodes de classe

    ##
    # Instancie un score
    #
    def Score.creer(*args)
        case args.size
            when 0
                new(nil, nil, nil, nil, nil, nil, nil, nil)
            when 6
                new(nil, nil, args[0], args[1], args[3], args[4], args[5], args[6])
            when 8
                new(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7])
            else
                puts "Score.creer n'accepte que O, 6 ou 8 arguments"
        end
    end

    ##
    # Constructeur
    #
    private_class_method :new
    def initialize(id, uuid, tempsTotal, nbCoups, nbConseils, nbAides, idUtilisateur, idNiveau)

        # int
        # Identifiant du score
        @id = id

        # int
        # Identifiant universel unique du score
        @uuid = uuid

        # int
        # Temps qu'il a fallut au joueur pour résoudre le problème
        @tempsTotal = tempsTotal

        # int
        # Nombre de coups joué lors de la partie
        @nbCoups = nbCoups

        # int
        # Nombre de conseils demandées lors de la partie
        @nbConseils = nbConseils

        # int
        # Nombre d'aides demandées lors de la partie
        @nbAides = nbAides

        # int
        # Identifiant de l'utilisateur à qui appartient se score
        @idUtilisateur = idUtilisateur

        # int
        # Identifiant du niveau sur lequel porte le score
        @idNiveau = idNiveau

    end

    ### Méthodes d'instances

    ##
    # Renvoi le nombre de point du score
    #
    def nbPoints(niveau)
        return (
            ( niveau.dimention ** niveau.difficulte ) / ( 1 + @tempsTotal + ( 2 ** @nbConseils) * 10 + ( 2 ** @nbAides ) * 30 + ( @nbCoups / 10 ) ** 2 )
        )
    end

end
