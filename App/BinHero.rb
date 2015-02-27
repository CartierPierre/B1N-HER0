require 'gtk3'
include Gtk

require_relative './Controleur/ControleurDemarrage'

class BinHero

	@controleur

	def initialize
		Gtk.init
		@controleur = ControleurDemarrage.new(self)
		Gtk.main
	end
end

binhero = BinHero.new()