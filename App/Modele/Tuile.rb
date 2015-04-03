class Tuile
    attr_accessor :etat

    private_class_method :new
    # Méthode de création de création d'une tuile
    def Tuile.creer()
        new()
    end

    def initialize()
        @etat = Etat.vide
    end
end