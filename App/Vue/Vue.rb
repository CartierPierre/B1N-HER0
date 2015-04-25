class Vue
    @@fenetre = Window.new("B1N-HER0")
    @cadre
    @modele
    @controleur

    attr_writer :fenetre

    def initialize(modele,titre,controleur)
        @cadre = Frame.new()
        @@fenetre.add(@cadre)
        @modele = modele
        @@fenetre.title = "B1N HER0 - " + titre
    	@@fenetre.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
        @@fenetre.set_size_request(420,410)
        @controleur=controleur

        @@fenetre.signal_connect('destroy') {
            Gtk.main_quit
        }
    end

    def actualiser()
        @@fenetre.show_all()
    end

    def fermerCadre()
        @@fenetre.remove(@cadre)
    end

    def creerAlignBouton(box,bouton) 
        align = Alignment.new(0.5, 0, 0.6, 0)
        align.add(bouton)
        box.add(align)
    end

    def creerLabelTailleMoyenne(texte)
        label = Label.new()
        label.set_markup(%Q[ <span font_desc="11">#{texte}</span>])
        return label
    end

    def creerLabelTailleGrosse(texte)
        label = Label.new()
        label.set_markup("<big>" + texte + "</big>")
        return label
    end

end