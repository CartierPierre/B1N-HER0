class Controleur

    @jeu
    @vue
    @modele
    @gestionnaireUtilisateur
    @utilisateur
    @options

    public_class_method :new

    def initialize(jeu)
        @jeu = jeu
        @gestionnaireUtilisateur =GestionnaireUtilisateur.instance()
        @options = Option.creer()
    end

    def changerControleur(controleur)

        @vue.fermerFenetre
    	#@modele.fermerBdd
    	@jeu.controleur = controleur
    end

    def quitterJeu

    	Gtk.main_quit
    end
end