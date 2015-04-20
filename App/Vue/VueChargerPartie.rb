class VueChargerPartie < Vue

    @boutonDerniereTaille
    @bouton6x6
    @bouton8x8
    @bouton10x10
    @bouton12x12

    @boutonAnnuler

    @taille
    @partie

    @boutonDerniereSauvegarde

    class BoutonSauvegarde < Gtk::Button

        attr_reader :partie

        def initialize(label,partie)
            super(:label => label)
            @partie = partie
        end
    end

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        # Box et boutons taille de la grille
        hboxTaille = Box.new(:horizontal, 10)

        labelTaille = Label.new()
        labelTaille.set_markup("<big>" + @controleur.getLangue[:tailleGrille] + "</big>")

        @bouton6x6 = Button.new(:label => "6x6")
        @bouton8x8 = Button.new(:label => "8x8")
        @bouton10x10 = Button.new(:label => "10x10")
        @bouton12x12 = Button.new(:label => "12x12")

        @bouton6x6.signal_connect('clicked') { onBtnTailleClicked(6,@bouton6x6) }
        @bouton8x8.signal_connect('clicked') { onBtnTailleClicked(8,@bouton8x8) }
        @bouton10x10.signal_connect('clicked') { onBtnTailleClicked(10,@bouton10x10) }
        @bouton12x12.signal_connect('clicked') { onBtnTailleClicked(12,@bouton12x12) }

        hboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxTaille.add(@bouton6x6)
        hboxTaille.add(@bouton8x8)
        hboxTaille.add(@bouton10x10)
        hboxTaille.add(@bouton12x12)
        hboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Sauvegardes
        hboxScroll = Box.new(:horizontal)

        @fenetreScroll = ScrolledWindow.new()
        @fenetreScroll.set_policy(:never,:automatic)

        parties = Array["Sauvegarde 1","Sauvegarde 2","Sauvegarde 3","Sauvegarde 4","Sauvegarde 5","Sauvegarde 6","Sauvegarde 7"]

        vboxSauvegardes = Box.new(:vertical, 10)
        parties.each do |partie|
            boutonSauvegarde = BoutonSauvegarde.new(partie.to_s, partie)
            boutonSauvegarde.signal_connect('clicked') { onBtnSauvegardeClicked(boutonSauvegarde) }
            vboxSauvegardes.add(boutonSauvegarde)
        end 

        @fenetreScroll.add_with_viewport(vboxSauvegardes)   
        hboxScroll.pack_start(Alignment.new(0, 0, 0.1, 0), :expand => true)
        hboxScroll.pack_start(@fenetreScroll)
        hboxScroll.pack_end(Alignment.new(1, 0, 0.1, 0), :expand => true)
        hboxScroll.set_size_request(300,200)

        # Boutons valider et annuler
        hboxValiderAnnuler = Box.new(:horizontal, 10)

        @boutonValider = Button.new(:label => @controleur.getLangue[:charger])
        @boutonValider.signal_connect('clicked') { onBtnValiderClicked }

        @boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonAnnuler.signal_connect('clicked') { onBtnAnnulerClicked }

        hboxValiderAnnuler.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxValiderAnnuler.add(@boutonValider)
        hboxValiderAnnuler.add(@boutonAnnuler)
        hboxValiderAnnuler.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la vbox principale             
        vboxPrincipale = Box.new(:vertical, 20)

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(labelTaille)
        vboxPrincipale.add(hboxTaille)
        vboxPrincipale.add(hboxScroll)
        vboxPrincipale.add(hboxValiderAnnuler)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        # Actualisation et masquage des boutons de choix de difficultés
        @cadre.add(vboxPrincipale)
        self.actualiser()

        @fenetreScroll.hide()
        @boutonValider.set_sensitive(false)
    end

    def onBtnTailleClicked(taille,bouton)   
        @taille = taille
        @fenetreScroll.show()

        if(@partie)
            @boutonValider.set_sensitive(false)
            @boutonDerniereSauvegarde.set_sensitive(true)
        end
        if(!@boutonDerniereTaille)
            @boutonDerniereTaille = bouton
        end
        @boutonDerniereTaille.set_sensitive(true)
        @boutonDerniereTaille = bouton
        @boutonDerniereTaille.set_sensitive(false)
    end

    def onBtnSauvegardeClicked(boutonSauvegarde)
        if(@boutonDerniereSauvegarde)
            @boutonDerniereSauvegarde.set_sensitive(true)
        end
        @boutonDerniereSauvegarde = boutonSauvegarde
        @boutonDerniereSauvegarde.set_sensitive(false)
        @boutonValider.set_sensitive(true)
        @partie = @boutonDerniereSauvegarde.partie()
    end
    
    def onBtnValiderClicked
        fermerCadre()
        @controleur.jouer(@taille,@difficulte)
    end

    def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler
    end

end