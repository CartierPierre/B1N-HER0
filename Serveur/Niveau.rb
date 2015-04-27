##
# Classe Niveau
#
# Version 1
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
    def Niveau.creer( id, probleme, solution, difficulte, dimention )
		new( id, probleme, solution, difficulte, dimention )
    end
	
	##
	# Constructeur
	#
    def initialize( id, probleme, solution, difficulte, dimention )
		@id = id
		@probleme = probleme
		@solution = solution
		@difficulte = difficulte
		@dimention = dimention
    end
	private_class_method :new
	
end
