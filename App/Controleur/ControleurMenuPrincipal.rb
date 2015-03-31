class ControleurMenuPrincipal < Controleur

	def initialize(jeu,utilisateur)
		super(jeu)
		@modele = nil
		@vue = VueMenuPrincipal.new(@modele,"Menu principal",self)
        @utilisateur
	end	

    def jouer()
        changerControleur(ControleurNouvellePartie.new(@jeu))
    end

    def options()
    	changerControleur(ControleurOptions.new(@jeu))
    end

end