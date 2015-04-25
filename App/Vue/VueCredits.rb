class VueCredits < Vue

    ### Attribut d'instance

    @boutonRetour

    ##
    # Méthode de création de la vue qui affiche les crédits du jeu
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
        vboxPrincipale.add(creerLabelTailleGrosse("B1N HER0"))
        vboxPrincipale.add(Label.new(@controleur.getLangue[:chefProjet] + " : Pierre CARTIER"))
        vboxPrincipale.add(Label.new(@controleur.getLangue[:documentaliste] + " : Quentin BOIVEAU"))
        vboxPrincipale.add(Label.new(@controleur.getLangue[:interfaceGraphique] + " : Loïc GUENVER et Corentin DELORME"))
        vboxPrincipale.add(Label.new(@controleur.getLangue[:baseDonnees] + " : Kévin DEMARET"))
        vboxPrincipale.add(Label.new(@controleur.getLangue[:codage] + " : Tianqi WEI et Amaury SAVARRE"))
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