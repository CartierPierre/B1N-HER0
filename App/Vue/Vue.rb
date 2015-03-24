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
    end

    def actualiser()
        @fenetre.show_all()
    end

    def fermerFenetre()
        @fenetre.destroy()
    end

end