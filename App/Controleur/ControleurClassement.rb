class ControleurClassement < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueClassement.new(@modele,self.getLangue[:profil],self)
	end


    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end