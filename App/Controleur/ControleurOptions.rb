class ControleurOptions < Controleur

    @controleurPrecedent

	def initialize(jeu,controleurPrecedent)
		super(jeu)
        @controleurPrecedent = controleurPrecedent
		@modele = @@options
		@vue = VueOptions.new(@modele,"Options",self)
	end

    def annuler()
        if(@controleurPrecedent.instance_of?(ControleurMenuPrincipal))
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        end
    end

    def setLangueFr()
        @@options.setLangueFr()
    end

    def setLangueEn()
        @@options.setLangueEn()
    end

end