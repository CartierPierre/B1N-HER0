class ControleurNouvellePartie < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueNouvellePartie.new(@modele,"NouvellePartie",self)
	end	

    def jouer
        changerControleur(ControleurPartie.new(@jeu))
    end

    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end