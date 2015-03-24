class ControleurMenuPrincipal < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueMenuPrincipal.new(@modele,"Menu principal",self)
	end	

    def jouer()
        changerControleur(ControleurNouvellePartie.new(@jeu))
    end

end