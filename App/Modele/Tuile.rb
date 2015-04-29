##
# La classe Tuile permet de créer et utiliser des tuiles.
#

class Tuile
    # Etat de la Tuile.
    attr_accessor :etat

    private_class_method :new
    ##
    # Méthode de création d'une tuile.
    #
    def Tuile.creer()
        new()
    end

    def initialize() #:notnew:
        @etat = Etat.vide
    end

    ##
    # Indique si une tuile est vide.
    #
    # Retour::
    #   Un booléen qui indique si la case est vide.
    #
    def estVide?()
        return etat == Etat.vide
    end
end