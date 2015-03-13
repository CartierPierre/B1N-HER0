load 'Grille.rb'
load 'Tuile.rb'
load 'Niveau.rb'
load 'Partie.rb'
require 'time'

class Jeu
    @partie

    private_class_method :new
    # Méthode de création d'un Jeu
    def Jeu.creer()
        new()
    end

    def initialize()
        gi = Grille.creer(6)
        gi.charger("00_________1____0___11_______0_0_1__")

        gs = Grille.creer(6)
        gs.charger("001011010011110100001101110010101100")
        niveau = Niveau.creer(
                    1,
                    2,
                    gi,
                    gs,
                    6
                )
        @partie = Partie.creer(niveau)
    end

    def jouerEn(x, y)
        @partie.jouerCoup(x, y)
    end

    def to_s()
        puts "Voici le takuzu de #{@nbL}*#{@nbC}: "
        0.upto(@partie.grille.taille() - 1) do |i|
            0.upto(@partie.grille.taille() - 1) do |j|
                print "#{@partie.grille.getTuile(i, j).etat}"
            end
            print "\n"
        end
        print "\n"
    end
end

n = Jeu.creer()
puts n
n.jouerEn(0,1)
n.jouerEn(1,0)
n.jouerEn(0,2)
n.jouerEn(0,2)
n.jouerEn(0,2)
puts n