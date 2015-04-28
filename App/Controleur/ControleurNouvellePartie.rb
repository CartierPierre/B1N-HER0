class ControleurNouvellePartie < Controleur

    ##
    # Méthode de création du controleur qui est responsable de la vue nouvelle partie
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueNouvellePartie.new(@modele,self.getLangue[:nouvellePartie],self)
	end	

    ##
    # Méthode qui permet récupèrer un niveau dans la base de données 
    # en fonction de la taille de la grille et de la difficulté passées en paramètre
    # Puis lance cette partie
    #
    # Paramètres::
    #   * _taille_ - Taille de la grille
    #   * _difficulte_ - Difficulté du niveau
    #
    def jouer(taille,difficulte)
        niveau = GestionnaireNiveau.instance.recupererNiveauAleaSelonDimDiff(taille, difficulte)
        changerControleur(ControleurPartie.new(@jeu,niveau,nil))
    end

    ##
    # Retourne au menu principal
    #
    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end