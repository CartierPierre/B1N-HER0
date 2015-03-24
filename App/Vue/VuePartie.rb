class VuePartie < Vue

    @tailleGrille
    @temps

    @buttonUndo
    @buttonRedo
    @buttonConseil
    @buttonRestart

    @buttonsJeu

    def initialize(modele,titre,controleur)
        super(modele,"B1N-HER0",controleur)

        boxVertMain = Box.new(:vertical)
        boxJeu = Box.new(:horizontal)
        boxFooter = Box.new(:horizontal)
        monBoutQuitter = Button.new(:stock_id => Gtk::Stock::QUIT)
        monBoutNewGame = Button.new(:label =>"Nouvelle partie")

        @tailleGrille = @modele.taille()

        frame = Table.new(@tailleGrille,@tailleGrille,false)

        @buttonsJeu = []
        i = 0
        j = 0
        colonne = 0
        0.upto((@tailleGrille*@tailleGrille)-1) do |a|
        	@buttonsJeu.push(Button.new())
            @buttonsJeu.last.set_size_request(32, 32)
        	if @modele.getTuile(j,i).etat() == 1
        		@buttonsJeu.last.set_image(Image.new(:file => './Vue/img/CaseBleue32.png'))
        	elsif @modele.getTuile(j,i).etat() == 2
        		@buttonsJeu.last.set_image(Image.new(:file => './Vue/img/CaseRouge32.png'))
        	end
        	frame.attach(@buttonsJeu.last,i,i+1,j,j+1)
        	i += 1
        	if i >= @tailleGrille
        		i = 0
        		j += 1
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

end