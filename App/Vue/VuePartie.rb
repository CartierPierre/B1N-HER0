class VuePartie < Vue

    @tailleGrille
    @temps

    # Boutons du menu de navigation
    @boutonSave
    @boutonLoad
    @boutonOptions
    @boutonRegles
    @boutonQuitter

    # Boutons du menu en haut
    @boxHypo
    @labelHypothese
    @boutonHypothese
    @boutonValiderHypo
    @boutonAnnulerHypo

    # Boutons du menu en bas
    @boutonUndo
    @boutonRedo
    @boutonConseil
    @boutonRestart

    @grilleTable
    @grille

    @threadChrono

    class CaseJeu < Gtk::Button
        attr_accessor :x, :y

        @controleur

        def initialize(x,y,controleur)
            super()
            @x,@y = x,y
            @controleur = controleur
            self.set_size_request(20, 20)
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
        @grille[0][y+1].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nbCasesColonne[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nbCasesColonne[1]}</span> ])
        @grille[x+1][0].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nbCasesLigne[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nbCasesLigne[1]}</span> ])
    end

    def initialize(modele,titre,controleur)
        super(modele,"B1N-HER0",controleur)

        @tailleGrille = @modele.grille().taille()

        @temps = Label.new("00:00")

        @threadChrono = Thread.new() {
            @modele.chrono.start()
            while(true)
                if(@modele.chrono.estActif)
                    @temps.set_label(@modele.chrono.to_s)
                end
                sleep(0.1)
            end
        }

        # Navigation
        boxNav = Box.new(:horizontal)

        @boutonSave = nouveauBouton(:sauvegarder,"save")
        @boutonLoad = nouveauBouton(:charger,"load")
        @boutonOptions = nouveauBouton(:options,"options")
        @boutonRegles = nouveauBouton(:regles,"regles")
        @boutonQuitter = nouveauBouton(:quitter,"exit")

        @boutonSave.signal_connect('clicked')  { onBtnSaveClicked }
        @boutonLoad.signal_connect('clicked')  { onBtnLoadClicked }
        @boutonOptions.signal_connect('clicked')  { onBtnOptionsClicked }
        @boutonRegles.signal_connect('clicked')  { onBtnReglesClicked }
        @boutonQuitter.signal_connect('clicked')  { onBtnQuitterClicked }

        boxNav.pack_start(@boutonSave, :expand => true, :fill => true)
        boxNav.pack_start(@boutonLoad)
        boxNav.pack_start(@boutonOptions)
        boxNav.pack_start(@boutonRegles)
        boxNav.pack_start(@boutonQuitter)

        # Menu hypothèse
        @boxHypo = Box.new(:vertical,10)
        @labelHypothese = Label.new("")

        @boutonHypothese = nouveauBouton(:hypothese,"hypothese")
        @boutonHypothese.signal_connect('clicked') { onBtnHypoClicked }
        @boutonHypothese.set_size_request(100,64)

        @boutonValiderHypo = nouveauBouton(:valider,"valider")
        @boutonValiderHypo.signal_connect('clicked') { onBtnHypoValiderClicked }
        @boutonValiderHypo.set_size_request(100,64)

        @boutonAnnulerHypo = nouveauBouton(:annuler,"annuler")
        @boutonAnnulerHypo.signal_connect('clicked') { onBtnHypoAnnulerClicked }
        @boutonAnnulerHypo.set_size_request(100,64)

        @boxHypo.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        @boxHypo.add(@labelHypothese)     
        @boxHypo.add(@boutonHypothese)
        @boxHypo.add(@boutonValiderHypo)
        @boxHypo.add(@boutonAnnulerHypo)
        @boxHypo.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)     

        @imageTuile1 = Image.new(:file => './Ressources/CaseRouge32.png')
        @imageTuile2 = Image.new(:file => './Ressources/CaseBleue32.png')

        # Création de la grille
        @grilleTable = Table.new(@tailleGrille,@tailleGrille,true)
        @grille = Array.new(@tailleGrille+1) { Array.new(@tailleGrille+1) }

        0.upto(@tailleGrille) do |x|
            0.upto(@tailleGrille) do |y|
                
                if(x == 0 && y == 0)
                    caseTemp = Label.new()
                elsif(x == 0)
                    nb = @modele.compterCasesColonne(y-1)
                    caseTemp = Label.new.set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nb[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nb[1]}</span> ])
                elsif(y == 0)
                    nb = @modele.compterCasesLigne(x-1)
                    caseTemp = Label.new.set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nb[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nb[1]}</span> ])
                else
                    caseTemp = CaseJeu.new(x-1,y-1,@controleur)
                    caseTemp.setImageTuile(@modele.grille().getTuile(x-1,y-1).etat())
                    caseTemp.signal_connect('clicked') { onCaseJeuClicked(caseTemp) }
                end
                @grilleTable.attach(caseTemp,y,y+1,x,x+1)
                @grille[x][y] = caseTemp
            end
        end

        boxJeu = Box.new(:horizontal,30)
        boxJeu.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)   
        boxJeu.add(@boxHypo)  
        boxJeu.add(@grilleTable)
        boxJeu.add(@temps)
        boxJeu.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Menu du bas
        boxFooter = Box.new(:horizontal)
        @boutonUndo = nouveauBouton(:annulerAction,"undo")
        @boutonRedo = nouveauBouton(:repeter,"redo")
        @boutonConseil = nouveauBouton(:conseil,"conseil")
        @boutonRestart = nouveauBouton(:recommencer,"restart")

        @boutonUndo.signal_connect('clicked')  { onBtnUndoClicked }
        @boutonRedo.signal_connect('clicked')  { onBtnRedoClicked }
        @boutonConseil.signal_connect('clicked')  { onBtnConseilClicked }
        @boutonRestart.signal_connect('clicked')  { onBtnRestartClicked }

        boxFooter.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)       
        boxFooter.add(@boutonUndo)
        boxFooter.add(@boutonRedo)
        boxFooter.add(@boutonConseil)
        boxFooter.add(@boutonRestart)
        boxFooter.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la box principal des éléments
        vboxPrincipale = Box.new(:vertical,30)
        vboxPrincipale.add(boxNav)
        labelNiveau = Label.new()
        labelNiveau.set_markup("<big>" + "Niveau " + @modele.niveau.difficulte.to_s + " - " + @tailleGrille.to_i.to_s + "x" + @tailleGrille.to_i.to_s + "</big>")
        vboxPrincipale.add(labelNiveau)
        vboxPrincipale.add(boxJeu) 
        vboxPrincipale.add(boxFooter)

        @cadre.add(vboxPrincipale)

        self.actualiser()
        @boutonValiderHypo.hide()
        @boutonAnnulerHypo.hide() 
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
        @modele.chrono.pause()
        @grilleTable.hide()
        regles = @controleur.getLangue[:regles]
        regles += "\n\n"
        regles += @controleur.getLangue[:regles1]
        regles += @controleur.getLangue[:regles2]
        regles += @controleur.getLangue[:regles3]
        dialogRegles = MessageDialog.new(:parent => @@fenetre, :type => :question, :buttons_type => :close, :message => regles)
        dialogRegles.run()
        dialogRegles.destroy()
        @modele.chrono.finPause()
        @grilleTable.show()
    end

    def onBtnQuitterClicked
        fermerCadre()
        @controleur.quitter()
    end

    # Hypothèse
    def onBtnHypoClicked
        @labelHypothese.set_label(@controleur.getLangue[:hypotheseActive])
        @boutonValiderHypo.show()
        @boutonAnnulerHypo.show()
        @boutonHypothese.hide()
    end

    def onBtnHypoValiderClicked
        @labelHypothese.set_label("")
        @boutonValiderHypo.hide()
        @boutonAnnulerHypo.hide()
        @boutonHypothese.show()
    end

    def onBtnHypoAnnulerClicked
        @labelHypothese.set_label("")
        @boutonValiderHypo.hide()
        @boutonAnnulerHypo.hide()
        @boutonHypothese.show()
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