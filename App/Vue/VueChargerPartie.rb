class VueChargerPartie < Vue

    @boutonDerniereTaille
    @bouton6x6
    @bouton8x8
    @bouton10x10
    @bouton12x12

    @boutonAnnuler

    @taille

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

        # Liste des sauvegardes
        hboxScroll = Box.new(:horizontal)

        @fenetreScroll = ScrolledWindow.new()
        @fenetreScroll.set_policy(:never,:automatic)
        @fenetreScroll.set_size_request(300,200)

        @parties = [
            "Sauvegarde 1",
            "Sauvegarde 2",
            "Sauvegarde 3",
            "Sauvegarde 4",
        ]

        modele = ListStore.new(String)

        column = TreeViewColumn.new("Parties", CellRendererText.new, {:text => 0})
        treeview = TreeView.new(modele)
        treeview.append_column(column)
        treeview.selection.set_mode(:single)
        @fenetreScroll.add_with_viewport(treeview)

        @parties.each do |v|
          iter = modele.append
          iter[0] = v
        end

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
        vboxPrincipale.add(@fenetreScroll)
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

        if(!@boutonDerniereTaille)
            @boutonDerniereTaille = bouton
        end
        @boutonDerniereTaille.set_sensitive(true)
        @boutonDerniereTaille = bouton
        @boutonDerniereTaille.set_sensitive(false)
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