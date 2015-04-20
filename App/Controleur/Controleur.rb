class Controleur

    @jeu
    @vue
    @modele
    @gestionnaireUtilisateur
    @@utilisateur = nil

    def initialize(jeu)
        @jeu = jeu
        @gestionnaireUtilisateur = GestionnaireUtilisateur.instance()
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