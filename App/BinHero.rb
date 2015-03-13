require 'gtk3'
include Gtk

require_relative './Controleur/ControleurDemarrage'
<<<<<<< HEAD
=======
require_relative './Vue/VueMenuPrincipal'
require_relative './Vue/VuePartie'
require_relative './Modele/Grille'
require_relative './Modele/Tuile'
>>>>>>> origin/master

class BinHero

    @controleur

<<<<<<< HEAD
    attr_writer :controleur

	def initialize
		Gtk.init
		@controleur = ControleurDemarrage.new(self)
		Gtk.main
	end
=======
    def initialize
        Gtk.init
        @controleur = ControleurDemarrage.new(self)
        Gtk.main
    end
>>>>>>> origin/master
end

binhero = BinHero.new()