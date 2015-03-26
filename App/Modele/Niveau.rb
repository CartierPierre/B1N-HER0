class Niveau
    attr_reader :id, :uuid, :grilleInitial, :grilleSolution, :difficulte, :taille

    private_class_method :new

    def Niveau.creer(id, uuid, grilleInitial, grilleSolution, difficulte, taille)
        new(id, uuid, grilleInitial, grilleSolution, difficulte, taille)
    end

    def initialize(id, uuid, grilleInitial, grilleSolution, difficulte, taille)
        @id, @uuid, @grilleInitial, @grilleSolution, @difficulte, @taille = id, uuid, grilleInitial, grilleSolution, difficulte, taille
    end

    # Test si la grille est une grille valide
    #
    # === Arguments
    # *x* - 
    def tuileValide?(x, y)
        return @grilleInitial.getTuile(x, y).etat == 0
    end
end