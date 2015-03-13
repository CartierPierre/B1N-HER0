require_relative './Controleur'

class ControleurMenuPrincipal < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueDemarrage.new(@modele,"Demarage",self)
	end	

end