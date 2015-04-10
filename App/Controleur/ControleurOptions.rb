class ControleurOptions < Controleur

    @partie

	def initialize(jeu,partie)
		super(jeu)
        @partie = partie
		@modele = @@options
		@vue = VueOptions.new(@modele,"Options",self)
	end

    def retour()
        changerControleur(ControleurPartie.new(@jeu,nil,@partie))
    end

    def setLangueFr()
        @@options.setLangueFr()
    end

    def setLangueEn()
        @@options.setLangueEn()
    end

end