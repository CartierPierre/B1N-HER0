require_relative 'Controleur'
require_relative '../Vue/VueMenuPrincipal'

class ControleurDemarrage < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueMenuPrincipal.new(@modele,"Menu principal")
	end	

end