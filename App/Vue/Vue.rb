class Vue
    @@fenetre = Window.new("BinHero")
    @cadre
    @modele
    @controleur

    attr_writer :fenetre

    def initialize(modele,titre,controleur)
        @cadre = Frame.new()
        @@fenetre.add(@cadre)
        @modele = modele
        @@fenetre.title = titre
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

    def nouveauBouton(labelBouton,image)
        bouton = Button.new(:label => @controleur.getLangue[labelBouton])
        bouton.set_always_show_image(true)
        bouton.set_image_position(:top)
        bouton.set_image(Image.new(:file => './Ressources/' + image + '.png'))
        return bouton
    end

end