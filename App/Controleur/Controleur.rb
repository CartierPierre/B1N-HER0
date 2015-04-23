class Controleur

    @jeu
    @vue
    @modele
    @gestionnaireUtilisateur
    @gestionnaireSauvegarde
    @gestionnaireScore
    @gestionnaireNiveau
    @@utilisateur = nil

    def initialize(jeu)
        @jeu = jeu
        @gestionnaireUtilisateur = GestionnaireUtilisateur.instance()
        @gestionnaireSauvegarde = GestionnaireSauvegarde.instance()
        @gestionnaireScore = GestionnaireScore.instance()
        @gestionnaireNiveau = GestionnaireNiveau.instance()
    end

    def getLangue
        if(@@utilisateur)
            return @@utilisateur.option.langue.langueActuelle
        end
        return Langue.new(Langue::FR).langueActuelle 
    end

    def changerControleur(controleur)
    	@jeu.controleur = controleur
    end

    def quitterJeu
    	Gtk.main_quit
    end
end