# Require de toutes les dépendances
require_relative "./requireTout.rb"

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
