class Tuile
    attr_accessor :etat

    private_class_methode :new
    #Méthode de création de création d'une tuile
    def Tuile.creer()
        new()
    end

    def initiliaze()
        @etat = 0
    end
def