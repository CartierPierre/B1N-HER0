require_relative 'Controleur'

class ControleurPartie < Controleur

	def initialize(jeu,niveau)
		super(jeu)
		@modele = Partie.creer(nil,niveau)
		@vue = VuePartie.new(@modele,"Jeu",self)
	end	

    def options()
        changerControleur(ControleurOptions.new(@jeu))
    end

    def quitter()
        changerControleur(ControleurMenuPrincipal.new(@jeu,@utilisateur))
    end

end