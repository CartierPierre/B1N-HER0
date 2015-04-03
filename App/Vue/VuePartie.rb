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

    @threadChrono

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

        @temps = Label.new("00:00")

        @threadChrono = Thread.new {
            chrono = Chrono.new()
            while(true)
                @temps.set_label(chrono.to_s)
                sleep(0.1)
            end
        }

        # Navigation
        boxNav = Box.new(:horizontal)

        @buttonSave = nouveauBouton(:sauvegarder,"save")
        @buttonLoad = nouveauBouton(:charger,"load")
        @buttonOptions = nouveauBouton(:options,"options")
        @buttonRegles = nouveauBouton(:regles,"regles")
        @buttonQuitter = nouveauBouton(:quitter,"exit")

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
        @buttonHypothese = nouveauBouton(:hypothese,"hypothese")
        @buttonValiderHypo = nouveauBouton(:valider,"valider")
        @buttonAnnulerHypo = nouveauBouton(:annuler,"annuler")

        boxHeader.add(@buttonHypothese)
        boxHeader.add(@buttonValiderHypo)
        boxHeader.add(@buttonAnnulerHypo)

        @imageTuile1 = Image.new(:file => './Vue/img/CaseRouge32.png')
        @imageTuile2 = Image.new(:file => './Vue/img/CaseBleue32.png')

        # Création de la grille
        boxJeu = Box.new(:horizontal)
        frame = Table.new(@tailleGrille,@tailleGrille,false)
        @casesJeu = Array.new(@tailleGrille) { Array.new(@tailleGrille) }

        0.upto(@tailleGrille-1) do |x|
            0.upto(@tailleGrille-1) do |y|
                caseTemp = CaseJeu.new(x,y)

            	if @modele.grille().getTuile(x,y).etat() == 1
            		caseTemp.setImageTuile1Lock()
            	elsif @modele.grille().getTuile(x,y).etat() == 2
            		caseTemp.setImageTuile2Lock()
            	end

                caseTemp.signal_connect('clicked') { onCaseJeuClicked(caseTemp) }
            	frame.attach(caseTemp,y,y+1,x,x+1)

                @casesJeu[x][y] = caseTemp
            end
        end

        boxJeu.add(frame)
        boxJeu.pack_end(@temps, :expand => true, :fill => false)

        # Menu du bas
        boxFooter = Box.new(:horizontal)
        @buttonUndo = nouveauBouton(:annuler,"undo")
        @buttonRedo = nouveauBouton(:repeter,"redo")
        @buttonConseil = nouveauBouton(:conseil,"conseil")
        @buttonRestart = nouveauBouton(:recommencer,"restart")

        @buttonUndo.signal_connect('clicked')  { onBtnUndoClicked }
        @buttonRedo.signal_connect('clicked')  { onBtnRedoClicked }
        @buttonConseil.signal_connect('clicked')  { onBtnConseilClicked }
        @buttonRestart.signal_connect('clicked')  { onBtnRestartClicked }

        boxFooter.pack_start(Label.new(), :expand => true, :fill => true)        
        boxFooter.add(@buttonUndo)
        boxFooter.add(@buttonRedo)
        boxFooter.add(@buttonConseil)
        boxFooter.add(@buttonRestart)
        boxFooter.pack_end(Label.new(), :expand => true, :fill => true) 

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
            @casesJeu[tabCoord[0]][tabCoord[1]].setImageTuile(@modele.grille().getTuile(tabCoord[0],tabCoord[1]).etat())
            self.actualiser() 
        end 
    end

    def onBtnRedoClicked
        tabCoord = @modele.historiqueRedo()
        if(tabCoord)
            @casesJeu[tabCoord[0]][tabCoord[1]].setImageTuile(@modele.grille().getTuile(tabCoord[0],tabCoord[1]).etat())
            self.actualiser() 
        end
    end

    def onBtnConseilClicked

    end

    def onBtnRestartClicked

    end

end