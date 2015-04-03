class VueConnexion < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        vbox1 = Box.new(:vertical)
        vbox2 = Box.new(:vertical)
        vbox3 = Box.new(:vertical)
        hbox1 = Box.new(:horizontal)
        hbox2 = Box.new(:horizontal)
		bouttonValider = Button.new(:stock_id => Stock::APPLY)
		bouttonAnnuler = Button.new(:stock_id => Stock::CANCEL)
        @entryPseudo = Entry.new
        @entryPassword = Entry.new
        @entryPassword.visibility=(false)
        vbox2.pack_start(Label.new("Pseudo",true))
        vbox2.pack_end(Label.new("Mot De Passe",true))
        vbox2.set_homogeneous(true);
        vbox3.pack_start(@entryPseudo)
        vbox3.pack_end(@entryPassword)
        hbox1.add(vbox2)
        hbox1.add(vbox3)
        hbox2.pack_start(bouttonValider)
        hbox2.pack_end(bouttonAnnuler)
        vbox1.add(hbox1)
        vbox1.add(hbox2)
        @cadre.add(vbox1)


        bouttonValider.signal_connect('clicked')     {
            fermerCadre()
            onBtnValiderClicked
        }
        bouttonAnnuler.signal_connect('clicked')     {
            fermerCadre()
            onBtnAnnulerClicked
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

        bouttonOui.signal_connect('clicked')     {onBtnOuiClicked}
        bouttonNon.signal_connect('clicked')     {onBtnNonClicked}

        @popup.add(vbox)
        @popup.show_all()
    end
end
