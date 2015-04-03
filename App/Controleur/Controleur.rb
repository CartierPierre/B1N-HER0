class Controleur

    @jeu
    @vue
    @modele
    @gestionnaireUtilisateur
    @utilisateur
    @@options

    def initialize(jeu)
        @jeu = jeu
        @gestionnaireUtilisateur =GestionnaireUtilisateur.instance()
        @@options = Option.creer()
    end

    def changerControleur(controleur)
    	@jeu.controleur = controleur
    end

    def options()
        return @@options
    end

    def quitterJeu
    	Gtk.main_quit
    end
end