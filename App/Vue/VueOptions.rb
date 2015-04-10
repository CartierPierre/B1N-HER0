class VueOptions < Vue

    @labelLangue

    @boutonLangueFr
    @boutonLangueEn

    @boutonImgTuileRouge
    @boutonImgTuileBleue
    @boutonImgTuileJaune
    @boutonImgTuileVerte

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