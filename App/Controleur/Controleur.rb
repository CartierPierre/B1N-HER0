class Controleur

    @jeu
    @vue
    @modele

    public_class_method :new

    def initialize(jeu)
        @jeu = jeu
    end

    def changerControleur(controleur)

    	#@vue.fermerFenetre
    	#@modele.fermerBdd
    	@jeu.controleur = controleur
    end

    def quitterJeu

    	#@modele.sauvegarderProfil if !@modele.profil.nil?
    	Gtk.main_quit
    end
end