class VuePartie < Vue

    @tailleGrille
    @temps

    @buttonUndo
    @buttonRedo
    @buttonConseil
    @buttonRestart

    @casesJeu

    class CaseJeu < Gtk::Button
        attr_accessor :x, :y

        def initialize(x,y)
            super()
            @x,@y = x,y
        end

        def setImageTuile1()
            self.set_image(Image.new(:file => './Vue/img/CaseRouge32.png'))
        end

        def setImageTuile2()
            self.set_image(Image.new(:file => './Vue/img/CaseBleue32.png'))
        end

        def setImageTuile1Lock()
            self.set_image(Image.new(:file => './Vue/img/CaseRouge32Lock.png'))
        end

        def setImageTuile2Lock()
            self.set_image(Image.new(:file => './Vue/img/CaseBleue32Lock.png'))
        end

        def setImageTuileVide()
            self.set_image(Image.new())
        end
    end

    def initialize(modele,titre,controleur)
        super(modele,"B1N-HER0",controleur)

        boxVertMain = Box.new(:vertical)
        boxJeu = Box.new(:horizontal)
        boxFooter = Box.new(:horizontal)
        monBoutQuitter = Button.new(:stock_id => Gtk::Stock::QUIT)
        monBoutNewGame = Button.new(:label =>"Nouvelle partie")

        @tailleGrille = @modele.grille().taille()

        frame = Table.new(@tailleGrille,@tailleGrille,false)

        @casesJeu = []

        0.upto(@tailleGrille-1) do |ligne|
            0.upto(@tailleGrille-1) do |colonne|
                caseTemp = CaseJeu.new(colonne,ligne)
            	
                caseTemp.set_size_request(32, 32)

            	if @modele.grille().getTuile(colonne,ligne).etat() == 1
            		caseTemp.setImageTuile1Lock()
            	elsif @modele.grille().getTuile(colonne,ligne).etat() == 2
            		caseTemp.setImageTuile2Lock()
            	end

                caseTemp.signal_connect('clicked') { onCaseJeuClicked(caseTemp) }
            	frame.attach(caseTemp,ligne,ligne+1,colonne,colonne+1)

                @casesJeu.push(caseTemp)
            end
        end

        @temps = Label.new("0:00")

        @buttonUndo = Button.new()
        @buttonUndo.set_image(Image.new(:file => './Vue/img/undo.png'))
        @buttonRedo = Button.new()
        @buttonRedo.set_image(Image.new(:file => './Vue/img/redo.png'))
        @buttonConseil = Button.new()
        @buttonConseil.set_image(Image.new(:file => './Vue/img/conseil.png'))
        @buttonRestart = Button.new()
        @buttonRestart.set_image(Image.new(:file => './Vue/img/restart.png'))

        boxFooter.pack_start(@buttonUndo, :expand => true, :fill => false, :padding => 5)
        boxFooter.pack_start(@buttonRedo, :expand => true, :fill => false, :padding => 5)
        boxFooter.pack_start(@buttonConseil, :expand => true, :fill => false, :padding => 5)
        boxFooter.pack_start(@buttonRestart, :expand => true, :fill => false, :padding => 5)

        boxJeu.add(frame)
        boxJeu.pack_end(@temps, :expand => true, :fill => false)

        boxVertMain.add(boxJeu)
        boxVertMain.pack_end(boxFooter, :expand => true, :fill => false)

        @fenetre.add(boxVertMain)

        @buttonUndo.signal_connect('clicked')  { onBtnUndoClicked }
        @buttonRedo.signal_connect('clicked')  { onBtnRedoClicked }
        @buttonConseil.signal_connect('clicked')  { onBtnConseilClicked }
        @buttonRestart.signal_connect('clicked')  { onBtnRestartClicked }

        self.actualiser()
    end

    def onBtnUndoClicked

    end

    def onBtnRedoClicked

    end

    def onBtnConseilClicked

    end

    def onBtnRestartClicked

    end

    def onCaseJeuClicked(caseJeu)
        if @modele.niveau().tuileValide?(caseJeu.x,caseJeu.y)

            @modele.jouerCoup(caseJeu.x,caseJeu.y)

            if (@modele.grille().getTuile(caseJeu.x,caseJeu.y).etat() == 1)
                caseJeu.setImageTuile1()
            elsif (@modele.grille().getTuile(caseJeu.x,caseJeu.y).etat() == 2)
                caseJeu.setImageTuile2()
            else
                caseJeu.setImageTuileVide()
            end      

            self.actualiser()
            
        end
    end

end