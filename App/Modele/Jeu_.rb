load 'Coup.rb'
load 'Score.rb'
load 'Utilisateur.rb'
load 'Grille.rb'
load 'Tuile.rb'
load 'Niveau.rb'
load 'Partie.rb'
load 'Etat.rb'
load 'Chrono.rb'
load 'RegleUn.rb'
load 'RegleDeux.rb'
load 'RegleTrois.rb'
#001100001100____0___11_______0_0_1__
#Grille.charger("00_________1____0___11_______0_0_1__
class Jeu
    @partie

    private_class_method :new
    # Méthode de création d'un Jeu
    def Jeu.creer()
        new()
    end

    def initialize()
        niveau = Niveau.creer( 1, 2, Grille.charger("000100001100____0___11_______0_0_1__"), Grille.charger("001011010011110100001101110010101100"), 1, 6)
        @partie = Partie.creer( "lol", niveau)#Utilisateur.creer("Mr Test", "root", 3), niveau)
    end

    def jouerEn(x, y)
        @partie.jouerCoup(x, y)
    end

    def test()
        jouerEn(1, 1)
        jouerEn(1, 1)
        jouerEn(1, 2)
        jouerEn(1, 3)
        jouerEn(1, 3)
        @partie.historiqueUndo
        @partie.historiqueUndo
        @partie.historiqueUndo
        @partie.historiqueUndo
        @partie.historiqueUndo
        @partie.historiqueUndo
        @partie.monitor
        p @partie.sauvegarder
        @partie = Partie.charger("lol", Niveau.creer( 1, 2, Grille.charger("00_________1____0___11_______0_0_1__"), Grille.charger("001011010011110100001101110010101100"), 1, 6), @partie.sauvegarder)
        @partie.monitor
        @partie.historiqueRedo
        @partie.historiqueRedo
        @partie.historiqueRedo
		TestRegleUn()
		TestRegleDeux()
		TestRegleTrois()
		self.to_s()
    end

    def to_s()
        0.upto(@partie.grille.taille() - 1) do |i|
            0.upto(@partie.grille.taille() - 1) do |j|
                print "#{@partie.grille.getTuile(i, j).etat}"
            end
            print "\n"
        end
        print "\n"
    end
    
    def TestRegleUn()
    	if RegleUn.appliquer(@partie) == true then
			print "regle un true\n"
		else
			print "regle un false\n"
		end
    end
    
    def TestRegleDeux()
    	if RegleDeux.appliquer(@partie) == true then
			print "regle deux true\n"
		else
			print "regle deux false\n"
		end
    end
    
    def TestRegleTrois()
    	if RegleTrois.appliquer(@partie) == true then
			print "regle trois true\n"
		else
			print "regle trois false\n"
		end
    end
end

n = Jeu.creer()
n.test()