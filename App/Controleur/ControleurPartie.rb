require_relative 'Controleur'

class ControleurPartie < Controleur

	def initialize(jeu,niveau)
		super(jeu)
		@modele = Partie.creer(@@utilisateur,niveau)
		@vue = VuePartie.new(@modele,"Jeu",self)
	end	

    def options()
        changerControleur(ControleurOptions.new(@jeu,@modele))
    end

    def quitter()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end