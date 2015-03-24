require_relative './Controleur'
require_relative './ControleurDemarrage'
require_relative './ControleurMenuPrincipal'
require_relative '../Vue/VueInscription'

class ControleurInscription < Controleur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueInscription.new(@modele,"Inscription",self)
	end


    def valider()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end


end