class VueOptions < Vue

    ### Attributs d'instances

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

    ##
    # Classe qui permet de gérer les boutons qui contient en plus une référence 
    # sur le label dans la classe Langue pour le changement de langue
    #
    class BoutonLabel < Gtk::Button

        ### Attribut d'instance

        attr_reader :labelLangue

        ##
        # Méthode de création du bouton
        #
        # Paramètres::
        #   * _label_ - Label du bouton
        #
        def initialize(label)
            super(:label => label)
            @labelLangue = label
        end
    end

    ##
    # Initialise le tableau contenant les boutons pour changer la langue
    #
    # Paramètres::
    #   * _label_ - Label du bouton
    #   * _langue_ - Constante de la classe Langue
    #
    def initTableauBoutonsLangue(label,langue)
        boutonTemp = BoutonLabel.new(label)
        boutonTemp.signal_connect('clicked')  { onBtnLangueClicked(boutonTemp,langue) }
        if(@controleur.getLangueConstante == langue)
            @boutonLangueActif = boutonTemp
            boutonTemp.set_sensitive(false)
        end
        @boutonsLangue.push(boutonTemp)
    end

    ##
    # Initialise le tableau contenant les boutons pour changer la couleur des tuiles de la grille
    #
    # Paramètre::
    #   * _couleur_ - Constante de la classe Option
    #
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

    ##
    # Méthode de création de la vue options qui permet de changer la langue du jeu
    # ainsi que la couleur des tuiles de la grille
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @languePrecedenteConstante = @controleur.getLangueConstante()
        @couleurTuile1 = @modele.couleurTuile1()
        @couleurTuile2 = @modele.couleurTuile2()

        # Box et boutons pour choisir la langue
        boxLangue = Box.new(:horizontal, 10)

        @labelLangue = creerLabelTailleGrosse(@controleur.getLangue[:langue])

        @boutonsLangue = Array.new()
        initTableauBoutonsLangue(@controleur.getLangue[:francais], Langue::FR)
        initTableauBoutonsLangue(@controleur.getLangue[:anglais], Langue::EN)

        boxLangue.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        boxLangue.add(@labelLangue)
        @boutonsLangue.each do |bouton|
            boxLangue.add(bouton)
        end
        boxLangue.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Box et boutons pour choisir la couleur des tuiles de la grille dans le jeu
        boxCouleurTuile = Box.new(:horizontal, 10)

        @labelChoixCouleur = creerLabelTailleGrosse(@controleur.getLangue[:couleurTuiles])

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

        # Boutons pour appliquer et annuler
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

    ##
    # Actualise la langue de la fenetre, des labels et boutons en fonction de celle sélectionnée
    #
    def actualiserLangue() 
        @@fenetre.title = "B1N HER0 - " + @controleur.getLangue[:options]        
        @labelLangue.set_markup("<big>" + @controleur.getLangue[:langue] + "</big>")
        @boutonsLangue.each do |bouton|
            bouton.set_label(bouton.labelLangue)
        end
        @labelChoixCouleur.set_markup("<big>" + @controleur.getLangue[:couleurTuiles] + "</big>")
        @boutonAppliquer.set_label(@controleur.getLangue[:appliquer])
        @boutonAnnuler.set_label(@controleur.getLangue[:annuler])
    end

    ##
    # Listener sur les boutons de choix de la langue
    #
    # Paramètres::
    #   * _bouton_ - Bouton qui a été cliqué
    #   * _langue_ - Langue sélectionnée
    #
    def onBtnLangueClicked(bouton,langue)
        @boutonLangueActif.set_sensitive(true)
        @boutonLangueActif = bouton
        @boutonLangueActif.set_sensitive(false)
        @controleur.setLangue(langue)
        self.actualiserLangue()
    end

    ##
    # Listener sur les boutons de choix de la couleur des tuiles de la grille
    #
    # Paramètres::
    #   * _bouton_ - Bouton qui a été cliqué
    #   * _couleur_ - Couleur sélectionnée
    #
    def onBtnCouleurTuileClicked(bouton,couleur)
        @boutonCouleurTuile1Actif.set_sensitive(true)
        @boutonCouleurTuile1Actif = @boutonCouleurTuile2Actif

        @boutonCouleurTuile2Actif = bouton   
        @boutonCouleurTuile2Actif.set_sensitive(false)   

        @couleurTemp = @couleurTuile1
        @couleurTuile1 = @couleurTuile2
        @couleurTuile2 = couleur
    end

    ##
    # Listener sur le bouton pour appliquer qui change au niveau du modèle les couleurs
    # puis ferme le cadre et retourne au menu principal ou en partie selon la vue précédente
    #
    def onBtnAppliquerClicked        
        @modele.changerTuile1(@couleurTuile1)
        @modele.changerTuile2(@couleurTuile2)
        fermerCadre()
        @controleur.appliquer()
    end

    ##
    # Listener sur le bouton pour annuler la configuration qui revient à son état antérieur
    # puis ferme le cadre et retourne au menu principal ou en partie selon la vue précédente
    #
    def onBtnAnnulerClicked
        @controleur.setLangue(@languePrecedenteConstante)
        fermerCadre()
        @controleur.annuler()
    end
end