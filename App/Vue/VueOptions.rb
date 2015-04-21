class VueOptions < Vue

    # Langue
    @labelLangue
    @boutonsLangue    
    @boutonLangueActif
    @languePrecedenteConstante

    # Couleur des tuiles
    @labelChoixCouleur
    @boutonsCouleurTuile
    @boutonCouleurTuile1Actif
    @boutonCouleurTuile2Actif
    @couleurTuile1
    @couleurTuile2

    # Boutons appliquer et annuler
    @boutonAppliquer
    @boutonAnnuler

    class BoutonLabel < Gtk::Button

        attr_reader :label

        def initialize(label)
            super(:label => label)
            @label = label
        end
    end

    def initTableauBoutonsLangue(label,langue)
        boutonTemp = BoutonLabel.new(label)
        boutonTemp.signal_connect('clicked')  { onBtnLangueClicked(boutonTemp,langue) }
        if(@controleur.getLangueConstante == langue)
            @boutonLangueActif = boutonTemp
            boutonTemp.set_sensitive(false)
        end
        @boutonsLangue.push(boutonTemp)
    end

    def initTableauBoutonsCouleurTuile(couleur)
        boutonTemp = Button.new()
        boutonTemp.set_image(Image.new(:pixbuf => Option::IMG[couleur]))
        boutonTemp.signal_connect('clicked')  { onBtnCouleurTuileClicked(boutonTemp,couleur) }
        if(@modele.couleurTuile1 == couleur)
            @boutonCouleurTuile1Actif = boutonTemp
            @boutonCouleurTuile1Actif.set_sensitive(false)
        end
        if(@modele.couleurTuile2 == couleur)
            @boutonCouleurTuile2Actif = boutonTemp
            @boutonCouleurTuile2Actif.set_sensitive(false)
        end
        @boutonsCouleurTuile.push(boutonTemp)
    end

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @languePrecedenteConstante = @controleur.getLangueConstante()
        @couleurTuile1 = @modele.couleurTuile1()
        @couleurTuile2 = @modele.couleurTuile2()

        # Choix de la langue
        boxLangue = Box.new(:horizontal, 10)

        @labelLangue = Label.new()
        @labelLangue.set_markup("<big>" + @controleur.getLangue[:langue] + "</big>")

        @boutonsLangue = Array.new()
        initTableauBoutonsLangue(@controleur.getLangue[:francais], Langue::FR)
        initTableauBoutonsLangue(@controleur.getLangue[:anglais], Langue::EN)

        boxLangue.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxLangue.add(@labelLangue)
        @boutonsLangue.each do |bouton|
            boxLangue.add(bouton)
        end
        boxLangue.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Choix de la couleur des tuiles
        boxCouleurTuile = Box.new(:horizontal, 10)

        @labelChoixCouleur = Label.new()
        @labelChoixCouleur.set_markup("<big>" + @controleur.getLangue[:couleurTuiles] + "</big>")

        @boutonsCouleurTuile = Array.new()
        initTableauBoutonsCouleurTuile(Option::TUILE_ROUGE)
        initTableauBoutonsCouleurTuile(Option::TUILE_BLEUE)
        initTableauBoutonsCouleurTuile(Option::TUILE_JAUNE)
        initTableauBoutonsCouleurTuile(Option::TUILE_VERTE)

        boxCouleurTuile.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        @boutonsCouleurTuile.each do |bouton|
            boxCouleurTuile.add(bouton)
        end
        boxCouleurTuile.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

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

        # Vbox principale                
        vboxPrincipale = Box.new(:vertical, 20)

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(boxLangue)
        vboxPrincipale.add(@labelChoixCouleur)
        vboxPrincipale.add(boxCouleurTuile)
        vboxPrincipale.add(hboxAppliquerAnnuler)
        vboxPrincipale.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)
        self.actualiser()
    end

    def actualiserLangue() 
        @@fenetre.title = "B1N HER0 - " + @controleur.getLangue[:options]        
        @labelLangue.set_markup("<big>" + @controleur.getLangue[:langue] + "</big>")
        @boutonsLangue.each do |bouton|
            bouton.set_label(bouton.label)
        end
        @labelChoixCouleur.set_markup("<big>" + @controleur.getLangue[:couleurTuiles] + "</big>")
        @boutonAppliquer.set_label(@controleur.getLangue[:appliquer])
        @boutonAnnuler.set_label(@controleur.getLangue[:annuler])
    end

    def onBtnLangueClicked(bouton,langue)
        @boutonLangueActif.set_sensitive(true)
        @boutonLangueActif = bouton
        @boutonLangueActif.set_sensitive(false)
        @controleur.setLangue(langue)
        self.actualiserLangue()
    end

    def onBtnCouleurTuileClicked(bouton,couleur)
        @boutonCouleurTuile1Actif.set_sensitive(true)
        @boutonCouleurTuile1Actif = @boutonCouleurTuile2Actif

        @boutonCouleurTuile2Actif = bouton   
        @boutonCouleurTuile2Actif.set_sensitive(false)   

        @couleurTemp = @couleurTuile1
        @couleurTuile1 = @couleurTuile2
        @couleurTuile2 = couleur
    end

    def onBtnAppliquerClicked        
        @modele.changerTuile1(@couleurTuile1)
        @modele.changerTuile2(@couleurTuile2)
        fermerCadre()
        @controleur.appliquer()
    end

    def onBtnAnnulerClicked
        @controleur.setLangue(@languePrecedenteConstante)
        fermerCadre()
        @controleur.annuler()
    end
end