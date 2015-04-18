class VueOptions < Vue

    @labelLangue

    @boutonLangueFr
    @boutonLangueEn

    @labelChoixCouleur

    @boutonImgTuileRouge
    @boutonImgTuileBleue
    @boutonImgTuileJaune
    @boutonImgTuileVerte

    @boutonImgTuile1Actif
    @boutonImgTuile2Actif

    @boutonAppliquer
    @boutonAnnuler

    @couleurTuile1
    @couleurTuile2

    @languePrecedente

    def initBoutonImgTuile1Actif(bouton,couleur)
        if(@modele.couleurTuile1 == couleur)
            @boutonImgTuile1Actif = bouton
            @boutonImgTuile1Actif.set_sensitive(false)
        end
    end

    def initBoutonImgTuile2Actif(bouton,couleur)
        if(@modele.couleurTuile2 == couleur)
            @boutonImgTuile2Actif = bouton
            @boutonImgTuile2Actif.set_sensitive(false)
        end
    end

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @languePrecedente = @controleur.getLangueConstante()

        @couleurTuile1 = @modele.couleurTuile1()
        @couleurTuile2 = @modele.couleurTuile2()

        # Langue
        boxLangue = Box.new(:horizontal, 10)

        @labelLangue = Label.new()
        @labelLangue.set_markup("<big>" + @controleur.getLangue[:langue] + "</big>")
        @boutonLangueFr = Button.new(:label => @controleur.getLangue[:francais])
        @boutonLangueFr.signal_connect('clicked')  { onBtnLangueFrClicked }
        @boutonLangueEn = Button.new(:label => @controleur.getLangue[:anglais])
        @boutonLangueEn.signal_connect('clicked')  { onBtnLangueEnClicked }

        boxLangue.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxLangue.add(@labelLangue)
        boxLangue.add(@boutonLangueFr)
        boxLangue.add(@boutonLangueEn)
        boxLangue.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Images tuile
        boxImgTuile = Box.new(:horizontal, 10)

        @labelChoixCouleur = Label.new()
        @labelChoixCouleur.set_markup("<big>" + @controleur.getLangue[:couleurTuiles] + "</big>")

        @boutonImgTuileRouge = Button.new()
        @boutonImgTuileRouge.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_ROUGE]))
        @boutonImgTuileBleue = Button.new()
        @boutonImgTuileBleue.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_BLEUE]))
        @boutonImgTuileJaune = Button.new()
        @boutonImgTuileJaune.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_JAUNE]))
        @boutonImgTuileVerte = Button.new()
        @boutonImgTuileVerte.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_VERTE]))

        initBoutonImgTuile1Actif(@boutonImgTuileRouge, Option::TUILE_ROUGE)
        initBoutonImgTuile1Actif(@boutonImgTuileBleue, Option::TUILE_BLEUE)
        initBoutonImgTuile1Actif(@boutonImgTuileJaune, Option::TUILE_JAUNE)
        initBoutonImgTuile1Actif(@boutonImgTuileVerte, Option::TUILE_VERTE)

        initBoutonImgTuile2Actif(@boutonImgTuileRouge, Option::TUILE_ROUGE)
        initBoutonImgTuile2Actif(@boutonImgTuileBleue, Option::TUILE_BLEUE)
        initBoutonImgTuile2Actif(@boutonImgTuileJaune, Option::TUILE_JAUNE)
        initBoutonImgTuile2Actif(@boutonImgTuileVerte, Option::TUILE_VERTE)

        @boutonImgTuileRouge.signal_connect('clicked') { onBtnImgTuileClicked(Option::TUILE_ROUGE,@boutonImgTuileRouge) }
        @boutonImgTuileBleue.signal_connect('clicked') { onBtnImgTuileClicked(Option::TUILE_BLEUE,@boutonImgTuileBleue) }
        @boutonImgTuileJaune.signal_connect('clicked') { onBtnImgTuileClicked(Option::TUILE_JAUNE,@boutonImgTuileJaune) }
        @boutonImgTuileVerte.signal_connect('clicked') { onBtnImgTuileClicked(Option::TUILE_VERTE,@boutonImgTuileVerte) }

        boxImgTuile.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxImgTuile.add(@boutonImgTuileRouge)
        boxImgTuile.add(@boutonImgTuileBleue)
        boxImgTuile.add(@boutonImgTuileJaune)
        boxImgTuile.add(@boutonImgTuileVerte)
        boxImgTuile.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Boutons appliquer et annuler
        hboxAppliquerAnnuler = Box.new(:horizontal, 10)

        @boutonAppliquer = Button.new(:label => @controleur.getLangue[:appliquer])
        @boutonAppliquer.signal_connect('clicked') { onBtnAppliquerClicked }

        @boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonAnnuler.signal_connect('clicked') { onBtnAnnulerClicked }

        hboxAppliquerAnnuler.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxAppliquerAnnuler.add(@boutonAppliquer)
        hboxAppliquerAnnuler.add(@boutonAnnuler)
        hboxAppliquerAnnuler.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Box principale                
        boxPrincipale = Box.new(:vertical, 20)

        boxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxPrincipale.add(boxLangue)
        boxPrincipale.add(@labelChoixCouleur)
        boxPrincipale.add(boxImgTuile)
        boxPrincipale.add(hboxAppliquerAnnuler)
        boxPrincipale.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(boxPrincipale)
        self.actualiser()
    end

    def onBtnImgTuileClicked(couleur,bouton)
        @boutonImgTuile1Actif.set_sensitive(true)
        @boutonImgTuile1Actif = @boutonImgTuile2Actif

        @boutonImgTuile2Actif = bouton   
        @boutonImgTuile2Actif.set_sensitive(false)   

        @couleurTemp = @couleurTuile1
        @couleurTuile1 = @couleurTuile2
        @couleurTuile2 = couleur
    end

    def actualiserLangue() 
        @labelChoixCouleur.set_markup("<big>" + @controleur.getLangue[:couleurTuiles] + "</big>")
        @boutonLangueFr.set_label(@controleur.getLangue[:francais])
        @boutonLangueEn.set_label(@controleur.getLangue[:anglais])
        @boutonAppliquer.set_label(@controleur.getLangue[:appliquer])
        @boutonAnnuler.set_label(@controleur.getLangue[:annuler])
        @labelLangue.set_markup("<big>" + @controleur.getLangue[:langue] + "</big>")
    end

    def onBtnLangueFrClicked
        @controleur.setLangue(Langue::FR)
        self.actualiserLangue()
    end

    def onBtnLangueEnClicked
        @controleur.setLangue(Langue::EN)
        self.actualiserLangue()
    end

    def onBtnAppliquerClicked        
        @modele.changerTuile1(@couleurTuile1)
        @modele.changerTuile2(@couleurTuile2)
        fermerCadre()
        @controleur.annuler()
    end

    def onBtnAnnulerClicked
        @controleur.setLangue(@languePrecedente)
        fermerCadre()
        @controleur.annuler()
    end
end