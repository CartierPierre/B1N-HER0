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

        labelChefProjet = Label.new()
        labelChefProjet.set_label(@controleur.getLangue[:chefProjet] + " : Pierre CARTIER")

        labelDoc = Label.new()
        labelDoc.set_label(@controleur.getLangue[:documentaliste] + " : Quentin BOIVEAU")

        labelInterface = Label.new()
        labelInterface.set_label(@controleur.getLangue[:interfaceGraphique] + " : Loïc GUENVER et Corentin DELORME")

        labelBdd = Label.new()
        labelBdd.set_label(@controleur.getLangue[:baseDonnees] + " : Kévin DEMARET")

        labelCodage = Label.new()
        labelCodage.set_label(@controleur.getLangue[:codage] + " : Tianqi WEI et Amaury SAVARRE")

        @boutonRetour = Button.new(:label => @controleur.getLangue[:retour])
        @boutonRetour.set_size_request(100,40)

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(creerLabelTailleGrosse("B1N HER0"))
        vboxPrincipale.add(labelChefProjet)
        vboxPrincipale.add(labelDoc)
        vboxPrincipale.add(labelInterface)
        vboxPrincipale.add(labelBdd)
        vboxPrincipale.add(labelCodage)
        creerAlignBouton(vboxPrincipale,@boutonRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)

        @boutonRetour.signal_connect('clicked') { onBtnRetourClicked }
      
        self.actualiser()
    end
    
    ##
    # Listener sur le bouton annuler
    # Ferme le cadre et retourne au menu principal
    #
    def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
    end

end