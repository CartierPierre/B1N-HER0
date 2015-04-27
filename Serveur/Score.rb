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
    def Score.creer( id, version, tempsTotal, nbCoups, nbConseils, nbAides, idUtilisateur, idNiveau )
		new( id, version, tempsTotal, nbCoups, nbConseils, nbAides, idUtilisateur, idNiveau )
    end

    ##
    # Constructeur
    #
    def initialize( id, version, tempsTotal, nbCoups, nbConseils, nbAides, idUtilisateur, idNiveau )
		@id = id
		@version = version;
		@tempsTotal = tempsTotal
		@nbCoups = nbCoups
		@nbConseils = nbConseils
		@nbAides = nbAides
		@idUtilisateur = idUtilisateur
		@idNiveau = idNiveau
    end
	private_class_method :new

end
