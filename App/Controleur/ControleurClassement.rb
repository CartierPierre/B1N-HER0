class ControleurClassement < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueClassement.new(@modele,"Profil",self)
	end


    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end