class VueInscription < Vue

    def initialize(modele,titre,controleur,pseudo)
        super(modele,titre,controleur)

        vbox1 = Box.new(:vertical)
        vbox2 = Box.new(:vertical)
        vbox3 = Box.new(:vertical)

        hbox1 = Box.new(:horizontal)
        hbox2 = Box.new(:horizontal)
        hbox3 = Box.new(:horizontal)

		boutonValider = Button.new(:stock_id => Stock::APPLY)
        boutonValider.set_sensitive(false)

		boutonAnnuler = Button.new(:stock_id => Stock::CANCEL)

        @boutonOnline  = CheckButton.new("Mode Online" )

        @entryPseudo = Entry.new
        @entryPseudo.text = pseudo

        @entryPassword = Entry.new
        @entryPassword.visibility=(false)


        vbox2.pack_start(Label.new("Pseudo",true))
        vbox2.pack_end(Label.new("Mot De Passe",true))
        vbox2.set_homogeneous(true);

        vbox3.pack_start(@entryPseudo)
        vbox3.pack_end(@entryPassword)

        hbox1.add(vbox2)
        hbox1.add(vbox3)

        hbox2.pack_start(boutonValider)
        hbox2.pack_end(boutonAnnuler)

        vbox1.add(hbox1)
        vbox1.pack_end(hbox2)
        vbox1.pack_end(@boutonOnline)

        @cadre.add(vbox1)

        boutonValider.signal_connect('clicked')    {onBtnValiderClicked}
        boutonAnnuler.signal_connect('clicked')    {onBtnAnnulerClicked}

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
        @entryPassword.signal_connect('activate')   {onBtnValiderClicked}

        actualiser()
    end

	def onBtnValiderClicked
        fermerCadre()
        if @boutonOnline.active?()
            @controleur.valider(@entryPseudo.text(),@entryPassword.text(),Utilisateur::ONLINE)
        else
            @controleur.valider(@entryPseudo.text(),@entryPassword.text(),Utilisateur::OFFLINE)
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
        @popup = Gtk::MessageDialog.new(:parent => @@fenetre,:flags => :destroy_with_parent, :type => :info, :buttons_type => :close,:message => "L'utilisateur "+pseudo+" existe déja.")

        @popup.run
        fermerCadre()
        @popup.destroy
        @controleur.retour(pseudo)
    end

end
