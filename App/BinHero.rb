require 'gtk3'
include Gtk

require_relative './Controleur/ControleurMenuPrincipal'

class BinHero

	@controleur

    attr_writer :controleur

	def initialize
		Gtk.init
		@controleur = ControleurMenuPrincipal.new(self)
		Gtk.main
	end
end

binhero = BinHero.new()