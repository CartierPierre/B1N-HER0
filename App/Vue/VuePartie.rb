class VuePartie < Vue

    ### Attributs d'instances

    # Jeu
    @labelConseil
    @temps
    @boutonValiderGrille
    @grille 
    @threadChrono

    # Boutons du menu en haut
    @boutonSauvegarder
    @boutonCharger
    @boutonOptions
    @boutonRegles
    @boutonQuitter

    # Boutons du menu des hypothèses
    @boxHypo
    @labelHypothese
    @boutonHypothese
    @boutonValiderHypothese
    @boutonAnnulerHypothese

    # Boutons du menu en bas
    @boutonUndo
    @boutonRedo
    @boutonConseil
    @boutonAide
    @boutonRecommencer

    # Configuration de la surbrillance pour les aides et conseils
    @nbClignotements        # Fait varier le nombre de clignotements
    @vitesseClignotement    # Fait varier la vitesse du clignotement (petit = rapide)

    @dureeConseils          # Durée des conseils en secondes
    @delaiReactivation      # Délai en secondes avant de pouvoir réactiver les aides ou conseils

    ##
    # Méthode de création de la vue qui gère une partie
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @nbClignotements = 4
        @vitesseClignotement = 0.3

        @dureeConseils = 15
        @delaiReactivation = 5

        if(!@modele.chrono.estActif)
            @modele.chrono.finPause()
        end

        # Menu en haut
        boxNav = Box.new(:horizontal)
        boxNav.set_homogeneous(true)

        @boutonSauvegarder = creerBoutonImage(:sauvegarder,"save")
        @boutonCharger = creerBoutonImage(:charger,"load")
        @boutonOptions = creerBoutonImage(:options,"options")
        @boutonRegles = creerBoutonImage(:regles,"regles")
        @boutonQuitter = creerBoutonImage(:quitter,"exit")

        @boutonSauvegarder.signal_connect('clicked')  { onBtnSauvegarderClicked }
        @boutonCharger.signal_connect('clicked')  { onBtnChargerClicked }
        @boutonOptions.signal_connect('clicked')  { onBtnOptionsClicked }
        @boutonRegles.signal_connect('clicked')  { onBtnReglesClicked }
        @boutonQuitter.signal_connect('clicked')  { onBtnQuitterClicked }

        boxNav.pack_start(@boutonSauvegarder, :expand => true, :fill => true)
        boxNav.pack_start(@boutonCharger)
        boxNav.pack_start(@boutonOptions)
        boxNav.pack_start(@boutonRegles)
        boxNav.pack_start(@boutonQuitter)

        # Menu hypothèse
        @boxHypo = Box.new(:vertical,10)
        @labelHypothese = Label.new("")

        @boutonHypothese = creerBoutonImage(:hypothese,"hypothese")
        @boutonHypothese.signal_connect('clicked') { onBtnHypoClicked }
        @boutonHypothese.set_size_request(100,64)

        @boutonValiderHypothese = creerBoutonImage(:valider,"valider")
        @boutonValiderHypothese.signal_connect('clicked') { onBtnValiderHypotheseClicked }
        @boutonValiderHypothese.set_size_request(100,64)

        @boutonAnnulerHypothese = creerBoutonImage(:annuler,"annuler")
        @boutonAnnulerHypothese.signal_connect('clicked') { onBtnAnnulerHypotheseClicked }
        @boutonAnnulerHypothese.set_size_request(100,64)

        @boxHypo.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        @boxHypo.add(@labelHypothese)     
        @boxHypo.add(@boutonHypothese)
        @boxHypo.add(@boutonValiderHypothese)
        @boxHypo.add(@boutonAnnulerHypothese)
        @boxHypo.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)     

        # Création des tuiles de la grille
        grilleTable = Table.new(@modele.grille.taille,@modele.grille.taille,true)
        @grille = Array.new(@modele.grille.taille+1) { Array.new(@modele.grille.taille+1) }

        0.upto(@modele.grille.taille) do |x|
            0.upto(@modele.grille.taille) do |y|
                
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

        # Chrono et bouton validation de la grille
        vboxJeuDroite = Box.new(:vertical, 30)

        @labelConseil = Label.new()
        alignLabelConseil = Alignment.new(0, 0, 0, 1.0)
        alignLabelConseil.add(@labelConseil)

        @temps = Label.new()
        @temps.set_markup("<big>00:00</big>")

        # Thread qui permet de gerer le chrono indépendamment
        @threadChrono = Thread.new() {
            while(true)
                if(@modele.chrono.estActif)
                    @temps.set_markup("<big>" + @modele.chrono.to_s + "</big>")
                end
                sleep(0.1)
            end
        }

        @boutonValiderGrille = creerBoutonImage(:validerGrille,"valider")
        @boutonValiderGrille.set_sensitive(false)
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

        # Menu du bas pour les actions en partie
        @boxFooter = Box.new(:horizontal)
        @boxFooter.set_homogeneous(true)

        @boutonUndo = creerBoutonImage(:annulerAction,"undo")
        @boutonRedo = creerBoutonImage(:repeter,"redo")
        @boutonConseil = creerBoutonImage(:conseil,"conseil")
        @boutonAide = creerBoutonImage(:aide,"aide")
        @boutonRecommencer = creerBoutonImage(:recommencer,"restart")

        @boutonUndo.signal_connect('clicked')  { onBtnUndoClicked }
        @boutonRedo.signal_connect('clicked')  { onBtnRedoClicked }
        @boutonConseil.signal_connect('clicked')  { onBtnConseilClicked }
        @boutonAide.signal_connect('clicked')  { onBtnAideClicked }
        @boutonRecommencer.signal_connect('clicked')  { onBtnRecommencerClicked }

        @boxFooter.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)       
        @boxFooter.add(@boutonUndo)
        @boxFooter.add(@boutonRedo)
        @boxFooter.add(@boutonConseil)
        @boxFooter.add(@boutonAide)
        @boxFooter.add(@boutonRecommencer)
        @boxFooter.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la vbox principale des éléments
        vboxPrincipale = Box.new(:vertical,30)
        vboxPrincipale.add(boxNav)
        labelNiveau = Label.new()
        labelNiveau.set_markup("<big>" + @controleur.getLangue[:niveau] + " " + @modele.niveau.difficulte.to_s + " - " + @modele.grille.taille.to_i.to_s + "x" + @modele.grille.taille.to_i.to_s + "</big>")
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

    ##
    # Méthode qui actualise l'ensemble des images des tuiles de la grille en fonction de l'état dans le modèle
    # ainsi que le nombre de tuiles à l'état 1/2 par ligne/colonne
    #
    def actualiserGrille()
        0.upto(@modele.grille.taille) do |x|
            0.upto(@modele.grille.taille) do |y|
                if(x == 0 && y == 0) 
                    @grille[x][y].set_label("")
                elsif(x == 0)
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
    
    ##
    # Méthode qui met à jour le nombre de tuiles à l'état 1/2 pour la ligne x et la colonne y
    #
    # Paramètres::
    #   * _x_ - Coordonnée en x
    #   * _y_ - Coordonnée en y 
    #
    def nbLigneColonne(x,y)
        nbCasesColonne = @modele.compterCasesColonne(y)
        nbCasesLigne = @modele.compterCasesLigne(x)
        @grille[0][y+1].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nbCasesColonne[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nbCasesColonne[1]}</span> ])
        @grille[x+1][0].set_markup(%Q[ <span foreground="#{@controleur.getCouleurTuile1}">#{nbCasesLigne[0]}</span> - <span foreground="#{@controleur.getCouleurTuile2}">#{nbCasesLigne[1]}</span> ])
    end

    ##
    # Méthode qui met en surbrillance une ligne en la faisant clignoter
    #
    # Paramètre::
    #   * _ligne_ - Ligne à mettre en surbrillance
    #
    def surbrillanceLigne(ligne)
        Thread.new {
            0.upto(@nbClignotements*2-1) do |n|
                1.upto(@modele.grille.taille) do |x|
                    if(n%2 == 0) # Pair
                        @grille[ligne][x].set_sensitive(false)
                    else # Impair
                        @grille[ligne][x].set_sensitive(true)
                    end
                end 
                sleep(@vitesseClignotement)
            end
        }    
    end

    ##
    # Méthode qui met en surbrillance une colonne en la faisant clignoter
    #
    # Paramètre::
    #   * _colonne_ - Colonne à mettre en surbrillance
    #
    def surbrillanceColonne(colonne)
        Thread.new {
            0.upto(@nbClignotements*2-1) do |n|
                1.upto(@modele.grille.taille) do |x|
                    if(n%2 == 0) # Pair
                        @grille[x][colonne].set_sensitive(false)
                    else # Impair
                        @grille[x][colonne].set_sensitive(true)
                    end
                end 
                sleep(@vitesseClignotement)
            end
        }    
    end

    ##
    # Méthode qui met en surbrillance la tuile de coordonnées x et y 
    #
    # Paramètres::
    #   * _x_ - Coordonnée en x de la tuile
    #   * _y_ - Coordonnée en y de la tuile
    #
    def surbrillanceTuile(x,y)
        Thread.new {
            @boutonAide.set_sensitive(false)
            0.upto(@nbClignotements*2-1) do |n|
                if(n%2 == 0) # Pair
                    @grille[x][y].set_sensitive(false)
                else # Impair
                    @grille[x][y].set_sensitive(true)
                end
                sleep(@vitesseClignotement)
            end
            sleep(@delaiReactivation)
            @boutonAide.set_sensitive(true)
        }    
    end

    ##
    # Méthode qui met en pause le chrono, et cache le jeu ainsi que le menu d'actions (annuler, repeter ...)
    #
    def cacherJeu()
        @modele.chrono.pause()
        @boxJeu.hide()
        @boxFooter.hide()
    end

    ##
    # Méthode qui remet en route le chrono, et montre le jeu ainsi que le menu d'actions (annuler, repeter ...)
    #
    def montrerJeu()
        @modele.chrono.finPause()
        @boxJeu.show()
        @boxFooter.show()
    end

    ##
    # Méthode qui permet de limiter la chaine à une longueur maximale en ajoutant un retour chariot
    # a chaque fois que la chaine dépasse la longueur maximale
    #
    # Paramètres::
    #   * _chaine_ - Chaine à couper
    #   * _longueurMax_ - Longueur maximale de la chaine après coupure
    #
    def couperChaine(chaine, longueurMax)
        chaine.gsub(/\s+/, " ").gsub(/(.{1,#{longueurMax}})( |\Z)/, "\\1\n")
    end

    ##
    # Méthode de création d'un bouton contenant un label en dessous de l'image qui se situe en haut 
    #
    # Paramètres::
    #   * _labelBouton_ - Label du bouton
    #   * _image_ - Image du bouton
    #
    # Retour::
    #   Le nouveau bouton
    #
    def creerBoutonImage(labelBouton,image)
        bouton = Button.new(:label => @controleur.getLangue[labelBouton])
        bouton.set_always_show_image(true)
        bouton.set_image_position(:top)
        bouton.set_image(Image.new(:file => './Ressources/' + image + '.png'))
        return bouton
    end

    ##
    # Méthode de création d'une boite de dialogue configurable (contenant une vbox) avec un titre et un bouton fermer
    #
    # Paramètre::
    #   * _titre_ - Titre de la fenetre
    #
    # Retour::
    #   La nouvelle boite de dialogue
    #
    def creerDialogMessage(titre)
        dialog = Dialog.new(:parent => @@fenetre, :title => titre, :flags => :modal,:buttons => [[@controleur.getLangue[:fermer],ResponseType::CLOSE]])
        dialog.child.set_spacing(20)
        return dialog
    end

    protected :actualiserGrille, :couperChaine, :surbrillanceLigne, :surbrillanceColonne, :cacherJeu, :montrerJeu

    ####################################
    #                                  #
    # =>    LISTENER DES BOUTONS    <= #
    #                                  #
    ####################################

    ##
    # => Listener des boutons du menu en haut
    ##

    ##
    # Listener sur le bouton pour sauvegarder une partie
    # Affiche une boite de dialogue afin de confirmer la sauvegarde
    # Si confirmation, affiche une entrée afin de renseigner la description de la sauvegarde
    # Puis affichage d'un message pour indiquer que la sauvegarde a réussie
    # Le jeu est cacher et le chrono est en pause pendant toute la durée des boites de dialogue
    #
    def onBtnSauvegarderClicked 
        self.cacherJeu()

        confirmation = false
        dialogSauvegarde = Dialog.new(:parent => @@fenetre, :title => @controleur.getLangue[:sauvegarder], :flags => :modal,:buttons => [[@controleur.getLangue[:oui],ResponseType::YES],[@controleur.getLangue[:non],ResponseType::NO]])
        
        labelSauvegarde = creerLabelTailleMoyenne(@controleur.getLangue[:confirmationSauvegarde])
        dialogSauvegarde.child.set_spacing(20)
        dialogSauvegarde.child.add(labelSauvegarde)

        dialogSauvegarde.show_all()
        dialogSauvegarde.run do |reponse|
            if(reponse == ResponseType::YES)
                confirmation = true
            else
                confirmation = false
            end             
        end
        dialogSauvegarde.destroy()

        if(confirmation)
            champDescription = Entry.new
            champDescription.set_max_length(20)

            # Nom par défaut :
            description = "Sauvegarde " + (@controleur.getNombreSauvegardes()+1).to_s

            dialogDescription = Dialog.new(:parent => @@fenetre, :title => "Description", :flags => :modal, :buttons => [[@controleur.getLangue[:valider],ResponseType::OK]])
            dialogDescription.child.set_spacing(20)
            dialogDescription.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:descriptionSauvegarde]))
            dialogDescription.child.add(champDescription)
            dialogDescription.show_all()
            dialogDescription.run do |reponse|
                if(reponse == ResponseType::OK)
                    if(champDescription.text() != "")
                        description = champDescription.text()
                    end
                end             
            end             
            dialogDescription.destroy()

            @controleur.sauvegarder(description)

            dialogConfirmation = creerDialogMessage(@controleur.getLangue[:sauvegarder])
            dialogConfirmation.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:sauvegardeEffectuee]))
            dialogConfirmation.show_all()
            dialogConfirmation.run()
            dialogConfirmation.destroy()
        end

        self.montrerJeu()
    end

    ##
    # Listener sur le bouton pour charger une partie
    # Met en pause le chrono, ferme le cadre et ouvre la vue qui permet de charger une partie
    #
    def onBtnChargerClicked 
        @modele.chrono.pause()
        fermerCadre()
        @controleur.charger()
    end

    ##
    # Listener sur le bouton options
    # Met en pause le chrono, ferme le cadre et ouvre la vue qui permet de configurer les options de l'utilisateur
    #
    def onBtnOptionsClicked
        @modele.chrono.pause()
        fermerCadre()
        @controleur.options()
    end

    ##
    # Listener sur le bouton pour afficher les règles
    # Affichage des trois règles du jeu dans une boite de dialogue.
    # Le jeu est cacher et le chrono est en pause pendant toute la durée de la boite de dialogue.
    #
    def onBtnReglesClicked 
        self.cacherJeu()

        dialogRegles = creerDialogMessage(@controleur.getLangue[:regles])
        dialogRegles.child.add(creerLabelTailleGrosse(@controleur.getLangue[:regles]))
        dialogRegles.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:regles1]))
        dialogRegles.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:regles2]))
        dialogRegles.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:regles3]))

        dialogRegles.show_all()
        dialogRegles.run()
        dialogRegles.destroy()

        self.montrerJeu()
    end

    ##
    # Listener sur le bouton pour quitter le jeu
    # Affiche une boite de dialogue afin de confirmer ou non.
    # Si confirmation, alors on retourne au menu principal sinon on continue la partie
    # Le jeu est cacher et le chrono est en pause pendant toute la durée de la boite de dialogue.
    #
    def onBtnQuitterClicked
        self.cacherJeu()
        confirmation = false

        dialogConfirmation = Dialog.new(:parent => @@fenetre, :title => @controleur.getLangue[:quitter], :flags => :modal,:buttons => [[@controleur.getLangue[:oui],ResponseType::YES],[@controleur.getLangue[:non],ResponseType::NO]])
        
        dialogConfirmation.child.set_spacing(20)
        dialogConfirmation.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:confirmationQuitter]))
        dialogConfirmation.show_all()

        dialogConfirmation.run do |reponse|
            if(reponse == ResponseType::YES)
                confirmation = true
            else
                confirmation = false
            end             
        end
        dialogConfirmation.destroy()

        if(confirmation)
            fermerCadre()
            @controleur.quitter()
        end

        self.montrerJeu()
    end

    ##
    # => Boutons du mode hypothèse
    ##

    ##
    # Listener sur le bouton pour lancer le mode hypothèse
    # Met le label indiquant que le mode hypothèse est activé et affiche les boutons pour valider ou annuler
    # Cache le bouton pour activer le mode hypothèse et active l'hypothèse dans le modèle partie
    #
    def onBtnHypoClicked
        @labelHypothese.set_label(@controleur.getLangue[:hypotheseActive])
        @boutonValiderHypothese.show()
        @boutonAnnulerHypothese.show()
        @boutonHypothese.hide()
        @modele.activerModeHypothese()
    end

    ##
    # Listener sur le bouton pour valider les hypothèses
    # Enlève le label indiquant que le mode hypothèse est activé et affiche le bouton pour activer le mode hypothèse
    # Cache les boutons pour valider ou annuler 
    # Puis valide l'hypothèse au niveau du modèle et actualisation de la grille (les tuiles moins opaques deviennent totalement opaques)
    #
    def onBtnValiderHypotheseClicked
        @labelHypothese.set_label("")
        @boutonValiderHypothese.hide()
        @boutonAnnulerHypothese.hide()
        @boutonHypothese.show()
        @modele.validerHypothese()
        self.actualiserGrille()
    end

    ##
    # Listener sur le bouton pour annuler les hypothèses
    # Enlève le label indiquant que le mode hypothèse est activé et affiche le bouton pour activer le mode hypothèse
    # Cache les boutons pour valider ou annuler 
    # Puis annule l'hypothèse au niveau du modèle et actualisation de la grille (les tuiles ajoutées pendant l'hypothèse deviennent vides)
    #
    def onBtnAnnulerHypotheseClicked
        @labelHypothese.set_label("")
        @boutonValiderHypothese.hide()
        @boutonAnnulerHypothese.hide()
        @boutonHypothese.show()
        @modele.annulerHypothese()
        self.actualiserGrille()
    end

    ##
    # => Tuiles de la grille et bouton de validation
    ##

    ##
    # Listener sur les tuiles de la grille
    # Si la tuile est valide (non vérouillée) alors on joue le coup dans le modèle
    # puis on actualise l'image de la tuile en fonction du nouvel état
    # ainsi que le nombre de tuiles à l'état 1/2 de la ligne et colonne ou se situe cette tuile
    # Si la grille est remplie, le bouton pour valider la grille devient actif
    #
    # Paramètre::
    #   * _tuileGtk_ - Tuile qui a été cliquée
    #
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

    ##
    # Listener sur le bouton pour valider la grille
    # Si la grille est invalide, on affiche un message signalant de bien vérifier que l'ensemble des règles sont appliquées
    # Sinon on ferme le cadre et on ouvre la vue affichant le résultat de cette partie
    #
    def onBtnValiderGrilleClicked
        if(!@modele.valider())
            dialogValidationGrille = creerDialogMessage(@controleur.getLangue[:grilleInvalide])

            dialogValidationGrille.child.add(creerLabelTailleGrosse(@controleur.getLangue[:grilleInvalide]))
            dialogValidationGrille.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:grilleInvalideExplications]))

            dialogValidationGrille.show_all()
            dialogValidationGrille.run()
            dialogValidationGrille.destroy()
        else      
            fermerCadre()
            @controleur.validerGrille() 
        end
    end

    ##
    # => Boutons du menu des actions en bas
    ##

    ##
    # Listener sur le bouton pour annuler le coup
    # Annule un coup au niveau du modèle puis on actualise l'image de la tuile en fonction du nouvel état
    # ainsi que le nombre de tuiles à l'état 1/2 de la ligne et colonne ou se situe cette tuile
    # 
    def onBtnUndoClicked
        tabCoord = @modele.historiqueUndo()
        if(tabCoord)
            @grille[tabCoord[0]+1][tabCoord[1]+1].setImageTuile(@modele.grille().getTuile(tabCoord[0],tabCoord[1]).etat())
            self.nbLigneColonne(tabCoord[0],tabCoord[1])
        end 
    end

    ##
    # Listener sur le bouton pour répéter le coup
    # Répéte le coup au niveau du modèle puis on actualise l'image de la tuile en fonction du nouvel état
    # ainsi que le nombre de tuiles à l'état 1/2 de la ligne et colonne ou se situe cette tuile
    # 
    def onBtnRedoClicked
        tabCoord = @modele.historiqueRedo()
        if(tabCoord)
            @grille[tabCoord[0]+1][tabCoord[1]+1].setImageTuile(@modele.grille().getTuile(tabCoord[0],tabCoord[1]).etat())
            self.nbLigneColonne(tabCoord[0],tabCoord[1])
        end
    end

    ##
    # Listener sur le bouton conseil
    # Si un conseil est disponible (au moins une règle doit être enfreinte), 
    # alors on met en surbrillance la ou les ligne(s)/colonne(s) concernée(s) puis on affiche la règle à appliquer sur la droite
    # Sinon on affiche une boite de dialogue indiquant que l'ensemble des règles sont respectées et qu'il faut utiliser l'aide
    # ou le mode hypothèse si on est bloqué. Le jeu est cacher et le chrono est en pause pendant toute la durée de la boite de dialogue.
    # 
    def onBtnConseilClicked
        conseil = @modele.appliquerRegles()

        if(conseil != nil)
            chaine = @controleur.getLangue[:appliquerRegle] + @controleur.getLangue[conseil[2]] + @controleur.getLangue[conseil[0]] 
            if(conseil[2] == :regles3)
                conseil[1][0] += 1
                conseil[1][1] += 1
                chaine += (conseil[1][0]).to_s 
                chaine += @controleur.getLangue[:et]
                chaine += conseil[1][1].to_s 
            else
                conseil[1] += 1
                chaine += conseil[1].to_s 
            end
            @labelConseil.set_markup("<big>" + couperChaine(chaine,30) + "</big>")

            if(conseil[0] == :regleLigne)
                if(conseil[2] == :regles3)
                    surbrillanceLigne(conseil[1][0])
                    surbrillanceLigne(conseil[1][1])
                else
                    surbrillanceLigne(conseil[1])
                end
            else
                if(conseil[2] == :regles3)
                    surbrillanceColonne(conseil[1][0])
                    surbrillanceColonne(conseil[1][1])
                else
                    surbrillanceColonne(conseil[1])
                end
            end

            Thread.new {
                @boutonConseil.set_sensitive(false)
                @labelConseil.show()
                sleep(@dureeConseils)
                @labelConseil.hide()
                sleep(@delaiReactivation)
                @boutonConseil.set_sensitive(true)
            }
        else
            self.cacherJeu()
            dialogRegles = creerDialogMessage(@controleur.getLangue[:conseil])
            dialogRegles.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:reglesRespectees]))

            dialogRegles.show_all()
            dialogRegles.run()
            dialogRegles.destroy()
            self.montrerJeu()
        end
    end

    ##
    # Listener sur le bouton aide
    # Si une aide est disponible, alors on modifie l'état d'une tuile par rapport à la solution pour aider le joueur
    # puis on actualise l'image de la tuile en fonction du nouvel état
    # ainsi que le nombre de tuiles à l'état 1/2 de la ligne et colonne ou se situe cette tuile
    # 
    def onBtnAideClicked
        aide = @modele.demanderAide() 

        if(aide != nil)
            @grille[aide[0]+1][aide[1]+1].setImageTuile(@modele.grille.getTuile(aide[0],aide[1]).etat()) 
            self.nbLigneColonne(aide[0],aide[1])
            surbrillanceTuile(aide[0]+1,aide[1]+1)
        end
    end

    ##
    # Listener sur le bouton pour recommencer la partie
    # Affiche une boite de dialogue afin de confirmer ou non
    # Si confirmation, on ferme le cadre et on retourne au menu principal
    # Sinon on ferme la boite de dialogue pour continuer la partie
    # Le jeu est cacher et le chrono est en pause pendant toute la durée de la boite de dialogue
    #
    def onBtnRecommencerClicked
        self.cacherJeu()

        dialogConfirmation = Dialog.new(:parent => @@fenetre, :title => @controleur.getLangue[:recommencer], :flags => :modal,:buttons => [[@controleur.getLangue[:oui],ResponseType::YES],[@controleur.getLangue[:non],ResponseType::NO]])
        
        dialogConfirmation.child.set_spacing(20)
        dialogConfirmation.child.add(creerLabelTailleMoyenne(@controleur.getLangue[:confirmationRecommencer]))
        dialogConfirmation.show_all()

        dialogConfirmation.run do |reponse|
            if(reponse == ResponseType::YES)
                @labelHypothese.set_label("")
                @boutonValiderHypothese.hide()
                @boutonAnnulerHypothese.hide()
                @boutonHypothese.show()
                @modele.recommencer
                self.actualiserGrille()
            end             
        end
        dialogConfirmation.destroy()

        self.montrerJeu()
    end

end