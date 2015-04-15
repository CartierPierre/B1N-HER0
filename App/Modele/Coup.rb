##
# La classe Coup permet de créer et utiliser des coups.

class Coup
    attr_reader :x, :y
    attr_accessor :etat

    ##
    # Méthode de création d'un Coup.
    #
    # Paramétres::
    #   * _x_ - La coordonnée x du Coup.
    #   * _y_ - La coordonnée y du Coup.
    #   * _etat_ - L'état de la Tuile avant le Coup.
    private_class_method :new
    def Coup.creer(x, y, etat)
        new(x, y, etat)
    end

    def initialize(x, y, etat)
        @x, @y, @etat = x, y, etat
    end

    def to_s
        return "Coup x = #{@x} y = #{@y} etat = #{@etat}"
    end
end
