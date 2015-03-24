require_relative 'Controleur'
require_relative '../Vue/VueNouvellePartie'

class ControleurNouvellePartie < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueNouvellePartie.new(@modele,"NouvellePartie",self)
	end	


    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end