require_relative 'Controleur'

class ControleurPartie < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = Grille.creer(6)
		@vue = VuePartie.new(@modele,"Jeu",self)
	end	

end