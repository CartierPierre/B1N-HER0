require 'gtk3'

class Vue
    @fenetre
    @modele

    attr_reader :fenetre

    def initialize(modele,titre)
        @modele = modele
        @fenetre = Window.new(titre)
    		@fenetre.set_window_position(Gtk::Window::Position::CENTER)
    		@fenetre.set_resizable(true)
    end

    def actualiser()
        @fenetre.show_all()
    end

end