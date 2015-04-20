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
#001100001100____0___11_______0_0_1__ pour tester regle trois
class Jeu
    @partie
    @niveau

    private_class_method :new
    # Méthode de création d'un Jeu
    def Jeu.creer()
        new()
    end

    def initialize()
        @niveau = Niveau.creer( 1, 2, Grille.charger("00_________1____0___11_______0_0_1__"), Grille.charger("001011010011110100001101110010101100"), 1, 6)
        @partie = Partie.creer( "lol", @niveau)#Utilisateur.creer("Mr Test", "root", 3), niveau)
    end

    def jouerEn(x, y)
        @partie.jouerCoup(x, y)
    end

    def test()
        # #Joue avant hypothese
        @partie.jouerCoup(3, 0)
        @partie.jouerCoup(5, 0)
        @partie.jouerCoup(1, 0)

        # #Activation de l'hypothese
        # @partie.activerModeHypothese()
        # @partie.activerModeHypothese()
        # @partie.monitor()

        # #Joue dans l'hypothése
        # @partie.jouerCoup(1, 1)
        # @partie.jouerCoup(1, 1)
        # @partie.jouerCoup(2, 1)
        # @partie.jouerCoup(1, 2)
        # @partie.jouerCoup(3, 1)
        # @partie.jouerCoup(3, 1)

        # #Valide l'hypothése
        # # @partie.annulerHypothese()
        # # @partie.monitor

        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueUndo()
        # # @partie.historiqueRedo()
        # # @partie.monitor

        # p @partie.sauvegarder
        # @partie = Partie.charger("lol", @niveau, @partie.sauvegarder)
        # @partie.monitor
        # @partie.annulerHypothese()
        @partie.monitor

        p @partie.appliquerRegles()
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
		print RegleTrois.appliquer(@partie)
		print "\n"	
    end
end

n = Jeu.creer()
n.test()