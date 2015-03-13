require 'gtk3'
include Gtk

require_relative './Controleur/ControleurDemarrage'
require_relative './Vue/VueMenuPrincipal'
require_relative './Vue/VuePartie'
require_relative './Modele/Grille'
require_relative './Modele/Tuile'
class BinHero

    @controleur

    attr_writer :controleur

    def initialize
        Gtk.init
        @controleur = ControleurDemarrage.new(self)
        Gtk.main
    end
end

binhero = BinHero.new()