load 'Coup.rb'
load 'Score.rb'
load 'Utilisateur.rb'
load 'Grille.rb'
load 'Tuile.rb'
load 'Niveau.rb'
load 'Partie.rb'

class Jeu
    @partie

    private_class_method :new
    # Méthode de création d'un Jeu
    def Jeu.creer()
        new()
    end

    def initialize()
        niveau = Niveau.creer(
                    1,
                    2,
                    Grille.creer(6).charger("00_________1____0___11_______0_0_1__"),
                    Grille.creer(6).charger("001011010011110100001101110010101100"),
                    1,
                    6
                )
        @partie = Partie.creer( Utilisateur.creer(1, 1, "Mr Test", "root", Time.new(), Time.new(), 1, 2, 3), niveau)
    end

    def jouerEn(x, y)
        @partie.jouerCoup(x, y)
    end

    def test()
        @partie.historiqueUndo()
    end

    def to_s()
        puts "Voici le takuzu: "
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
n.jouerEn(1,1)
n.jouerEn(1,1)
puts n
n.test()
puts n