class VueInscription < Vue

    ##
    # Méthode de création de la vue du menu d'inscription qui permet de s'inscrire au jeu
    #
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé
    #
    def initialize(modele,titre,controleur,pseudo)   #:notnew:
        super(modele,titre,controleur)

        boxPrincipale = Box.new(:vertical,30)
        boxLabel = Box.new(:vertical)
        boxEntree = Box.new(:vertical,15)
        boxInscription = Box.new(:horizontal,25)
        boxMode = Box.new(:horizontal,10)
        boxValidation = Box.new(:horizontal,10)

		boutonValider = Button.new(:label => @controleur.getLangue[:valider])
        boutonValider.set_sensitive(false)
		boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonOnline  = RadioButton.new(@controleur.getLangue[:modeDeJeuEnLigne])
        @boutonOffline  = RadioButton.new(@boutonOnline,@controleur.getLangue[:modeDeJeuHorsLigne],true)
        @boutonOffline.set_active(true)

        @entryPseudo = Entry.new
        @entryPseudo.text = pseudo
        @entryPassword = Entry.new
        @entryPassword.visibility=(false)

        labelPseudo = Label.new(@controleur.getLangue[:pseudo],true)
        labelMotDePasse = Label.new(@controleur.getLangue[:motDePasse],true)

        boxLabel.add(labelPseudo)
        boxLabel.add(labelMotDePasse)
        boxLabel.set_homogeneous(true)

        boxEntree.add(@entryPseudo)
        boxEntree.add(@entryPassword)

        boxInscription.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxInscription.add(boxLabel)
        boxInscription.add(boxEntree)
        boxInscription.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        boxMode.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxMode.add(@boutonOnline)
        boxMode.add(@boutonOffline)
        boxMode.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        boxValidation.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxValidation.add(boutonValider)
        boxValidation.add(boutonAnnuler)
        boxValidation.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        boxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxPrincipale.add(boxInscription)
        boxPrincipale.add(boxMode)
        boxPrincipale.add(boxValidation)
        boxPrincipale.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(boxPrincipale)

        boutonValider.signal_connect('clicked')    {onBtnValiderClicked}
        boutonAnnuler.signal_connect('clicked')    {onBtnAnnulerClicked}

        @entryPseudo.signal_connect("key-release-event")     {
            if @entryPseudo.text() == "" || @entryPseudo.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                    @entryPseudo.signal_connect('activate')     {}
            else
                if @entryPassword.text() == "" || @entryPassword.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                    @entryPseudo.signal_connect('activate')     {}
                else
                    boutonValider.set_sensitive(true)
                    @entryPseudo.signal_connect('activate')     {onBtnValiderClicked}
                end
            end
        }

        @entryPassword.signal_connect("key-release-event")     {
            if @entryPassword.text() == "" || @entryPassword.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                    @entryPassword.signal_connect('activate')     {}
            else
                if @entryPseudo.text() == "" || @entryPseudo.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                    @entryPassword.signal_connect('activate')     {}
                else
                    boutonValider.set_sensitive(true)
                    @entryPassword.signal_connect('activate')   {onBtnValiderClicked}
                end
            end
        }

        actualiser()
    end

	def onBtnValiderClicked
        fermerCadre()
        if @boutonOnline.active?()
            resultat = @controleur.valider(@entryPseudo.text(),@entryPassword.text(),Utilisateur::ONLINE)
        else
            resultat = @controleur.valider(@entryPseudo.text(),@entryPassword.text(),Utilisateur::OFFLINE)
        end
        if resultat == 0
            utilisateurExistant(@entryPseudo.text())
        end
        if resultat == 1
            pasInternet(@entryPseudo.text())
        end
	end

	def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler()
	end

	def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
	end

    def utilisateurExistant(pseudo)
        @popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:lUtilisateur]+pseudo+@controleur.getLangue[:existe])
        @popup.run
        @popup.destroy
        @vue.fermerCadre
        @controleur.retour(pseudo)
    end

    def pasInternet(pseudo)
        @popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:pasInternetInscription])
        @popup.run
        @popup.destroy
        fermerCadre()
        @controleur.retour(pseudo)
    end

end
