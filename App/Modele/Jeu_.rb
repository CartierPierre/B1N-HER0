load 'Grille.rb'
load 'Tuile.rb'

class Jeu
    @grille

    private_class_method :new
    # Méthode de création d'un Jeu
    def Jeu.creer()
        new()
    end

    def initialize()
        @grille = Grille.creer(6)
    end

    def jouerEn(x, y)
        @grille.setTuile(x, y, 1)
    end

    def to_s()
        puts "Voici le takuzu de #{@nbL}*#{@nbC}: "
        0.upto(@grille.taille() - 1) do |i|
            0.upto(@grille.taille() - 1) do |j|
                print "#{@grille.getTuile(i, j).etat}"
            end
            print "\n"
        end
        print "\n"
    end
end

n = Jeu.creer()
puts n
n.jouerEn(2,3)
puts n