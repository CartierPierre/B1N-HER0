class VueResultatPartie < Vue

    @boutonRetour

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        vboxPrincipale = Box.new(:vertical, 20)

        @boutonRetour = Button.new(:label => @controleur.getLangue[:retournerMenuPrincipal])
        @boutonRetour.set_size_request(100,40)

        labelScore = Label.new()
        labelScore.set_markup("<big>" + @controleur.getLangue[:score] + " : " + "0" + "</big>")

        labelTemps = Label.new()
        labelTemps.set_markup("<big>" + @controleur.getLangue[:temps] + " : " + "00:00" + "</big>")

        labelNbCoups = Label.new()
        labelNbCoups.set_markup("<big>" + @controleur.getLangue[:nbCoups] + " : " + "0" + "</big>")

        labelConseils = Label.new()
        labelConseils.set_markup("<big>" + @controleur.getLangue[:nbConseils] + " : " + "0" + "</big>")

        labelAides = Label.new()
        labelAides.set_markup("<big>" + @controleur.getLangue[:nbAides] + " : " + "0" + "</big>")

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(labelScore)
        vboxPrincipale.add(labelTemps)
        vboxPrincipale.add(labelNbCoups)
        vboxPrincipale.add(labelConseils)
        vboxPrincipale.add(labelAides)
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