require_relative 'Controleur'

class ControleurPartie < Controleur

	def initialize(jeu,niveau,partie)
		super(jeu)
        if(partie)
            @modele = partie
        else
		    @modele = Partie.creer(nil,niveau)
        end
		@vue = VuePartie.new(@modele,"Jeu",self)
	end	

    def options()
        changerControleur(ControleurOptions.new(@jeu,@modele))
    end

    def quitter()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end