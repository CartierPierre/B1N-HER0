class VuePartie < Vue

    @tailleGrille
    @temps

    # Boutons du menu de navigation
    @buttonMenu

    # Boutons du menu en haut
    @buttonHypothese
    @buttonValiderHypo
    @buttonAnnulerHypo

    # Boutons du menu en bas
    @buttonUndo
    @buttonRedo
    @buttonConseil
    @buttonRestart

    @casesJeu

    @imageTuile1
    @imageTuile2

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

        @tailleGrille = @modele.grille().taille()

        # Navigation
        boxNav = Box.new(:horizontal)
        @buttonMenu = Button.new()
        @buttonMenu.set_image(Image.new(:file => './Vue/img/menu.png'))
        boxNav.add(@buttonMenu)
        boxNav.add(Label.new("Niveau 1" + " - " + @tailleGrille.to_s() + "x" + @tailleGrille.to_s()))

        # Menu du haut
        boxHeader = Box.new(:horizontal)
        @buttonHypothese = Button.new(:label => "Hypothèse", :mnemonic => "H")
        @buttonHypothese.set_image(Image.new(:file => './Vue/img/hypothese.png'))
        @buttonValiderHypo = Button.new(:label => "Valider", :mnemonic => nil)
        @buttonValiderHypo.set_image(Image.new(:file => './Vue/img/valider.png'))
        @buttonAnnulerHypo = Button.new(:label => "Annuler", :mnemonic => nil)
        @buttonAnnulerHypo.set_image(Image.new(:file => './Vue/img/annuler.png'))

        boxHeader.pack_start(@buttonHypothese, :expand => true, :fill => false, :padding => 5)
        boxHeader.pack_start(@buttonValiderHypo, :expand => true, :fill => false, :padding => 5)
        boxHeader.pack_start(@buttonAnnulerHypo, :expand => true, :fill => false, :padding => 5)

        @imageTuile1 = Image.new(:file => './Vue/img/CaseRouge32.png')
        @imageTuile2 = Image.new(:file => './Vue/img/CaseBleue32.png')

        # Création de la grille
        boxJeu = Box.new(:horizontal)
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

        boxJeu.add(frame)
        boxJeu.pack_end(@temps, :expand => true, :fill => false)

        # Menu du bas
        boxFooter = Box.new(:horizontal)
        @buttonUndo = Button.new(:label => "Annuler", :mnemonic => "Z")
        @buttonUndo.set_image(Image.new(:file => './Vue/img/undo.png'))
        @buttonRedo = Button.new(:label => "Répéter", :mnemonic => "Y")
        @buttonRedo.set_image(Image.new(:file => './Vue/img/redo.png'))
        @buttonConseil = Button.new(:label => "Conseil", :mnemonic => "C")
        @buttonConseil.set_image(Image.new(:file => './Vue/img/conseil.png'))
        @buttonRestart = Button.new(:label => "Recommencer", :mnemonic => "R")
        @buttonRestart.set_image(Image.new(:file => './Vue/img/restart.png'))

        @buttonUndo.signal_connect('clicked')  { onBtnUndoClicked }
        @buttonRedo.signal_connect('clicked')  { onBtnRedoClicked }
        @buttonConseil.signal_connect('clicked')  { onBtnConseilClicked }
        @buttonRestart.signal_connect('clicked')  { onBtnRestartClicked }

        boxFooter.pack_start(@buttonUndo, :expand => true, :fill => false, :padding => 5)
        boxFooter.pack_start(@buttonRedo, :expand => true, :fill => false, :padding => 5)
        boxFooter.pack_start(@buttonConseil, :expand => true, :fill => false, :padding => 5)
        boxFooter.pack_start(@buttonRestart, :expand => true, :fill => false, :padding => 5)

        # Ajout dans la box principal des éléments
        boxVertMain.add(boxNav)
        boxVertMain.add(boxHeader)
        boxVertMain.add(boxJeu)
        boxVertMain.pack_end(boxFooter, :expand => true, :fill => false)

        @fenetre.add(boxVertMain)

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