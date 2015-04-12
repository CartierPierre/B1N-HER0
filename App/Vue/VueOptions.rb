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

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

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

        @boutonImgTuileRouge = ToggleButton.new()
        @boutonImgTuileRouge.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_ROUGE]))
        @boutonImgTuileBleue = ToggleButton.new()
        @boutonImgTuileBleue.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_BLEUE]))
        @boutonImgTuileJaune = ToggleButton.new()
        @boutonImgTuileJaune.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_JAUNE]))
        @boutonImgTuileVerte = ToggleButton.new()
        @boutonImgTuileVerte.set_image(Image.new(:pixbuf => Option::IMG[Option::TUILE_VERTE]))

        if(@modele.couleurTuile1 == Option::TUILE_ROUGE)
            @boutonImgTuile1Actif = @boutonImgTuileRouge
            @boutonImgTuile1Actif.active = true
        end
        if(@modele.couleurTuile1 == Option::TUILE_BLEUE)
            @boutonImgTuile1Actif = @boutonImgTuileBleue
            @boutonImgTuile1Actif.active = true
        end  
        if(@modele.couleurTuile1 == Option::TUILE_JAUNE)
            @boutonImgTuile1Actif = @boutonImgTuileJaune
            @boutonImgTuile1Actif.active = true
        end
        if(@modele.couleurTuile1 == Option::TUILE_VERTE)
            @boutonImgTuile1Actif = @boutonImgTuileVerte
            @boutonImgTuile1Actif.active = true
        end
        if(@modele.couleurTuile2 == Option::TUILE_ROUGE)
            @boutonImgTuile2Actif = @boutonImgTuileRouge
            @boutonImgTuile2Actif.active = true
        end
        if(@modele.couleurTuile2 == Option::TUILE_BLEUE)
            @boutonImgTuile2Actif = @boutonImgTuileBleue
            @boutonImgTuile2Actif.active = true
        end
        if(@modele.couleurTuile2 == Option::TUILE_JAUNE)
            @boutonImgTuile2Actif = @boutonImgTuileJaune
            @boutonImgTuile2Actif.active = true
        end
        if(@modele.couleurTuile2 == Option::TUILE_VERTE)
            @boutonImgTuile2Actif = @boutonImgTuileVerte
            @boutonImgTuile2Actif.active = true
        end 

        @boutonImgTuileRouge.signal_connect('toggled') { onBtnImgTuileToggle(Option::TUILE_ROUGE,@boutonImgTuileRouge) }
        @boutonImgTuileBleue.signal_connect('toggled') { onBtnImgTuileToggle(Option::TUILE_BLEUE,@boutonImgTuileBleue) }
        @boutonImgTuileJaune.signal_connect('toggled') { onBtnImgTuileToggle(Option::TUILE_JAUNE,@boutonImgTuileJaune) }
        @boutonImgTuileVerte.signal_connect('toggled') { onBtnImgTuileToggle(Option::TUILE_VERTE,@boutonImgTuileVerte) }

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

    def onBtnImgTuileToggle(couleur,bouton)
        if(bouton != @boutonImgTuile1Actif && bouton != @boutonImgTuile2Actif) 
            @boutonImgTuile1Actif.active = false
            @boutonImgTuile1Actif = bouton
            @boutonImgTuile2Actif = @boutonImgTuile1Actif
        end
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
        @controleur.setLangueFr()
        self.actualiserLangue()
    end

    def onBtnLangueEnClicked
        @controleur.setLangueEn()
        self.actualiserLangue()
    end

    def onBtnAppliquerClicked

    end

    def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler()
    end
end