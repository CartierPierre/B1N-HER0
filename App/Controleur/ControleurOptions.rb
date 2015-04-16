class ControleurOptions < Controleur

    @partie

	def initialize(jeu, partie)
		super(jeu)
		@modele = @@options
        @partie = partie
		@vue = VueOptions.new(@modele,self.getLangue[:options],self)	
    end

    def annuler()
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

    def setLangueFr()
        @@options.setLangueFr()
    end

    def setLangueEn()
        @@options.setLangueEn()
    end

end