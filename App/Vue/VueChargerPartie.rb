class VueChargerPartie < Vue

    ### Attributs d'instances

    @boutonDerniereTaille
    @bouton6x6
    @bouton8x8
    @bouton10x10
    @bouton12x12

    @boutonAnnuler

    @taille
    @partie

    @boutonDerniereSauvegarde
    @vboxSauvegardes

    ##
    # Classe qui permet de gérer les boutons de sauvegarde qui contient un objet Partie
    #
    class BoutonSauvegarde < Gtk::Button

        ### Attribut d'instance

        attr_reader :partie

        ##
        # Méthode de création du bouton de sauvegarde contenant une partie
        #
        # Paramètres::
        #   * _label_ - Label du bouton
        #   * _partie_ - Partie associé à ce bouton 
        #
        def initialize(label,partie)
            super(:label => label)
            @partie = partie
        end
    end

    ##
    # Méthode de création de la vue charger partie
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        # Box et boutons pour choisir la taille de la grille
        hboxTaille = Box.new(:horizontal, 10)

        @bouton6x6 = Button.new(:label => "6x6")
        @bouton8x8 = Button.new(:label => "8x8")
        @bouton10x10 = Button.new(:label => "10x10")
        @bouton12x12 = Button.new(:label => "12x12")

        @bouton6x6.signal_connect('clicked') { onBtnTailleClicked(@bouton6x6,6) }
        @bouton8x8.signal_connect('clicked') { onBtnTailleClicked(@bouton8x8,8) }
        @bouton10x10.signal_connect('clicked') { onBtnTailleClicked(@bouton10x10,10) }
        @bouton12x12.signal_connect('clicked') { onBtnTailleClicked(@bouton12x12,12) }

        hboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxTaille.add(@bouton6x6)
        hboxTaille.add(@bouton8x8)
        hboxTaille.add(@bouton10x10)
        hboxTaille.add(@bouton12x12)
        hboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Création de la box pour mettre les boutons de sauvegardes
        hboxScroll = Box.new(:horizontal)

        @fenetreScroll = ScrolledWindow.new()
        @fenetreScroll.set_policy(:never,:automatic)

        @vboxSauvegardes = Box.new(:vertical, 10)

        @fenetreScroll.add_with_viewport(@vboxSauvegardes)   
        hboxScroll.pack_start(Alignment.new(0, 0, 0.1, 0), :expand => true)
        hboxScroll.pack_start(@fenetreScroll)
        hboxScroll.pack_end(Alignment.new(1, 0, 0.1, 0), :expand => true)
        hboxScroll.set_size_request(300,200)

        # Boutons valider et annuler
        hboxChargerAnnuler = Box.new(:horizontal, 10)

        @boutonCharger = Button.new(:label => @controleur.getLangue[:charger])
        @boutonCharger.signal_connect('clicked') { onBtnChargerClicked }

        @boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonAnnuler.signal_connect('clicked') { onBtnAnnulerClicked }

        hboxChargerAnnuler.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxChargerAnnuler.add(@boutonCharger)
        hboxChargerAnnuler.add(@boutonAnnuler)
        hboxChargerAnnuler.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la vbox principale             
        vboxPrincipale = Box.new(:vertical, 20)

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(creerLabelTailleGrosse(@controleur.getLangue[:tailleGrille]))
        vboxPrincipale.add(hboxTaille)
        vboxPrincipale.add(hboxScroll)
        vboxPrincipale.add(hboxChargerAnnuler)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        # Actualisation et masquage des boutons de choix de difficultés
        @cadre.add(vboxPrincipale)
        self.actualiser()

        @fenetreScroll.hide()
        @boutonCharger.set_sensitive(false)
    end

    ##
    # Listener sur les boutons de choix de la taille de la grille
    #
    # Paramètres::
    #   * _bouton_ - Bouton qui a été cliqué
    #   * _taille_ - Taille de la grille sélectionnée
    #
    def onBtnTailleClicked(bouton, taille)   
        @taille = taille
        @fenetreScroll.show()

        parties = @controleur.getParties(@taille)

        @vboxSauvegardes.destroy()
        @vboxSauvegardes = Box.new(:vertical, 10)
        @fenetreScroll.add_with_viewport(@vboxSauvegardes) 

        parties.each do |partie|  
            labelPartie = "[" + @controleur.getLangue[:difficulte] + " " + partie[1].niveau.difficulte.to_s + "] " + partie[0]
            boutonSauvegarde = BoutonSauvegarde.new(labelPartie, partie[1])
            boutonSauvegarde.signal_connect('clicked') { onBtnSauvegardeClicked(boutonSauvegarde) }
            @vboxSauvegardes.add(boutonSauvegarde)
        end 

        @vboxSauvegardes.show_all()

        if(@partie)
            @boutonCharger.set_sensitive(false)
            @boutonDerniereSauvegarde.set_sensitive(true)
        end
        if(!@boutonDerniereTaille)
            @boutonDerniereTaille = bouton
        end
        @boutonDerniereTaille.set_sensitive(true)
        @boutonDerniereTaille = bouton
        @boutonDerniereTaille.set_sensitive(false)
    end

    ##
    # Listener sur les boutons de sauvegarde
    #
    # Paramètre::
    #   * _boutonSauvegarde_ - Bouton qui a été cliqué
    #
    def onBtnSauvegardeClicked(boutonSauvegarde)
        if(@boutonDerniereSauvegarde)
            @boutonDerniereSauvegarde.set_sensitive(true)
        end
        @boutonDerniereSauvegarde = boutonSauvegarde
        @boutonDerniereSauvegarde.set_sensitive(false)
        @boutonCharger.set_sensitive(true)
        @partie = @boutonDerniereSauvegarde.partie()
    end
    
    ##
    # Listener sur le bouton de chargement de la sauvegarde
    # Ferme le cadre et charge la partie sélectionnée
    #
    def onBtnChargerClicked
        fermerCadre()
        @controleur.charger(@partie)
    end

    ##
    # Listener sur le bouton annuler
    # Ferme le cadre et retourne au menu principal ou en partie selon la vue précédente
    #
    def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler
    end

end