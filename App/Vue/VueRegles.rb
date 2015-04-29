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

        vbox.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vbox.add(creerLabelTailleMoyenne(@controleur.getLangue[labelRegle]))
        vbox.add(hboxInvalide)
        vbox.add(hboxValide)
        vbox.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

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

        vboxPrincipale = Box.new(:vertical, 10)

        # Contient les règles du jeu sous forme d'onglets
        carnet = Notebook.new()
        carnet.append_page(creerBoxRegle(:regles1,"1"),Label.new(@controleur.getLangue[:regle] + " 1"))
        carnet.append_page(creerBoxRegle(:regles2,"2"),Label.new(@controleur.getLangue[:regle] + " 2"))
        carnet.append_page(creerBoxRegle(:regles3,"3"),Label.new(@controleur.getLangue[:regle] + " 3"))

        # Hbox et bouton retour qui permet de retourner au menu principal
        @boutonRetour = Button.new(:label => @controleur.getLangue[:retour])
        @boutonRetour.set_size_request(100,40)
        @boutonRetour.signal_connect('clicked') { onBtnRetourClicked }

        hboxRetour = Box.new(:horizontal)
        hboxRetour.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxRetour.add(@boutonRetour)
        hboxRetour.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la vbox principale
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(creerLabelTailleGrosse(@controleur.getLangue[:regles]))
        vboxPrincipale.add(carnet)
        vboxPrincipale.add(hboxRetour)
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