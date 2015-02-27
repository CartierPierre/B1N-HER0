require 'gtk3'
include Gtk

class Vue
    @fenetre
    @modele

    attr_reader :fenetre
    private_class_method :new

    def initialize(modele,titre)
        @modele = modele
        @fenetre = Window.new(titre)
		@fenetre.set_window_position(Gtk::Window::Position::CENTER)
		@fenetre.set_resizable(false)
    end

    def actualiser()

    end

end