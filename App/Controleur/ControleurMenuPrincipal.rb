class ControleurMenuPrincipal < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueMenuPrincipal.new(@modele,self.getLangue[:menuPrincipal],self)
	end	

    def nouvellePartie()
        changerControleur(ControleurNouvellePartie.new(@jeu))
    end

    def chargerPartie()
        changerControleur(ControleurChargerPartie.new(@jeu))
    end

    def profil()
    	changerControleur(ControleurProfil.new(@jeu))
    end

    def classement()
    	changerControleur(ControleurClassement.new(@jeu))
    end

    def options()
    	changerControleur(ControleurOptions.new(@jeu,nil))
    end

    def credits()
        changerControleur(ControleurCredits.new(@jeu))
    end

end