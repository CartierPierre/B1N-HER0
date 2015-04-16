class ControleurNouvellePartie < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueNouvellePartie.new(@modele,self.getLangue[:nouvellePartie],self)
	end	

    def jouer(taille,difficulte)
        niveau = GestionnaireNiveau.instance.recupererNiveauAleaSelonDimDiff(taille, difficulte)
        changerControleur(ControleurPartie.new(@jeu,niveau,nil))
    end

    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end