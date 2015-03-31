class ControleurOptions < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = @options
		@vue = VueOptions.new(@modele,"Options",self)
	end

    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def setLangueFr()
        @options.setLangueFr()
    end

    def setLangueEn()
        @options.setLangueEn()
    end

end