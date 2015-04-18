class VueCredits < Vue

    @boutonRetour

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        vboxPrincipale = Box.new(:vertical, 20)

        labelBinHero = Label.new()
        labelBinHero.set_markup("<big>B1N-HER0</big>")

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
        vboxPrincipale.add(labelBinHero)
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
    
    def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
    end

end