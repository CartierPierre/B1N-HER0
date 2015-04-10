class VueOptions < Vue

    @labelLangue

    @boutonLangueFr
    @boutonLangueEn

    @boutonImgTuileRouge
    @boutonImgTuileBleue
    @boutonImgTuileJaune
    @boutonImgTuileVerte

    @boutonImgTuile1Actif
    @boutonImgTuile2Actif

    @boutonRetour

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        
        boxPrincipale = Box.new(:vertical)

        # Langue
        boxLangue = Box.new(:horizontal)

        @labelLangue = Label.new(@controleur.getLangue[:langue])
        boxLangue.add(@labelLangue)
        @boutonLangueFr = Button.new(:label => @controleur.getLangue[:francais])
        @boutonLangueFr.signal_connect('clicked')  { onBtnLangueFrClicked }
        @boutonLangueEn = Button.new(:label => @controleur.getLangue[:anglais])
        @boutonLangueEn.signal_connect('clicked')  { onBtnLangueEnClicked }

        boxLangue.add(@boutonLangueFr)
        boxLangue.add(@boutonLangueEn)

        @boutonRetour = Button.new(:label => @controleur.getLangue[:retour])
        @boutonRetour.signal_connect('clicked')  {onBtnRetourClicked}

        # Images tuile
        boxImgTuile = Box.new(:horizontal)

        @boutonImgTuileRouge = ToggleButton.new()
        @boutonImgTuileRouge.set_image(Image.new(:pixbuf => Option::TUILE_ROUGE))
        @boutonImgTuileBleue = ToggleButton.new()
        @boutonImgTuileBleue.set_image(Image.new(:pixbuf => Option::TUILE_BLEUE))
        @boutonImgTuileJaune = ToggleButton.new()
        @boutonImgTuileJaune.set_image(Image.new(:pixbuf => Option::TUILE_JAUNE))
        @boutonImgTuileVerte = ToggleButton.new()
        @boutonImgTuileVerte.set_image(Image.new(:pixbuf => Option::TUILE_VERTE))

        if(@modele.couleurTuile1 == "Rouge")
            @boutonImgTuile1Actif = @boutonImgTuileRouge
            @boutonImgTuile1Actif.active = true
        end
        if(@modele.couleurTuile1 == "Bleue")
            @boutonImgTuile1Actif = @boutonImgTuileBleue
            @boutonImgTuile1Actif.active = true
        end  
        if(@modele.couleurTuile1 == "Jaune")
            @boutonImgTuile1Actif = @boutonImgTuileJaune
            @boutonImgTuile1Actif.active = true
        end
        if(@modele.couleurTuile1 == "Verte")
            @boutonImgTuile1Actif = @boutonImgTuileVerte
            @boutonImgTuile1Actif.active = true
        end
        if(@modele.couleurTuile2 == "Rouge")
            @boutonImgTuile2Actif = @boutonImgTuileRouge
            @boutonImgTuile2Actif.active = true
        end
        if(@modele.couleurTuile2 == "Bleue")
            @boutonImgTuile2Actif = @boutonImgTuileBleue
            @boutonImgTuile2Actif.active = true
        end
        if(@modele.couleurTuile2 == "Jaune")
            @boutonImgTuile2Actif = @boutonImgTuileJaune
            @boutonImgTuile2Actif.active = true
        end
        if(@modele.couleurTuile2 == "Verte")
            @boutonImgTuile2Actif = @boutonImgTuileVerte
            @boutonImgTuile2Actif.active = true
        end 

        @boutonImgTuileRouge.signal_connect('toggled') { onBtnImgTuileToggle("Rouge") }
        @boutonImgTuileBleue.signal_connect('toggled') { onBtnImgTuileToggle("Bleue") }
        @boutonImgTuileJaune.signal_connect('toggled') { onBtnImgTuileToggle("Jaune") }
        @boutonImgTuileVerte.signal_connect('toggled') { onBtnImgTuileToggle("Verte") }

        boxImgTuile.add(@boutonImgTuileRouge)
        boxImgTuile.add(@boutonImgTuileBleue)
        boxImgTuile.add(@boutonImgTuileJaune)
        boxImgTuile.add(@boutonImgTuileVerte)

        boxPrincipale.add(boxLangue)
        boxPrincipale.add(boxImgTuile)
        boxPrincipale.add(@boutonRetour)

        @cadre.add(boxPrincipale)
        self.actualiser()
    end

    def onBtnImgTuileToggle(couleur,bouton)
        if(couleur == "Rouge") 

        end
    end

    def actualiserLangue() 
        @boutonLangueFr.set_label(@controleur.getLangue[:francais])
        @boutonLangueEn.set_label(@controleur.getLangue[:anglais])
        @boutonRetour.set_label(@controleur.getLangue[:retour])
        @labelLangue.set_label(@controleur.getLangue[:langue])
    end

    def onBtnLangueFrClicked
        @controleur.setLangueFr()
        self.actualiserLangue()
    end

    def onBtnLangueEnClicked
        @controleur.setLangueEn()
        self.actualiserLangue()
    end

    def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
    end
end