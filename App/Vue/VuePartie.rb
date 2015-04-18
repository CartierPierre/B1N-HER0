class VuePartie < Vue

    @tailleGrille

    # Jeu
    @labelConseil
    @temps
    @boutonValiderGrille
    @grille 
    @threadChrono

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
    @boutonValiderHypothese
    @boutonAnnulerHypothese

    # Boutons du menu en bas
    @boutonUndo
    @boutonRedo
    @boutonConseil
    @boutonRestart

    def initialize(modele,titre,controleur)
        super(modele,"B1N-HER0",controleur)

        @tailleGrille = @modele.grille().taille()

        # Navigation
        boxNav = Box.new(:horizontal)
        boxNav.set_homogeneous(true)

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

        @boutonValiderHypothese = nouveauBouton(:valider,"valider")
        @boutonValiderHypothese.signal_connect('clicked') { onBtnValiderHypotheseClicked }
        @boutonValiderHypothese.set_size_request(100,64)

        @boutonAnnulerHypothese = nouveauBouton(:annuler,"annuler")
        @boutonAnnulerHypothese.signal_connect('clicked') { onBtnAnnulerHypotheseClicked }
        @boutonAnnulerHypothese.set_size_request(100,64)

        @boxHypo.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        @boxHypo.add(@labelHypothese)     
        @boxHypo.add(@boutonHypothese)
        @boxHypo.add(@boutonValiderHypothese)
        @boxHypo.add(@boutonAnnulerHypothese)
        @boxHypo.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)     

        # Création de la grille
        grilleTable = Table.new(@tailleGrille,@tailleGrille,true)
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
                    caseTemp = TuileGtk.new(x-1,y-1,@controleur)
                    caseTemp.setImageTuile(@modele.grille().getTuile(x-1,y-1).etat())
                    caseTemp.signal_connect('clicked') { onTuileGtkClicked(caseTemp) }
                end
                grilleTable.attach(caseTemp,y,y+1,x,x+1)
                @grille[x][y] = caseTemp
            end
        end

        # Chrono et validation de la grille
        vboxJeuDroite = Box.new(:vertical, 30)

        @labelConseil = Label.new()
        alignLabelConseil = Alignment.new(0, 0, 0, 1.0)
        alignLabelConseil.add(@labelConseil)

        @temps = Label.new()
        @temps.set_markup("<big>00:00</big>")

        @threadChrono = Thread.new() {
            @modele.chrono.start()
            while(true)
                if(@modele.chrono.estActif)
                    @temps.set_markup("<big>" + @modele.chrono.to_s + "</big>")
                end
                sleep(0.1)
            end
        }

        @boutonValiderGrille = nouveauBouton(:validerGrille,"valider")
        @boutonValiderGrille.set_sensitive(true)
        @boutonValiderGrille.signal_connect('clicked')  { onBtnValiderGrilleClicked }

        vboxJeuDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)  
        vboxJeuDroite.add(alignLabelConseil)
        vboxJeuDroite.add(@temps)
        vboxJeuDroite.add(@boutonValiderGrille)
        vboxJeuDroite.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)  

        @boxJeu = Box.new(:horizontal,30)
        @boxJeu.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)   
        @boxJeu.add(@boxHypo)  
        @boxJeu.add(grilleTable)
        @boxJeu.add(vboxJeuDroite)
        @boxJeu.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Menu du bas
        @boxFooter = Box.new(:horizontal)
        @boxFooter.set_homogeneous(true)

        @boutonUndo = nouveauBouton(:annulerAction,"undo")
        @boutonRedo = nouveauBouton(:repeter,"redo")
        @boutonConseil = nouveauBouton(:conseil,"conseil")
        @boutonAide = nouveauBouton(:aide,"aide")
        @boutonRestart = nouveauBouton(:recommencer,"restart")

        @boutonUndo.signal_connect('clicked')  { onBtnUndoClicked }
        @boutonRedo.signal_connect('clicked')  { onBtnRedoClicked }
        @boutonConseil.signal_connect('clicked')  { onBtnConseilClicked }
        @boutonAide.signal_connect('clicked')  { onBtnAideClicked }
        @boutonRestart.signal_connect('clicked')  { onBtnRestartClicked }

        @boxFooter.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)       
        @boxFooter.add(@boutonUndo)
        @boxFooter.add(@boutonRedo)
        @boxFooter.add(@boutonConseil)
        @boxFooter.add(@boutonAide)
        @boxFooter.add(@boutonRestart)
        @boxFooter.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la box principale des éléments
        vboxPrincipale = Box.new(:vertical,30)
        vboxPrincipale.add(boxNav)
        labelNiveau = Label.new()
        labelNiveau.set_markup("<big>" + "Niveau " + @modele.niveau.difficulte.to_s + " - " + @tailleGrille.to_i.to_s + "x" + @tailleGrille.to_i.to_s + "</big>")
        vboxPrincipale.add(labelNiveau)
        vboxPrincipale.add(@boxJeu) 
        vboxPrincipale.add(@boxFooter)

        @cadre.add(vboxPrincipale)

        self.actualiser()
        @boutonValiderHypothese.hide()
        @boutonAnnulerHypothese.hide() 
    end

    #########################################
    #                                       #
    # =>    METHODES POUR L'AFFICHAGE    <= #
    #                                       #
    #########################################
    def actualiserGrille()
        0.upto(@tailleGrille) do |x|
            0.upto(@tailleGrille) do |y|
                if(x != 0 && y != 0) 
                    
                    if(x == 0)
                        nb = @modele.compterCasesColonne(y-1)
                        @grille[x][y].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nb[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nb[1]}</span> ])
                    elsif(y == 0)
                        nb = @modele.compterCasesLigne(x-1)
                        @grille[x][y].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nb[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nb[1]}</span> ])
                    else
                        @grille[x][y].setImageTuile(@modele.grille().getTuile(x-1,y-1).etat())
                    end

                end
            end
        end
    end
    
    def nbLigneColonne(x,y)
        nbCasesColonne = @modele.compterCasesColonne(y)
        nbCasesLigne = @modele.compterCasesLigne(x)
        @grille[0][y+1].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nbCasesColonne[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nbCasesColonne[1]}</span> ])
        @grille[x+1][0].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nbCasesLigne[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nbCasesLigne[1]}</span> ])
    end

    def couperChaine(chaine, longueurMax)
        chaine.gsub(/\s+/, " ").gsub(/(.{1,#{longueurMax}})( |\Z)/, "\\1\n")
    end

    def surbrillanceLigne(ligne)
        Thread.new {
            # Le nombre dans le upto doit être impair
            0.upto(7) do |n|
                1.upto(@tailleGrille) do |x|
                    if(n%2 == 0) # Pair
                        @grille[ligne][x].set_sensitive(false)
                    else # Impair
                        @grille[ligne][x].set_sensitive(true)
                    end
                end 
                sleep(0.3)
            end
        }    
    end

    def surbrillanceColonne(colonne)
        Thread.new {
            # Le nombre dans le upto doit être impair
            0.upto(7) do |n|
                1.upto(@tailleGrille) do |x|
                    if(n%2 == 0) # Pair
                        @grille[x][colonne].set_sensitive(false)
                    else # Impair
                        @grille[x][colonne].set_sensitive(true)
                    end
                end 
                sleep(0.3)
            end
        }    
    end

    def surbrillanceTuile(x,y)
        Thread.new {
            # Le nombre dans le upto doit être impair
            0.upto(7) do |n|
                if(n%2 == 0) # Pair
                    @grille[x][y].set_sensitive(false)
                else # Impair
                    @grille[x][y].set_sensitive(true)
                end
                sleep(0.3)
            end
        }    
    end

    protected :actualiserGrille, :couperChaine, :surbrillanceLigne, :surbrillanceColonne

    ###################################
    #                                 #
    # =>    SIGNAUX DES BOUTONS    <= #
    #                                 #
    ###################################

    ##
    # => Boutons du menu en haut
    ##
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
        @boxJeu.hide()
        @boxFooter.hide()

        regles = @controleur.getLangue[:regles]
        regles += "\n\n"
        regles += @controleur.getLangue[:regles1]
        regles += @controleur.getLangue[:regles2]
        regles += @controleur.getLangue[:regles3]
        dialogRegles = MessageDialog.new(:parent => @@fenetre, :type => :question, :buttons_type => :close, :message => regles)
        dialogRegles.run()
        dialogRegles.destroy()

        @modele.chrono.finPause()
        @boxJeu.show()
        @boxFooter.show()
    end

    def onBtnQuitterClicked
        fermerCadre()
        @controleur.quitter()
    end

    ##
    # => Boutons du mode hypothèse
    ##
    def onBtnHypoClicked
        @labelHypothese.set_label(@controleur.getLangue[:hypotheseActive])
        @boutonValiderHypothese.show()
        @boutonAnnulerHypothese.show()
        @boutonHypothese.hide()
        @modele.activerModeHypothese()
    end

    def onBtnValiderHypotheseClicked
        @labelHypothese.set_label("")
        @boutonValiderHypothese.hide()
        @boutonAnnulerHypothese.hide()
        @boutonHypothese.show()
        @modele.validerHypothese()
        self.actualiserGrille()
    end

    def onBtnAnnulerHypotheseClicked
        @labelHypothese.set_label("")
        @boutonValiderHypothese.hide()
        @boutonAnnulerHypothese.hide()
        @boutonHypothese.show()
        @modele.annulerHypothese()
        self.actualiserGrille()
    end

    ##
    # => Boutons de la grille et validation
    ##
    def onTuileGtkClicked(tuileGtk)
        if( @modele.niveau.tuileValide?(tuileGtk.x,tuileGtk.y) )
            @modele.jouerCoup(tuileGtk.x,tuileGtk.y)
            tuileGtk.setImageTuile(@modele.grille.getTuile(tuileGtk.x,tuileGtk.y).etat())
            self.nbLigneColonne(tuileGtk.x,tuileGtk.y)          
        end

        if( @modele.grille.estRemplie?() )
            @boutonValiderGrille.set_sensitive(true)
        end
    end

    def onBtnValiderGrilleClicked
        if(!@modele.valider())
            explications = @controleur.getLangue[:grilleInvalide]
            explications += "\n\n"
            explications += @controleur.getLangue[:grilleInvalideExplications]
            dialogValidationGrille = MessageDialog.new(:parent => @@fenetre, :type => :warning, :buttons_type => :close, :message => explications)
            dialogValidationGrille.run()
            dialogValidationGrille.destroy()
        else           
            fermerCadre()
            @controleur.validerGrille() 
        end
    end

    ##
    # => Boutons du menu en bas
    ##
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
        conseil = Array[:regleLigne, 2, :regles1]

        chaine = @controleur.getLangue[:appliquerRegle] + @controleur.getLangue[conseil[2]] + @controleur.getLangue[conseil[0]] + conseil[1].to_s 
        @labelConseil.set_markup("<big>" + couperChaine(chaine,30) + "</big>")

        if(conseil[0] == :regleLigne)
            surbrillanceLigne(conseil[1])
        else
            surbrillanceColonne(conseil[1])
        end

        Thread.new {
            @boutonConseil.set_sensitive(false)
            @labelConseil.show()
            sleep(15)
            @labelConseil.hide()
            @boutonConseil.set_sensitive(true)
        }
    end

    def onBtnAideClicked
        aide = Array[2,5]

        @modele.grille.setTuile(aide[0]-1,aide[1]-1, Etat.lock_1) # A faire dans le modele de l'aide directement (seulement pour test là)

        @grille[aide[0]][aide[1]].setImageTuile(@modele.grille.getTuile(aide[0]-1,aide[1]-1).etat())
        surbrillanceTuile(aide[0],aide[1])
    end

    def onBtnRestartClicked
        @modele.recommencer
        self.actualiserGrille()
    end

end