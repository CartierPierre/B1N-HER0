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
    @boxHypo
    @labelHypothese
    @buttonHypothese
    @buttonValiderHypo
    @buttonAnnulerHypo

    # Boutons du menu en bas
    @buttonUndo
    @buttonRedo
    @buttonConseil
    @buttonRestart

    @grille

    @threadChrono

    class CaseJeu < Gtk::Button
        attr_accessor :x, :y

        @controleur

        def initialize(x,y,controleur)
            super()
            @x,@y = x,y
            @controleur = controleur
            #self.set_size_request(32, 32)
            self.set_border_width(0)
        end

        def setImageTuile(etat)
            if (etat == Etat.etat_1)
                self.set_image(Image.new(:pixbuf => @controleur.getImgTuile1))
            elsif (etat == Etat.etat_2)
                self.set_image(Image.new(:pixbuf => @controleur.getImgTuile2))
            elsif (etat == Etat.lock_1)
                self.set_image(Image.new(:pixbuf => @controleur.getImgTuileLock1))
            elsif (etat == Etat.lock_2)
                self.set_image(Image.new(:pixbuf => @controleur.getImgTuileLock2))
            else
                self.set_image(Image.new())
            end    
        end

    end

    def nbLigneColonne(x,y)
        nbCasesColonne = @modele.compterCasesColonne(y)
        nbCasesLigne = @modele.compterCasesLigne(x)
        @grille[0][y+1].set_markup(%Q[ <span foreground="red">#{nbCasesColonne[0]}</span> - <span foreground="blue">#{nbCasesColonne[1]}</span> ])
        @grille[x+1][0].set_markup(%Q[ <span foreground="red">#{nbCasesLigne[0]}</span> - <span foreground="blue">#{nbCasesLigne[1]}</span> ])
    end

    def initialize(modele,titre,controleur)
        super(modele,"B1N-HER0",controleur)

        boxVertMain = Box.new(:vertical)

        @tailleGrille = @modele.grille().taille()

        @temps = Label.new("00:00")

        #@threadChrono = ThreadChrono.new()
        #@threadChrono.start()

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

        boxNav.pack_start(@buttonSave, :expand => true, :fill => true)
        boxNav.pack_start(@buttonLoad)
        boxNav.pack_start(@buttonOptions)
        boxNav.pack_start(@buttonRegles)
        boxNav.pack_start(@buttonQuitter)

        # Menu hypothèse
        @boxHypo = Box.new(:vertical)
        @labelHypothese = Label.new("")

        @buttonHypothese = nouveauBouton(:hypothese,"hypothese")
        @buttonHypothese.signal_connect('clicked') { onBtnHypoClicked }
        @buttonHypothese.set_size_request(100,64)

        @buttonValiderHypo = nouveauBouton(:valider,"valider")
        @buttonValiderHypo.signal_connect('clicked') { onBtnHypoValiderClicked }
        @buttonValiderHypo.set_size_request(100,64)

        @buttonAnnulerHypo = nouveauBouton(:annuler,"annuler")
        @buttonAnnulerHypo.signal_connect('clicked') { onBtnHypoAnnulerClicked }
        @buttonAnnulerHypo.set_size_request(100,64)

        @boxHypo.pack_start(Label.new(), :expand => true, :fill => true)   
        @boxHypo.add(@labelHypothese)     
        @boxHypo.add(@buttonHypothese)
        @boxHypo.add(@buttonValiderHypo)
        @boxHypo.add(@buttonAnnulerHypo)
        @boxHypo.pack_end(Label.new(), :expand => true, :fill => true)     

        @imageTuile1 = Image.new(:file => './Ressources/CaseRouge32.png')
        @imageTuile2 = Image.new(:file => './Ressources/CaseBleue32.png')

        # Création de la grille
        boxJeu = Box.new(:horizontal)
        frame = Table.new(@tailleGrille,@tailleGrille,false)
        @grille = Array.new(@tailleGrille+1) { Array.new(@tailleGrille+1) }

        0.upto(@tailleGrille) do |x|
            0.upto(@tailleGrille) do |y|
                
                if(x == 0 && y == 0)
                    caseTemp = Label.new()
                elsif(x == 0)
                    nb = @modele.compterCasesColonne(y-1)
                    caseTemp = Label.new.set_markup(%Q[ <span foreground="red">#{nb[0]}</span> - <span foreground="blue">#{nb[1]}</span> ])
                elsif(y == 0)
                    nb = @modele.compterCasesLigne(x-1)
                    caseTemp = Label.new.set_markup(%Q[ <span foreground="red">#{nb[0]}</span> - <span foreground="blue">#{nb[1]}</span> ])
                else
                    caseTemp = CaseJeu.new(x-1,y-1,@controleur)
                    caseTemp.setImageTuile(@modele.grille().getTuile(x-1,y-1).etat())
                    caseTemp.signal_connect('clicked') { onCaseJeuClicked(caseTemp) }
                end
                frame.attach(caseTemp,y,y+1,x,x+1)
                @grille[x][y] = caseTemp
            end
        end

        boxJeu.add(@boxHypo)
        boxJeu.add(Label.new("  "))
        boxJeu.add(frame)
        boxJeu.add(Label.new("  "))
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
        boxVertMain.add(Label.new())
        labelNiveau = Label.new()
        labelNiveau.set_markup("<big>" + "Niveau " + @modele.niveau().difficulte().to_s() + " - " + @tailleGrille.to_s() + "x" + @tailleGrille.to_s() + "</big>")
        boxVertMain.add(labelNiveau)
        boxVertMain.add(Label.new())
        boxVertMain.add(boxJeu)
        boxVertMain.add(Label.new())
        boxVertMain.pack_end(boxFooter, :expand => true, :fill => false)

        @cadre.add(boxVertMain)

        self.actualiser()
        @buttonValiderHypo.hide()
        @buttonAnnulerHypo.hide() 
    end

    # Signaux des boutons de navigation
    def onBtnSaveClicked 

    end

    def onBtnLoadClicked 

    end

    def onBtnOptionsClicked
        fermerCadre()
        @controleur.options()
    end

    def onBtnReglesClicked 
        #@threadChrono.chrono.pause()
        regles = @controleur.getLangue[:regles]
        regles += "\n\n"
        regles += @controleur.getLangue[:regles1]
        regles += @controleur.getLangue[:regles2]
        regles += @controleur.getLangue[:regles3]
        dialogRegles = MessageDialog.new(:parent => @@fenetre, :type => :question, :buttons_type => :close, :message => regles)
        dialogRegles.run()
        dialogRegles.destroy()
        #@threadChrono.chrono.finPause()
    end

    def onBtnQuitterClicked
        fermerCadre()
        @controleur.quitter()
    end

    # Hypothèse
    def onBtnHypoClicked
        @labelHypothese.set_label(" Mode\n hypothèse\n activé")
        @buttonValiderHypo.show()
        @buttonAnnulerHypo.show()
        @buttonHypothese.hide()
    end

    def onBtnHypoValiderClicked
        @labelHypothese.set_label("")
        @buttonValiderHypo.hide()
        @buttonAnnulerHypo.hide()
        @buttonHypothese.show()
    end

    def onBtnHypoAnnulerClicked
        @labelHypothese.set_label("")
        @buttonValiderHypo.hide()
        @buttonAnnulerHypo.hide()
        @buttonHypothese.show()
    end

    # Grille
    def onCaseJeuClicked(caseJeu)
        if @modele.niveau().tuileValide?(caseJeu.x,caseJeu.y)
            @modele.jouerCoup(caseJeu.x,caseJeu.y)
            caseJeu.setImageTuile(@modele.grille().getTuile(caseJeu.x,caseJeu.y).etat())
            self.nbLigneColonne(caseJeu.x,caseJeu.y)          
        end
    end

    # Boutons du footer
    def onBtnUndoClicked
        tabCoord = @modele.historiqueUndo()
        if(tabCoord)
            @grille[tabCoord[0]+1][tabCoord[1]+1].setImageTuile(@modele.grille().getTuile(tabCoord[0],tabCoord[1]).etat())
            self.nbLigneColonne(tabCoord[0],tabCoord[1])
        end 
    end

    def onBtnRedoClicked
        tabCoord = @modele.historiqueRedo()
        if(tabCoord)
            @grille[tabCoord[0]+1][tabCoord[1]+1].setImageTuile(@modele.grille().getTuile(tabCoord[0],tabCoord[1]).etat())
            self.nbLigneColonne(tabCoord[0],tabCoord[1])
        end
    end

    def onBtnConseilClicked

    end

    def onBtnRestartClicked
        @modele.recommencer
        0.upto(@tailleGrille) do |x|
            0.upto(@tailleGrille) do |y|
                if(x == 0 && y == 0)
                    
                elsif(x == 0)
                    nb = @modele.compterCasesColonne(y-1)
                    @grille[x][y].set_markup(%Q[ <span foreground="red">#{nb[0]}</span> - <span foreground="blue">#{nb[1]}</span> ])
                elsif(y == 0)
                    nb = @modele.compterCasesLigne(x-1)
                    @grille[x][y].set_markup(%Q[ <span foreground="red">#{nb[0]}</span> - <span foreground="blue">#{nb[1]}</span> ])
                else
                    @grille[x][y].setImageTuile(@modele.grille().getTuile(x-1,y-1).etat())
                end
            end
        end
    end

end