class Vue
    @fenetre
    @modele
    @controleur

    attr_writer :fenetre

    def initialize(modele,titre,controleur)
        @modele = modele
        @fenetre = Window.new(titre)
    	@fenetre.set_window_position(Gtk::Window::Position::CENTER_ALWAYS)
    	@fenetre.set_resizable(false)
        @controleur=controleur
        # @fenetre.signal_connect('destroy') {
            # Gtk.main_quit
        # }
    end

    def actualiser()
        @fenetre.show_all()
    end

    def fermerFenetre()
        @fenetre.destroy()
    end

    def nouveauBouton(labelBouton,image)
        bouton = Button.new(:label => @controleur.options.langue.langueActuelle[labelBouton])
        bouton.set_always_show_image(true)
        bouton.set_image_position(:top)
        bouton.set_image(Image.new(:file => './Vue/img/' + image + '.png'))
        return bouton
    end

end