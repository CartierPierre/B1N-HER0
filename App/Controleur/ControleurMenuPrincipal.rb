class ControleurMenuPrincipal < Controleur

    ##
    # Méthode de création du controleur qui est responsable de la vue du menu principal
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueMenuPrincipal.new(@modele,self.getLangue[:menuPrincipal],self)
	end	

    ##
    # Change de controleur pour aller dans la vue nouvelle partie
    #
    def nouvellePartie()
        changerControleur(ControleurNouvellePartie.new(@jeu))
    end

    ##
    # Change de controleur pour aller dans la vue charger partie
    #
    def chargerPartie()
        changerControleur(ControleurChargerPartie.new(@jeu,nil))
    end

    ##
    # Change de controleur pour aller dans la vue classement
    #
    def classement()
        changerControleur(ControleurClassement.new(@jeu))
    end

    ##
    # Change de controleur pour aller dans la vue options
    #
    def options()
        changerControleur(ControleurOptions.new(@jeu,nil))
    end

    ##
    # Change de controleur pour aller dans la vue profil
    #
    def profil()
    	changerControleur(ControleurProfil.new(@jeu))
    end

    ##
    # Change de controleur pour aller dans la vue crédits
    #
    def credits()
        changerControleur(ControleurCredits.new(@jeu))
    end

    ##
    # Méthode qui permet de reprendre la dernière partie sauvegardée
    #
    def reprendrePartie()
        offset = @gestionnaireSauvegarde.recupererNombreSauvegardeUtilisateur(@@utilisateur)
        sauvegarde = @gestionnaireSauvegarde.recupererSauvegardeUtilisateur(@@utilisateur, offset-1, 1)
        niveau = @gestionnaireNiveau.recupererNiveau(sauvegarde[0].idNiveau)
        partie = Partie.charger(@@utilisateur, niveau, sauvegarde[0])
        changerControleur(ControleurPartie.new(@jeu,nil,partie))
    end

end