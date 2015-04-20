class ControleurOptions < Controleur

    @partie

	def initialize(jeu, partie)
		super(jeu)
		@modele = @@utilisateur.option
        @partie = partie
		@vue = VueOptions.new(@modele,self.getLangue[:options],self)	
    end

    def appliquer()
        @gestionnaireUtilisateur.sauvegarderUtilisateur(@@utilisateur)
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

    def annuler()
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

    def setLangue(langue)
        @@utilisateur.option.setLangue(langue)
    end

    def getLangueConstante()
        return @@utilisateur.option.langue.getLangueConstante()
    end

end