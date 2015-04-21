class ControleurClassement < Controleur

    @gestionnaireScores

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueClassement.new(@modele,self.getLangue[:classement],self)
        @gestionnaireScores = GestionnaireScore.instance()
	end


    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def listeScores
        return  @gestionnaireScores.recupererListeScore(0, @gestionnaireScores.recupererNombreScore())
    end
end