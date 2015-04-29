class VueProfil < Vue
    ### Attributs d'instances

    #Les Statistique de l'Utilisateur
    @statistiques

    #Les boutons
    @boutonOnline
    @boutonOffline
    @boutonCompteActuel
    @boutonDeuxiemeCompte
    @boutonRetour
    @boutonPseudo
    @boutonPasse
    @boutonFusion
    @boutonReset
    @boutonSuppr
	@boutonValiderFusion
	@boutonAnnulerFusion


    #Les champs de formulaires
    @entryPasse
    @entryAncienPasse
    @entryFusionPseudo
    @entryFusionPasse

    #La fenêtre popup
    @popup

    ##
    # Méthode de création de la vue du profil qui permet de consulter les informations
    # relatives au profil, les succès et de gérer le profil
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé
    #
    def initialize(modele,titre,controleur)    #:notnew:
        super(modele,titre,controleur)

        #Récupération des statistiques depuis le controleur
        @statistiques = @controleur.getStatistiques

        #Variables utilisées pour les succès
        progressionPartie  = @statistiques["nbGrillesReso"]
        progressionParfait = @statistiques["nbPartiesParfaites"]

        #Le carnet de la vue profil
        carnet = Notebook.new()

        #Boutons radio
        @boutonOnline         = RadioButton.new(@controleur.getLangue[:modeDeJeuEnLigne])
        @boutonOffline        = RadioButton.new(@boutonOnline,@controleur.getLangue[:modeDeJeuHorsLigne],true)
        @boutonCompteActuel   = RadioButton.new(@controleur.getLangue[:compteActuel])
        @boutonDeuxiemeCompte = RadioButton.new(@boutonCompteActuel,@controleur.getLangue[:compte2],true)

        #Boutons classiques
        @boutonRetour         = Button.new(:label => @controleur.getLangue[:retour])
        @boutonPseudo         = Button.new(:label => @controleur.getLangue[:changerPseudo])
        @boutonPasse          = Button.new(:label => @controleur.getLangue[:changerPasse])
        @boutonFusion         = Button.new(:label => @controleur.getLangue[:fusion])
        @boutonReset          = Button.new(:label => @controleur.getLangue[:reset])
        @boutonSuppr          = Button.new(:label => @controleur.getLangue[:supprimerCompte])
		@boutonValiderFusion  = Button.new(:label => @controleur.getLangue[:valider])
		@boutonAnnulerFusion  = Button.new(:label => @controleur.getLangue[:annuler])

        #Champs de formulaires
        @entryPasse         = Entry.new
        @entryAncienPasse   = Entry.new
        @entryFusionPseudo = Entry.new
        @entryFusionPasse  = Entry.new

        #On cache le contenu des champs de mots de passe
        @entryPasse.visibility        = (false)
        @entryAncienPasse.visibility  = (false)
        @entryFusionPasse.visibility  = (false)

        @boutonValiderFusion.set_sensitive(false)
        @statistiques["statut"] == Utilisateur::OFFLINE ? @boutonOffline.set_active(true) : @boutonOffline.set_active(false)

        #gestion des signaux sur les boutons
        @boutonOffline.signal_connect('toggled')        { @controleur.changerType }
        @boutonRetour.signal_connect('clicked')         { onBtnRetourClicked }
        @boutonPseudo.signal_connect('clicked')         { onBtnPseudoClicked }
        @boutonPasse.signal_connect('clicked')          { onBtnPasseClicked }
        @boutonFusion.signal_connect('clicked')         { onBtnFusionClicked }
        @boutonReset.signal_connect('clicked')          { onBtnResetClicked }
        @boutonSuppr.signal_connect('clicked')          { onBtnSupprClicked }
        @boutonValiderFusion.signal_connect('clicked')  { onBtnValiderFusionClicked }
        @boutonAnnulerFusion.signal_connect('clicked')  { onBtnAnnulerClicked }

        #gestion des signaux sur les formulaires
        @entryFusionPseudo.signal_connect("key-release-event") {entryVerification}
        @entryFusionPasse.signal_connect("key-release-event") {entryVerification}

        #Récupération des images
        imageParfait10       = Image.new(:file => './Ressources/S_10_PARFAIT.png')
        imageParfait10Gris   = Image.new(:file => './Ressources/S_10_PARFAIT_GRIS.png')
        imageParfait50       = Image.new(:file => './Ressources/S_50_PARFAIT.png')
        imageParfait50Gris   = Image.new(:file => './Ressources/S_50_PARFAIT_GRIS.png')
        imageParfait100      = Image.new(:file => './Ressources/S_100_PARFAIT.png')
        imageParfait100Gris  = Image.new(:file => './Ressources/S_100_PARFAIT_GRIS.png')
        imageParfait500      = Image.new(:file => './Ressources/S_500_PARFAIT.png')
        imageParfait500Gris  = Image.new(:file => './Ressources/S_500_PARFAIT_GRIS.png')
        imageParfait1000     = Image.new(:file => './Ressources/S_1000_PARFAIT.png')
        imageParfait1000Gris = Image.new(:file => './Ressources/S_1000_PARFAIT_GRIS.png')

        imagePartie10       = Image.new(:file => './Ressources/S_10_PARTIES.png')
        imagePartie10Gris   = Image.new(:file => './Ressources/S_10_PARTIES_GRIS.png')
        imagePartie50       = Image.new(:file => './Ressources/S_50_PARTIES.png')
        imagePartie50Gris   = Image.new(:file => './Ressources/S_50_PARTIES_GRIS.png')
        imagePartie100      = Image.new(:file => './Ressources/S_100_PARTIES.png')
        imagePartie100Gris  = Image.new(:file => './Ressources/S_100_PARTIES_GRIS.png')
        imagePartie500      = Image.new(:file => './Ressources/S_500_PARTIES.png')
        imagePartie500Gris  = Image.new(:file => './Ressources/S_500_PARTIES_GRIS.png')
        imagePartie1000     = Image.new(:file => './Ressources/S_1000_PARTIES.png')
        imagePartie1000Gris = Image.new(:file => './Ressources/S_1000_PARTIES_GRIS.png')


        #Création des Labels des onglets
        labelGestion    = Label.new(@controleur.getLangue[:gestion])
        labelStats      = Label.new(@controleur.getLangue[:statistiques])
        labelSucces     = Label.new(@controleur.getLangue[:succes]  + " : " + @statistiques["succes"]+"/10")

        #Création des Labels de l'onglet Stats
        labelDate       = Label.new(@controleur.getLangue[:inscrit] + " : " + @statistiques["dateInscription"])
        labelGrilleReso = Label.new(@controleur.getLangue[:nbPartiesTermines] + " : " + @statistiques["nbGrillesReso"].to_s)
        labelNbAide     = Label.new(@controleur.getLangue[:nbAides] + " : " + @statistiques["nbAides"])
        labelNbConseil  = Label.new(@controleur.getLangue[:nbConseils] + " : " + @statistiques["nbConseils"])
        labelNbCoup     = Label.new(@controleur.getLangue[:nbCoups] + " : " + @statistiques["nbCoups"])
        labelPseudo     = Label.new(@controleur.getLangue[:pseudo]  + " : " + @statistiques["pseudo"])
        labelTpsTotal   = Label.new(@controleur.getLangue[:tempsDeJeu] + " : " + @statistiques["tempsTotal"])

        #Barres de progression pour les succès
        barreProgressionParfait10   = ProgressBar.new
        barreProgressionParfait50   = ProgressBar.new
        barreProgressionParfait100  = ProgressBar.new
        barreProgressionParfait500  = ProgressBar.new
        barreProgressionParfait1000 = ProgressBar.new

        barreProgressionPartie10   = ProgressBar.new
        barreProgressionPartie50   = ProgressBar.new
        barreProgressionPartie100  = ProgressBar.new
        barreProgressionPartie500  = ProgressBar.new
        barreProgressionPartie1000 = ProgressBar.new

        barreProgressionParfait10.show_text   = (true)
        barreProgressionParfait50.show_text   = (true)
        barreProgressionParfait100.show_text  = (true)
        barreProgressionParfait500.show_text  = (true)
        barreProgressionParfait1000.show_text = (true)

        barreProgressionPartie10.show_text= (true)
        barreProgressionPartie50.show_text= (true)
        barreProgressionPartie100.show_text= (true)
        barreProgressionPartie500.show_text= (true)
        barreProgressionPartie1000.show_text= (true)

        barreProgressionPartie10.text   = progressionPartie < 10   ? progressionPartie.to_s + "/10 "   + @controleur.getLangue[:partiesTermines] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionPartie50.text   = progressionPartie < 50   ? progressionPartie.to_s + "/50 "   + @controleur.getLangue[:partiesTermines] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionPartie100.text  = progressionPartie < 100  ? progressionPartie.to_s + "/100 "  + @controleur.getLangue[:partiesTermines] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionPartie500.text  = progressionPartie < 500  ? progressionPartie.to_s + "/500 "  + @controleur.getLangue[:partiesTermines] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionPartie1000.text = progressionPartie < 1000 ? progressionPartie.to_s + "/1000 " + @controleur.getLangue[:partiesTermines] : @controleur.getLangue[:succesDeverrouille]

        barreProgressionParfait10.text   = progressionParfait < 10   ? progressionParfait.to_s + "/10 "   + @controleur.getLangue[:partiesParfaites] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionParfait50.text   = progressionParfait < 50   ? progressionParfait.to_s + "/50 "   + @controleur.getLangue[:partiesParfaites] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionParfait100.text  = progressionParfait < 100  ? progressionParfait.to_s + "/100 "  + @controleur.getLangue[:partiesParfaites] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionParfait500.text  = progressionParfait < 500  ? progressionParfait.to_s + "/500 "  + @controleur.getLangue[:partiesParfaites] : @controleur.getLangue[:succesDeverrouille]
        barreProgressionParfait1000.text = progressionParfait < 1000 ? progressionParfait.to_s + "/1000 " + @controleur.getLangue[:partiesParfaites] : @controleur.getLangue[:succesDeverrouille]

        barreProgressionParfait10.fraction   = progressionParfait < 10   ? progressionParfait / 10.0   : 1
        barreProgressionParfait50.fraction   = progressionParfait < 50   ? progressionParfait / 50.0   : 1
        barreProgressionParfait100.fraction  = progressionParfait < 100  ? progressionParfait / 100.0  : 1
        barreProgressionParfait500.fraction  = progressionParfait < 500  ? progressionParfait / 500.0  : 1
        barreProgressionParfait1000.fraction = progressionParfait < 1000 ? progressionParfait / 1000.0 : 1

        barreProgressionPartie10.fraction   = progressionPartie < 10   ? progressionPartie / 10.0   : 1
        barreProgressionPartie50.fraction   = progressionPartie < 50   ? progressionPartie / 50.0   : 1
        barreProgressionPartie100.fraction  = progressionPartie < 100  ? progressionPartie / 100.0  : 1
        barreProgressionPartie500.fraction  = progressionPartie < 500  ? progressionPartie / 500.0  : 1
        barreProgressionPartie1000.fraction = progressionPartie < 1000 ? progressionPartie / 1000.0 : 1

        #Boxs des succès
        hboxSuccesPartie10 = Box.new(:horizontal,30)
        hboxSuccesPartie10.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesPartie10.add(barreProgressionPartie10)
        hboxSuccesPartie10.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesPartie50 = Box.new(:horizontal,30)
        hboxSuccesPartie50.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesPartie50.add(barreProgressionPartie50)
        hboxSuccesPartie50.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesPartie100 = Box.new(:horizontal,30)
        hboxSuccesPartie100.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesPartie100.add(barreProgressionPartie100)
        hboxSuccesPartie100.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesPartie500 = Box.new(:horizontal,30)
        hboxSuccesPartie500.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesPartie500.add(barreProgressionPartie500)
        hboxSuccesPartie500.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesPartie1000 = Box.new(:horizontal,30)
        hboxSuccesPartie1000.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesPartie1000.add(barreProgressionPartie1000)
        hboxSuccesPartie1000.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        vboxSuccesGauche = Box.new(:vertical, 10)
        vboxSuccesGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxSuccesGauche.add(hboxSuccesPartie10)
        vboxSuccesGauche.add(hboxSuccesPartie50)
        vboxSuccesGauche.add(hboxSuccesPartie100)
        vboxSuccesGauche.add(hboxSuccesPartie500)
        vboxSuccesGauche.add(hboxSuccesPartie1000)
        vboxSuccesGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxSuccesParfait10 = Box.new(:horizontal,30)
        hboxSuccesParfait10.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesParfait10.add(barreProgressionParfait10)
        hboxSuccesParfait10.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesParfait50 = Box.new(:horizontal,30)
        hboxSuccesParfait50.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesParfait50.add(barreProgressionParfait50)
        hboxSuccesParfait50.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesParfait100 = Box.new(:horizontal,30)
        hboxSuccesParfait100.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesParfait100.add(barreProgressionParfait100)
        hboxSuccesParfait100.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesParfait500 = Box.new(:horizontal,30)
        hboxSuccesParfait500.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesParfait500.add(barreProgressionParfait500)
        hboxSuccesParfait500.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxSuccesParfait1000 = Box.new(:horizontal,30)
        hboxSuccesParfait1000.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSuccesParfait1000.add(barreProgressionParfait1000)
        hboxSuccesParfait1000.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        barreProgressionPartie10.fraction   < 1 ? hboxSuccesPartie10.add(imagePartie10Gris)     : hboxSuccesPartie10.add(imagePartie10)
        barreProgressionPartie50.fraction   < 1 ? hboxSuccesPartie50.add(imagePartie50Gris)     : hboxSuccesPartie50.add(imagePartie50)
        barreProgressionPartie100.fraction  < 1 ? hboxSuccesPartie100.add(imagePartie100Gris)   : hboxSuccesPartie100.add(imagePartie100)
        barreProgressionPartie500.fraction  < 1 ? hboxSuccesPartie500.add(imagePartie500Gris)   : hboxSuccesPartie500.add(imagePartie500)
        barreProgressionPartie1000.fraction < 1 ? hboxSuccesPartie1000.add(imagePartie1000Gris) : hboxSuccesPartie1000.add(imagePartie1000)

        barreProgressionParfait10.fraction   < 1 ? hboxSuccesParfait10.add(imageParfait10Gris)     : hboxSuccesParfait10.add(imageParfait10)
        barreProgressionParfait50.fraction   < 1 ? hboxSuccesParfait50.add(imageParfait50Gris)     : hboxSuccesParfait50.add(imageParfait50)
        barreProgressionParfait100.fraction  < 1 ? hboxSuccesParfait100.add(imageParfait100Gris)   : hboxSuccesParfait100.add(imageParfait100)
        barreProgressionParfait500.fraction  < 1 ? hboxSuccesParfait500.add(imageParfait500Gris)   : hboxSuccesParfait500.add(imageParfait500)
        barreProgressionParfait1000.fraction < 1 ? hboxSuccesParfait1000.add(imageParfait1000Gris) : hboxSuccesParfait1000.add(imageParfait1000)

        vboxSuccesDroite = Box.new(:vertical, 10)
        vboxSuccesDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxSuccesDroite.add(hboxSuccesParfait10)
        vboxSuccesDroite.add(hboxSuccesParfait50)
        vboxSuccesDroite.add(hboxSuccesParfait100)
        vboxSuccesDroite.add(hboxSuccesParfait500)
        vboxSuccesDroite.add(hboxSuccesParfait1000)
        vboxSuccesDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxSucces = Box.new(:horizontal,30)
        hboxSucces.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxSucces.add(vboxSuccesGauche)
        hboxSucces.add(vboxSuccesDroite)
        hboxSucces.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        #Boxs des Stats
        vboxStatsGauche = Box.new(:vertical, 30)
        vboxStatsGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxStatsGauche.add(labelPseudo)
        vboxStatsGauche.add(labelGrilleReso)
        vboxStatsGauche.add(labelNbCoup)
        vboxStatsGauche.add(labelNbAide)
        vboxStatsGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxStatsDroite = Box.new(:vertical, 30)
        vboxStatsDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxStatsDroite.add(labelDate)
        vboxStatsDroite.add(labelTpsTotal)
        vboxStatsDroite.add(labelNbConseil)
        vboxStatsDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxStats = Box.new(:horizontal,30)
        hboxStats.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxStats.add(vboxStatsGauche)
        hboxStats.add(vboxStatsDroite)
        hboxStats.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        hboxStatut = Box.new(:horizontal,30)
        hboxStatut.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxStatut.add(@boutonOnline)
        hboxStatut.add(@boutonOffline)
        hboxStatut.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        vboxStats = Box.new(:vertical,30)
        vboxStats.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        vboxStats.add(hboxStats)
        vboxStats.add(hboxStatut)
        vboxStats.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        #Boxs de la Gestion
        vboxConfigGauche = Box.new(:vertical, 30)
        vboxConfigGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxConfigGauche.add(@boutonPseudo)
        vboxConfigGauche.add(@boutonPasse)
        vboxConfigGauche.add(@boutonSuppr)
        vboxConfigGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxConfigDroite = Box.new(:vertical, 30)
        vboxConfigDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxConfigDroite.add(@boutonFusion)
        vboxConfigDroite.add(@boutonReset)
        vboxConfigDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxConfig = Box.new(:horizontal,30)
        hboxConfig.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxConfig.add(vboxConfigGauche)
        hboxConfig.add(vboxConfigDroite)
        hboxConfig.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        #Box pour le bouton retour
		hboxRetour = Box.new(:horizontal)
        hboxRetour.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxRetour.add(@boutonRetour)
        hboxRetour.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        #ajout des pages au carnet
        carnet.append_page(vboxStats,labelStats)
        carnet.append_page(hboxSucces,labelSucces)
        carnet.append_page(hboxConfig,labelGestion)

        #Box principale de la Vue profil
        vboxPrincipale = Box.new(:vertical, 10)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(carnet)
        vboxPrincipale.add(hboxRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)


        @cadre.add(vboxPrincipale)
        self.actualiser()
    end

    ##
    # Méthode de retour au menu principal
    #
	def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
	end

    ##
    # Méthode de remise à zéro du compte
    #
    def onBtnResetClicked
        @controleur.reset
    end

    ##
    # Méthode de suppression du compte
    #
    def onBtnSupprClicked
        @controleur.supprimerUtilisateur
    end

    ##
    # Méthode affichant la popup permettant le changement de mot de passe
    #
	def onBtnPasseClicked
        @popup = Window.new(@controleur.getLangue[:passeChanger])
    	@popup.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
    	@popup.set_resizable(false)
        @popup.set_size_request(500,100)

		boutonValider = Button.new(:label => @controleur.getLangue[:valider])
		boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        boutonValider.set_sensitive(false)

        @entryPasse.signal_connect("key-release-event")     {
            if @entryPasse.text() == "" || @entryPasse.text() =~ /\W/
                boutonValider.set_sensitive(false)
                @entryPasse.signal_connect('activate')   {}
            else
                if @entryAncienPasse.text() == "" || @entryAncienPasse.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                    @entryPasse.signal_connect('activate')   {}
                else
                    boutonValider.set_sensitive(true)
                    @entryPasse.signal_connect('activate')   {onBtnValiderPasseClicked(@entryPasse.text,@entryAncienPasse.text)}
                end
            end


        @entryAncienPasse.signal_connect("key-release-event")     {
            if @entryAncienPasse.text() == "" || @entryAncienPasse.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                    @entryAncienPasse.signal_connect('activate')   {}
            else
                if @entryPasse.text() == "" || @entryPasse.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                    @entryAncienPasse.signal_connect('activate')   {}
                else
                    boutonValider.set_sensitive(true)
                    @entryAncienPasse.signal_connect('activate')   {onBtnValiderPasseClicked(@entryPasse.text,@entryAncienPasse.text)}
                end
            end
        }


        vboxLabel = Box.new(:vertical,25)
        vboxLabel.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxLabel.add(Label.new(@controleur.getLangue[:passeAncien]))
        vboxLabel.add(Label.new(@controleur.getLangue[:passeNouveau]))
        vboxLabel.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxEntree = Box.new(:vertical,10)
        vboxEntree.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxEntree.add(@entryAncienPasse)
        vboxEntree.add(@entryPasse)
        vboxEntree.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxForm = Box.new(:horizontal,30)
        hboxForm.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxForm.add(vboxLabel)
        hboxForm.add(vboxEntree)
        hboxForm.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxValider = Box.new(:horizontal,30)
        hboxValider.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxValider.add(boutonValider)
        hboxValider.add(boutonAnnuler)
        hboxValider.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        boutonValider.signal_connect('clicked')     {onBtnValiderPasseClicked(@entryPasse.text,@entryAncienPasse.text)}
        boutonAnnuler.signal_connect('clicked')     {onBtnAnnulerClicked}

        @boxPrincipalePasse = Box.new(:vertical,30)
        @boxPrincipalePasse.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        @boxPrincipalePasse.add(hboxForm)
        @boxPrincipalePasse.add(hboxValider)
        @boxPrincipalePasse.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        @popup.add(@boxPrincipalePasse)
        @popup.show_all()
	end

    ##
    # Méthode de changement de mot de passe
    #
	def onBtnValiderPasseClicked(passe,ancienPasse)
        if passe == ancienPasse
            popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:passeDifferent])
            popup.run
            popup.destroy
            @popup.present
        else
            if @controleur.validerPasse(passe)
                popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:passeChange])
                popup.run
                popup.destroy
                @popup.destroy
            else
                popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:mauvaisPasse])
                popup.run
                popup.destroy
                @popup.present
            end
        end
    end

    ##
    # Méthode qui affiche la popup permettant le changement de pseudo
    #
    def onBtnPseudoClicked

        @popup = Window.new(@controleur.getLangue[:pseudoChanger])
    	@popup.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
    	@popup.set_resizable(false)
        @popup.set_size_request(500,100)

        @entryPseudo = Entry.new

		boutonValider = Button.new(:label => @controleur.getLangue[:valider])
		boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])

        hboxForm = Box.new(:horizontal,30)
        hboxForm.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxForm.add(Label.new(@controleur.getLangue[:pseudo]))
        hboxForm.add(@entryPseudo)
        hboxForm.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxValider = Box.new(:horizontal,30)
        hboxValider.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxValider.add(boutonValider)
        hboxValider.add(boutonAnnuler)
        hboxValider.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        boutonValider.signal_connect('clicked')     {onBtnValiderPseudoClicked(@entryPseudo.text)}
        boutonAnnuler.signal_connect('clicked')     {onBtnAnnulerClicked}

        boxPrincipalePseudo = Box.new(:vertical,30)
        boxPrincipalePseudo.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxPrincipalePseudo.add(hboxForm)
        boxPrincipalePseudo.add(hboxValider)
        boxPrincipalePseudo.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        @popup.add(boxPrincipalePseudo)
        @popup.show_all()
	end

    ##
    # Méthode de changement de pseudo
    #
    def onBtnValiderPseudoClicked(pseudo)
        if @controleur.validerPseudo(@entryPseudo.text)
            popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:pseudoChange])
            popup.run
            popup.destroy
            @popup.destroy
        else
            popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:lUtilisateur]+pseudo+@controleur.getLangue[:existe])
            popup.run
            popup.destroy
        end
        @controleur.actualiser
	end

    ##
    # Méthode qui affiche la popup permettant la fusion de comptes
    #
    def onBtnFusionClicked
        @popup = Window.new(@controleur.getLangue[:fusion])
    	@popup.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
    	@popup.set_resizable(false)
        @popup.set_size_request(500,100)

        vboxFusionEntry = Box.new(:vertical,10)
        vboxFusionEntry.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxFusionEntry.add(@entryFusionPseudo)
        vboxFusionEntry.add(@entryFusionPasse)
        vboxFusionEntry.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxFusionLabel = Box.new(:vertical,25)
        vboxFusionLabel.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxFusionLabel.add(Label.new(@controleur.getLangue[:pseudo]))
        vboxFusionLabel.add(Label.new(@controleur.getLangue[:motDePasse]))
        vboxFusionLabel.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxFusionForm1 = Box.new(:horizontal,30)
        hboxFusionForm1.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxFusionForm1.add(vboxFusionLabel)
        hboxFusionForm1.add(vboxFusionEntry)
        hboxFusionForm1.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxFusionForm2 = Box.new(:horizontal,30)
        hboxFusionForm2.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxFusionForm2.add(@boutonCompteActuel)
        hboxFusionForm2.add(@boutonDeuxiemeCompte)
        hboxFusionForm2.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxFusionForm = Box.new(:vertical,10)
        vboxFusionForm.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxFusionForm.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxValiderFusion = Box.new(:horizontal,30)
        hboxValiderFusion.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxValiderFusion.add(@boutonValiderFusion)
        hboxValiderFusion.add(@boutonAnnulerFusion)
        hboxValiderFusion.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        boxPrincipaleFusion = Box.new(:vertical,30)
        boxPrincipaleFusion.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxPrincipaleFusion.add(Label.new(@controleur.getLangue[:compteSync]))
        boxPrincipaleFusion.add(hboxFusionForm1)
        boxPrincipaleFusion.add(Label.new(@controleur.getLangue[:compteGarde]))
        boxPrincipaleFusion.add(hboxFusionForm2)
        boxPrincipaleFusion.add(hboxValiderFusion)
        boxPrincipaleFusion.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        @popup.add(boxPrincipaleFusion)
        @popup.show_all()
    end

    ##
    # Méthode permettant la fusion de comptes
    #
    def onBtnValiderFusionClicked
        @controleur.fusion(@entryFusionPseudo.text,@entryFusionPasse.text,(@boutonCompteActuel.active? ? false : true))
        @popup.destroy
        @controleur.actualiser
    end

    def entryVerification
        @boutonValiderFusion.set_sensitive(true)
        @entryFusionPseudo.signal_connect('activate') {onBtnValiderFusionClicked}
        @entryFusionPasse.signal_connect('activate') {onBtnValiderFusionClicked}

        if @entryFusionPseudo.text() == "" || @entryFusionPseudo.text() =~ /\W/
            @boutonValiderFusion.set_sensitive(false)
            @entryFusionPseudo.signal_connect('activate') {}
            @entryFusionPasse.signal_connect('activate') {}
        end

        if @entryFusionPasse.text() == "" || @entryFusionPasse.text() =~ /\W/
            @boutonValiderFusion.set_sensitive(false)
            @entryFusionPseudo.signal_connect('activate') {}
            @entryFusionPasse.signal_connect('activate') {}
        end
    end

    ##
    # Méthode d'annulation depuis la popup
    #
	def onBtnAnnulerClicked
        @popup.destroy
        @controleur.annuler
	end
end
