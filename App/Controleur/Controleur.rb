require_relative '../Modele/Option'

class Controleur

    @jeu
    @vue
    @modele
    @gestionnaireUtilisateur
    @utilisateur
    @@options = Option.creer()

    def initialize(jeu)
        @jeu = jeu
        @gestionnaireUtilisateur = GestionnaireUtilisateur.instance()
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