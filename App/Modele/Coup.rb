class Coup
    attr_reader :x, :y, :etat

    private_class_method :new
    def Coup.creer(x, y, etat)
        new(x, y, etat)
    end

    def initialize(x, y, etat)
        @x, @y, @etat = x, y, etat
    end
end