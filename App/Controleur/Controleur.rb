class Controleur

    ### Attributs d'instances

    @jeu
    @vue
    @modele
    @gestionnaireUtilisateur
    @gestionnaireSauvegarde
    @gestionnaireScore
    @gestionnaireNiveau

    ### Attribut de classe

    @@utilisateur = nil

    ##
    # Méthode de création du controleur qui récupère les instances des gestionnaires pour les interactions avec la base de données
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
    def initialize(jeu)
        @jeu = jeu
        @gestionnaireUtilisateur = GestionnaireUtilisateur.instance()
        @gestionnaireSauvegarde = GestionnaireSauvegarde.instance()
        @gestionnaireScore = GestionnaireScore.instance()
        @gestionnaireNiveau = GestionnaireNiveau.instance()
    end

    ##
    # Retourne la langue de l'utilisateur si connecté ou alors la langue française par défaut
    #
    # Retour::
    #   Langue actuelle correspondant à l'ensemble des textes pour les labels.
    #
    def getLangue
        if(@@utilisateur)
            return @@utilisateur.option.langue.langueActuelle
        end
        return Langue.new(Langue::FR).langueActuelle 
    end

    ##
    # Méthode qui permet de changer de controleur
    #
    # Paramètre::
    #   * _controleur_ - Nouveau controleur à affecter
    #
    def changerControleur(controleur)
    	@jeu.controleur = controleur
    end

    ##
    # Méthode qui permet de quitter le jeu et fermer l'application
    #
    def quitterJeu
		puts "exit"
		if( @@utilisateur != nil && @@utilisateur.type == Utilisateur::ONLINE )
			Stockage.instance().syncroniser( @@utilisateur, false )
		end
		@@utilisateur = nil
    	Gtk.main_quit
		# abort
    end
    
    ##
    # Méthode qui permet de sauvegarder automatiquement la partie courante lorsque la fenetre se ferme en partie
    # ou qu'on quitte la partie pour retourner au menu principal
    #
    def sauvegardeAutomatique()
        nbSauvegardesAuto = @gestionnaireSauvegarde.recupererNombreSauvegardeAutomatiqueUtilisateur(@@utilisateur)
        sauvegarde = Sauvegarde.creer("Sauvegarde automatique " + (nbSauvegardesAuto+1).to_s,@modele)      
        @gestionnaireSauvegarde.sauvegarderSauvegarde(sauvegarde)
    end

    ##
    # Retour::
    #   Nombre de sauvegardes qye possède l'utilisateur connecté
    #
    def getNombreSauvegardes()
        return @gestionnaireSauvegarde.recupererNombreSauvegardeUtilisateur(@@utilisateur)
    end

    def testConnexion
        Serveur.instance.testConnexion
    end
end