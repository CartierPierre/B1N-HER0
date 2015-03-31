class VuePartie < Vue

    @tailleGrille
    @temps

    # Boutons du menu de navigation
    @buttonSave
    @buttonLoad
    @buttonOptions
    @buttonRegles
    @buttonQuitter

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
            self.set_size_request(32, 32)
        end

        def setImageTuile(etat)
            if (etat == 1)
                self.set_image(Image.new(:file => './Vue/img/CaseRouge32.png'))
            elsif (etat == 2)
                self.set_image(Image.new(:file => './Vue/img/CaseBleue32.png'))
            else
                self.set_image(Image.new())
            end    
        end

        def setImageTuile1Lock()
            self.set_image(Image.new(:file => './Vue/img/CaseRouge32Lock.png'))
        end

        def setImageTuile2Lock()
            self.set_image(Image.new(:file => './Vue/img/CaseBleue32Lock.png'))
        end
    end

    def initialize(modele,titre,controleur)
        super(modele,"B1N-HER0",controleur)

        boxVertMain = Box.new(:vertical)

        @tailleGrille = @modele.grille().taille()

        # Navigation
        boxNav = Box.new(:horizontal)

        @buttonSave = Button.new(:label => @langue.langueActuelle[:sauvegarder], :mnemonic => nil)
        @buttonSave.set_image(Image.new(:file => './Vue/img/save.png'))
        @buttonLoad = Button.new(:label => @langue.langueActuelle[:charger], :mnemonic => nil)
        @buttonLoad.set_image(Image.new(:file => './Vue/img/load.png'))
        @buttonOptions = Button.new(:label => @langue.langueActuelle[:options], :mnemonic => nil)
        @buttonOptions.set_image(Image.new(:file => './Vue/img/options.png'))
        @buttonRegles = Button.new(:label => @langue.langueActuelle[:regles], :mnemonic => nil)
        @buttonRegles.set_image(Image.new(:file => './Vue/img/regles.png'))
        @buttonQuitter = Button.new(:label => @langue.langueActuelle[:quitter], :mnemonic => nil)
        @buttonQuitter.set_image(Image.new(:file => './Vue/img/exit.png'))

        @buttonSave.signal_connect('clicked')  { onBtnSaveClicked }
        @buttonLoad.signal_connect('clicked')  { onBtnLoadClicked }
        @buttonOptions.signal_connect('clicked')  { onBtnOptionsClicked }
        @buttonRegles.signal_connect('clicked')  { onBtnReglesClicked }
        @buttonQuitter.signal_connect('clicked')  { onBtnQuitterClicked }

        boxNav.add(@buttonSave)
        boxNav.add(@buttonLoad)
        boxNav.add(@buttonOptions)
        boxNav.add(@buttonRegles)
        boxNav.add(@buttonQuitter)

        # boxNav.add(Label.new("Niveau " + @modele.niveau().difficulte().to_s() + " - " + @tailleGrille.to_s() + "x" + @tailleGrille.to_s()))

        # Menu du haut
        boxHeader = Box.new(:horizontal)
        @buttonHypothese = Button.new(:label => @langue.langueActuelle[:hypothese], :mnemonic => "H")
        @buttonHypothese.set_image(Image.new(:file => './Vue/img/hypothese.png'))
        @buttonValiderHypo = Button.new(:label => @langue.langueActuelle[:valider], :mnemonic => nil)
        @buttonValiderHypo.set_image(Image.new(:file => './Vue/img/valider.png'))
        @buttonAnnulerHypo = Button.new(:label => @langue.langueActuelle[:annuler], :mnemonic => nil)
        @buttonAnnulerHypo.set_image(Image.new(:file => './Vue/img/annuler.png'))

        boxHeader.add(@buttonHypothese)
        boxHeader.add(@buttonValiderHypo)
        boxHeader.add(@buttonAnnulerHypo)

        @imageTuile1 = Image.new(:file => './Vue/img/CaseRouge32.png')
        @imageTuile2 = Image.new(:file => './Vue/img/CaseBleue32.png')

        # Création de la grille
        boxJeu = Box.new(:horizontal)
        frame = Table.new(@tailleGrille,@tailleGrille,false)
        @casesJeu = Array.new(@tailleGrille) { Array.new(@tailleGrille) }

        0.upto(@tailleGrille-1) do |ligne|
            0.upto(@tailleGrille-1) do |colonne|
                caseTemp = CaseJeu.new(colonne,ligne)

            	if @modele.grille().getTuile(colonne,ligne).etat() == 1
            		caseTemp.setImageTuile1Lock()
            	elsif @modele.grille().getTuile(colonne,ligne).etat() == 2
            		caseTemp.setImageTuile2Lock()
            	end

                caseTemp.signal_connect('clicked') { onCaseJeuClicked(caseTemp) }
            	frame.attach(caseTemp,ligne,ligne+1,colonne,colonne+1)

                @casesJeu[ligne][colonne] = caseTemp
            end
        end

        @temps = Label.new("0:00")

        boxJeu.add(frame)
        boxJeu.pack_end(@temps, :expand => true, :fill => false)

        # Menu du bas
        boxFooter = Box.new(:horizontal)
        @buttonUndo = Button.new(:label => @langue.langueActuelle[:annuler], :mnemonic => "Z")
        @buttonUndo.set_image(Image.new(:file => './Vue/img/undo.png'))
        @buttonRedo = Button.new(:label => @langue.langueActuelle[:repeter], :mnemonic => "Y")
        @buttonRedo.set_image(Image.new(:file => './Vue/img/redo.png'))
        @buttonConseil = Button.new(:label => @langue.langueActuelle[:conseil], :mnemonic => "C")
        @buttonConseil.set_image(Image.new(:file => './Vue/img/conseil.png'))
        @buttonRestart = Button.new(:label => @langue.langueActuelle[:recommencer], :mnemonic => "R")
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

    # Signaux des boutons de navigation
    def onBtnSaveClicked 

    end
    def onBtnLoadClicked 

    end
    def onBtnOptionsClicked

    end
    def onBtnReglesClicked 

    end
    def onBtnQuitterClicked

    end

    def onCaseJeuClicked(caseJeu)
        if @modele.niveau().tuileValide?(caseJeu.x,caseJeu.y)

            @modele.jouerCoup(caseJeu.x,caseJeu.y)

            caseJeu.setImageTuile(@modele.grille().getTuile(caseJeu.x,caseJeu.y).etat())

            self.actualiser()            
        end
    end

    # Boutons du footer
    def onBtnUndoClicked
        tabCoord = @modele.historiqueUndo()
        if(tabCoord)
            @casesJeu[tabCoord[1]][tabCoord[0]].setImageTuile(@modele.grille().getTuile(tabCoord[1],tabCoord[0]).etat())
            self.actualiser() 
        end 
    end

    def onBtnRedoClicked
        tabCoord = @modele.historiqueRedo()
        if(tabCoord)
            @casesJeu[tabCoord[1]][tabCoord[0]].setImageTuile(@modele.grille().getTuile(tabCoord[1],tabCoord[0]).etat())
            self.actualiser() 
        end
    end

    def onBtnConseilClicked

    end

    def onBtnRestartClicked

    end

end