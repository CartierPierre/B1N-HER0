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
    # Méthode de création du controleur
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
    	Gtk.main_quit
    end
end