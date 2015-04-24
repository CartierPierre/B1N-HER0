##
# Classe Niveau
#
# Version 4
#
class Niveau

	### Attributs d'instances
	
	# int
	# Identifiant du niveau
	@id

	# Grille
	# Object Grille contenant un prolème Takuzu
	@probleme

	# Grille
	# Object grille contenant la solution au problème
	@solution

	# int
	# Difficulté du problème
	@difficulte

	# int
	# Dimention de la grille
	@dimention
	
    attr_accessor :id, :probleme, :solution, :difficulte, :dimention
	
	### Méthodes de classe
	
	##
	# Instancie une niveau
	#
    def Niveau.creer(*args)
		case args.size
			# when 0 # Vide
				# new(nil, nil, nil, nil, nil)
			when 4 # Utilisateur
				new(nil, args[0], args[1], args[2], args[3])
			when 5 # Gestionnaire
				new(args[0], args[1], args[2], args[3], args[4])
			else
				puts "Niveau.creer n'accepte que O, 4 ou 5 arguments"
        end
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, probleme, solution, difficulte, dimention)
		@id = id
		@probleme = probleme
		@solution = solution
		@difficulte = difficulte
		@dimention = dimention
    end
	
	### Méthodes d'instances

    # Test si la grille est une grille valide
    #
    # === Arguments
    # *x* - 
    def tuileValide?(x, y)
        return @probleme.getTuile(x, y).etat == 0
    end
	
end
