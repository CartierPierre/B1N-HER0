class VueConnexion < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)


        boxPrincipale = Box.new(:vertical,30)
        boxLabel = Box.new(:vertical)
        boxLabel.set_homogeneous(true)
        boxEntree = Box.new(:vertical)
        boxConnexion = Box.new(:horizontal,10)
        boxValidation = Box.new(:horizontal,10)

		boutonValider = Button.new(:stock_id => Stock::APPLY)
        boutonValider.set_sensitive(false)
		boutonAnnuler = Button.new(:stock_id => Stock::CANCEL)

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
            fermerCadre()
            onBtnValiderClicked
        }
        boutonAnnuler.signal_connect('clicked')     {
            fermerCadre()
            onBtnAnnulerClicked
        }
        @entryPseudo.signal_connect("key-release-event")     {
            if @entryPseudo.text() == "" || @entryPseudo.text() =~ /\W/
                    boutonValider.set_sensitive(false)
            else
                if @entryPassword.text() == "" || @entryPassword.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                else
                    boutonValider.set_sensitive(true)
                end
            end
        }
        @entryPseudo.signal_connect('activate')     {onBtnValiderClicked}

        @entryPassword.signal_connect("key-release-event")     {
            if @entryPassword.text() == "" || @entryPassword.text() =~ /\W/
                    boutonValider.set_sensitive(false)
            else
                if @entryPseudo.text() == "" || @entryPseudo.text() =~ /\W/
                    boutonValider.set_sensitive(false)
                else
                    boutonValider.set_sensitive(true)
                end
            end
        }

        @entryPseudo.signal_connect('activate')     {
            fermerCadre()
            onBtnValiderClicked
        }
        @entryPassword.signal_connect('activate')   {
            fermerCadre()
            onBtnValiderClicked
        }

        self.actualiser()
    end

	def onBtnValiderClicked
        @controleur.valider(@entryPseudo.text(),@entryPassword.text())
	end

	def onBtnAnnulerClicked
        @controleur.annuler()
	end

	def onBtnOuiClicked
        @popup.destroy
        @controleur.oui(@entryPseudo.text())

	end

	def onBtnNonClicked
        @popup.destroy
        @controleur.non()
	end

    def utilisateurInexistant
        @popup = Window.new("Utilisateur Inexistant")
    	@popup.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
    	@popup.set_resizable(false)
        @popup.set_size_request(500,100)

		boutonOui = Button.new(:label => "Oui")
		boutonNon = Button.new(:label => "Non")

        hbox = Box.new(:horizontal)
        hbox.pack_start(boutonOui)
        hbox.pack_start(boutonNon)

        vbox = Box.new(:vertical)
        vbox.pack_start(Label.new("Il n'existe pas de compte associé à ce pseudo."))
        vbox.pack_start(Label.new("Voulez-vous créer un compte avec ce pseudo ?"))
        vbox.pack_end(hbox)

        boutonOui.signal_connect('clicked')     {onBtnOuiClicked}
        boutonNon.signal_connect('clicked')     {onBtnNonClicked}

        @popup.add(vbox)
        @popup.show_all()
    end
end
