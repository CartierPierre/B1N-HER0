class ControleurProfil < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueProfil.new(@modele,self.getLangue[:profil],self)
	end


    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end