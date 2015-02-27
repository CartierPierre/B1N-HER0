require_relative 'Controleur'

class ControleurDemarrage < Controleur

	def initialize(jeu)
		super(jeu)
		@jeu.show_all
	end	


end