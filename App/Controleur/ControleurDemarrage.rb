require_relative './Controleur'
require_relative '../Vue/VueDemarrage'
class ControleurDemarrage < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueDemarrage.new(@modele,"Demarrage",self)
	end	

end