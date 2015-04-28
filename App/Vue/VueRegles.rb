class VueRegles < Vue

    ### Attribut d'instance

    @boutonRetour

    ##
    # Méthode de création d'une box contenant l'explication d'une règle
    # ainsi qu'une image montrant un cas valide et une autre le cas invalide
    #
    # Paramètres::
    #   * _labelRegle_ - Label de la règle par rapport à la classe Langue
    #   * _numeroRegle_ - Numéro de la règle en caractère
    #
    # Retour::
    #   La nouvelle box contenant la règle.
    #
    def creerBoxRegle(labelRegle,numeroRegle)
        vbox = Box.new(:vertical, 10)
        hboxValide = Box.new(:horizontal,10)
        hboxInvalide = Box.new(:horizontal,10)

        hboxValide.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxValide.add(Image.new(:pixbuf => Gdk::Pixbuf.new(:file => "Ressources/regle" + numeroRegle + "Valide.png")))
        hboxValide.add(Image.new(:pixbuf => Gdk::Pixbuf.new(:file => "Ressources/valider.png")))
        hboxValide.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxInvalide.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxInvalide.add(Image.new(:pixbuf => Gdk::Pixbuf.new(:file => "Ressources/regle" + numeroRegle + "Invalide.png")))
        hboxInvalide.add(Image.new(:pixbuf => Gdk::Pixbuf.new(:file => "Ressources/annuler.png")))
        hboxInvalide.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vbox.add(creerLabelTailleMoyenne(@controleur.getLangue[labelRegle]))
        vbox.add(hboxInvalide)
        vbox.add(hboxValide)

        return vbox
    end

    ##
    # Méthode de création de la vue qui affiche les règles du jeu
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        vboxPrincipale = Box.new(:vertical, 20)

        # Bouton retour qui permet de retourner au menu principal
        @boutonRetour = Button.new(:label => @controleur.getLangue[:retour])
        @boutonRetour.set_size_request(100,40)
        @boutonRetour.signal_connect('clicked') { onBtnRetourClicked }

        # Ajout dans la vbox principale
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(creerLabelTailleGrosse(@controleur.getLangue[:regles]))
        vboxPrincipale.add(creerBoxRegle(:regles1,"1"))
        vboxPrincipale.add(creerBoxRegle(:regles2,"2"))
        vboxPrincipale.add(creerBoxRegle(:regles3,"3"))
        creerAlignBouton(vboxPrincipale,@boutonRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)      
        self.actualiser()
    end
    
    ##
    # Listener sur le bouton retour
    # Ferme le cadre et retourne au menu principal
    #
    def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
    end

end