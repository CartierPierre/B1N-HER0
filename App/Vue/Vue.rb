class Vue
    ### Attribut de classe

    @@fenetre = Window.new("B1N-HER0")

    ### Attributs d'instances

    @cadre
    @modele
    @controleur

    attr_writer :fenetre

    ##
    # Méthode de création de la vue
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
    def initialize(modele,titre,controleur)
        @cadre = Frame.new()
        @@fenetre.add(@cadre)
        @modele = modele
        @@fenetre.title = "B1N HER0 - " + titre
    	@@fenetre.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
        @@fenetre.set_size_request(420,410)
        @controleur=controleur

        @@fenetre.signal_connect('destroy') {
            @controleur.quitterJeu
        }
    end

    ##
    # Actualise les éléments graphiques de la vue
    #
    def actualiser()
        @@fenetre.show_all()
    end

    ##
    # Ferme le cadre pour changer de vue
    #
    def fermerCadre()
        @@fenetre.remove(@cadre)
    end

    ##
    # Méthode qui permet de creer un bouton aligné au centre de la Box
    #
    # Paramètres::
    #   * _box_ - Box où le bouton sera ajouter
    #   * _bouton_ - Bouton à ajouter 
    #
    def creerAlignBouton(box,bouton) 
        align = Alignment.new(0.5, 0, 0.6, 0)
        align.add(bouton)
        box.add(align)
    end

    ##
    # Méthode qui permet de creer un nouveau label avec un texte de taille 10.5
    #
    # Paramètre::
    #   * _texte_ - Texte du label
    #
    # Retour::
    #   Le nouveau label
    #
    def creerLabelTailleMoyenne(texte)
        label = Label.new()
        label.set_markup(%Q[ <span font_desc="10.5">#{texte}</span>])
        return label
    end

    ##
    # Méthode qui permet de creer un nouveau label avec un texte en taille big
    #
    # Paramètre::
    #   * _texte_ - Texte du label
    #
    # Retour::
    #   Le nouveau label
    #
    def creerLabelTailleGrosse(texte)
        label = Label.new()
        label.set_markup("<big>" + texte + "</big>")
        return label
    end

end