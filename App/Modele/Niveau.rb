##
# Classe Niveau
#
# Version 1
#
# La dimention ne pourrait elle pas être lu depuis l'attribut problème ?
#
class Niveau

	### Attributs d'instances
	
    attr_reader :id, :uuid, :probleme, :solution, :difficulte, :dimention
	
	### Méthodes de classe
	
	##
	# Instancie une niveau
	#
    def Niveau.creer(*args)
		case args.size
			when 0
				new(nil, nil, nil, nil, nil, nil)
			when 4
				new(nil, nil, args[0], args[1], args[3], args[4])
			when 6
				new(args[0], args[1], args[2], args[3], args[4], args[5])
			else
				puts "Niveau.creer n'accepte que O, 4 ou 6 arguments"
        end
    end
	
	##
	# Constructeur
	#
	private_class_method :new
    def initialize(id, uuid, probleme, solution, difficulte, dimention)
	
		# int
		# Identifiant du niveau
        @id = id
		
		# uuid
		# Identifiant universel unique du niveau
		@uuid = uuid
		
		# Grille
		# Object Grille contenant un prolème Takuzu
		@probleme = probleme
		
		# Grille
		# Object grille contenant la solution au problème
		@solution = solution
		
		# int
		# Difficulté du Problème
		@difficulte = difficulte
		
		# int
		# Dimention de la grille
		@dimention = dimention
		
    end
	
	### Méthodes d'instances

    # Test si la grille est une grille valide
    #
    # === Arguments
    # *x* - 
    # def tuileValide?(x, y)
        # return @grilleInitial.getTuile(x, y).etat == 0
    # end
	
end