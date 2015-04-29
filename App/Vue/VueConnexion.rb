class VueConnexion < Vue

    ##
    # Méthode de création de la vue du menu de connexion qui permet de se connecter au jeu
    #
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé
    #
    def initialize(modele,titre,controleur)         #:notnew:
        super(modele,titre,controleur)

        boxPrincipale = Box.new(:vertical,30)
        boxLabel = Box.new(:vertical)
        boxLabel.set_homogeneous(true)
        boxEntree = Box.new(:vertical,15)
        boxConnexion = Box.new(:horizontal,25)
        boxValidation = Box.new(:horizontal,10)

		boutonValider = Button.new(:label => @controleur.getLangue[:valider])
        boutonValider.set_sensitive(false)
		boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])

        @entryPseudo = Entry.new
        @entryPassword = Entry.new
        @entryPassword.visibility=(false)

        labelPseudo = Label.new(@controleur.getLangue[:pseudo],true)
        labelMotDePasse = Label.new(@controleur.getLangue[:motDePasse],true)

        boxLabel.add(labelPseudo)
        boxLabel.add(labelMotDePasse)
        boxLabel.set_homogeneous(true)

        boxEntree.add(@entryPseudo)
        boxEntree.add(@entryPassword)

        boxConnexion.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxConnexion.add(boxLabel)
        boxConnexion.add(boxEntree)
        boxConnexion.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        boxValidation.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxValidation.add(boutonValider)
        boxValidation.add(boutonAnnuler)
        boxValidation.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)


        boxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxPrincipale.add(boxConnexion)
        boxPrincipale.add(boxValidation)
        boxPrincipale.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(boxPrincipale)

        boutonValider.signal_connect('clicked')     {
            onBtnValiderClicked
        }

        boutonAnnuler.signal_connect('clicked')     {
            onBtnAnnulerClicked
        }

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
                    @entryPassword.signal_connect('activate')     {onBtnValiderClicked}
                end
            end
        }

        self.actualiser()
    end

	def onBtnValiderClicked
        @controleur.valider(@entryPseudo.text(),@entryPassword.text())
	end

	def onBtnAnnulerClicked
        fermerCadre
        @controleur.annuler()
	end

	def onBtnOuiClicked
        @popup.destroy
        fermerCadre
        @controleur.oui(@entryPseudo.text())

	end

	def onBtnNonClicked
        @popup.destroy
	end

	def mauvaisPasse
        popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:mauvaisPasse])
        popup.run
        popup.destroy
        @popup.present
	end

    def utilisateurInexistant
        @popup = Window.new(@controleur.getLangue[:utilisateurInexistant])
    	@popup.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
    	@popup.set_resizable(false)
        @popup.set_size_request(500,100)

		boutonOui = Button.new(:label => @controleur.getLangue[:oui])
		boutonNon = Button.new(:label => @controleur.getLangue[:non])

        hbox = Box.new(:horizontal,30)
        hbox.pack_start(boutonOui)
        hbox.pack_start(boutonNon)

        vbox = Box.new(:vertical,10)
        vbox.pack_start(Label.new(@controleur.getLangue[:pasDeCompte]))
        vbox.pack_start(Label.new(@controleur.getLangue[:creerCompte]))
        vbox.pack_end(hbox)

        boutonOui.signal_connect('clicked')     {onBtnOuiClicked}
        boutonNon.signal_connect('clicked')     {onBtnNonClicked}

        @popup.add(vbox)
        @popup.show_all()
    end

    def pasInternet(statut)
        if statut == "Online"
            @popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:pasInternetOnline])
        fermerCadre
        elsif statut == "Offline"
            @popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => @controleur.getLangue[:pasInternetOffline])
        end
        @popup.run
        @popup.destroy
    end
end
