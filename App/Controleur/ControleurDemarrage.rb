require_relative 'Controleur'
require_relative '../Vue/VueMenuPrincipal'

class ControleurMenuPrincipal < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueMenuPrincipal.new(@modele,"Menu principal")
	end	

end