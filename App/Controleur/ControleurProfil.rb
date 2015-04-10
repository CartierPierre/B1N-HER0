class ControleurProfil < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueProfil.new(@modele,"Profil",self)
	end


    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end


end