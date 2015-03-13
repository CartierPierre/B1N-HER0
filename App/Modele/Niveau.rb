class Niveau
    attr_reader :id, :uuid, :grilleInitial, :grilleSolution, :difficulte, :taille

    private_class_method :new

    def Niveau.creer(id, uuid, grilleInitial, grilleSolution, taille)
        new(id, uuid, grilleInitial, grilleSolution, taille)
    end

    def initialize(id, uuid, grilleInitial, grilleSolution, taille)
        @id, @uuid, @grilleInitial, @grilleSolution, @taille = id, uuid, grilleInitial, grilleSolution, taille
    end

    def tuileValide?(x, y)
        return @grilleInitial.getTuile(x, y).etat == 0
    end
end