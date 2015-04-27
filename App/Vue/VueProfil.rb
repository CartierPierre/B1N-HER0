class VueProfil < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @statistiques = @controleur.getStatistiques

        @boutonRetour = Button.new(:label => @controleur.getLangue[:retour])
        @boutonPseudo = Button.new(:label => @controleur.getLangue[:changerPseudo])
        @boutonPasse = Button.new(:label => @controleur.getLangue[:changerPasse])
        @boutonRetour.signal_connect('clicked') { onBtnRetourClicked }
        @boutonPseudo.signal_connect('clicked') { onBtnPseudoClicked }
        @boutonPasse.signal_connect('clicked') { onBtnPasseClicked }

        progressionPartie  = @statistiques["nbGrillesReso"]
        progressionParfait = @statistiques["nbPartiesParfaites"]

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

        labelStats      = Label.new(@controleur.getLangue[:statistiques])
        labelSucces     = Label.new(@controleur.getLangue[:succes]  + " : " + @statistiques["succes"]+"/10")
        labelPseudo     = Label.new(@controleur.getLangue[:pseudo]  + " : " + @statistiques["pseudo"])
        labelDate       = Label.new(@controleur.getLangue[:inscrit] + " : " + @statistiques["dateInscription"])
        labelNbCoup     = Label.new(@controleur.getLangue[:nbCoups] + " : " + @statistiques["nbCoups"])
        labelNbConseil  = Label.new(@controleur.getLangue[:nbConseils] + " : " + @statistiques["nbConseils"])
        labelNbAide     = Label.new(@controleur.getLangue[:nbAides] + " : " + @statistiques["nbAides"])
        labelTpsTotal   = Label.new(@controleur.getLangue[:tempsDeJeu] + " : " + @statistiques["tempsTotal"])
        labelGrilleReso = Label.new(@controleur.getLangue[:nbPartiesTermines] + " : " + @statistiques["nbGrillesReso"].to_s)

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

        carnet = Notebook.new()

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

        vboxStatsGauche = Box.new(:vertical, 10)
        vboxStatsGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxStatsGauche.add(labelPseudo)
        vboxStatsGauche.add(labelDate)
        vboxStatsGauche.add(labelGrilleReso)
        vboxStatsGauche.add(labelNbCoup)
        vboxStatsGauche.add(labelNbAide)
        vboxStatsGauche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxStatsDroite = Box.new(:vertical, 10)
        vboxStatsDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxStatsDroite.add(@boutonPseudo)
        vboxStatsDroite.add(@boutonPasse)
        vboxStatsDroite.add(labelTpsTotal)
        vboxStatsDroite.add(labelNbConseil)
        vboxStatsDroite.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxStats = Box.new(:horizontal,30)
        hboxStats.pack_start(Alignment.new(0, 0, 0, 0),:expand => true)
        hboxStats.add(vboxStatsGauche)
        hboxStats.add(vboxStatsDroite)
        hboxStats.pack_end(Alignment.new(0, 0, 0, 0),:expand => true)

        carnet.append_page(hboxStats,labelStats)
        carnet.append_page(hboxSucces,labelSucces)

		hboxRetour = Box.new(:horizontal)
        hboxRetour.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxRetour.add(@boutonRetour)
        hboxRetour.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxPrincipale = Box.new(:vertical, 10)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(carnet)
        vboxPrincipale.add(hboxRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)
        self.actualiser()
    end

	def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
	end

	def onBtnValiderPasseClicked(passe,ancienPasse)
        @entryPasse = Entry.new
        @entryAncienPasse = Entry.new
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

	def onBtnAnnulerClicked
        @popup.destroy
        @controleur.annuler
	end

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
        fermerCadre()
        @controleur.actualiser
	end

	def onBtnPasseClicked
        @popup = Window.new(@controleur.getLangue[:passeChange])
    	@popup.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
    	@popup.set_resizable(false)
        @popup.set_size_request(500,100)

        @entryPasse = Entry.new
        @entryAncienPasse = Entry.new
        @entryPasse.visibility=(false)
        @entryAncienPasse.visibility=(false)

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
        }

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

    def onBtnPseudoClicked
        @popup = Window.new(@controleur.getLangue[:pseudoChange])
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
end