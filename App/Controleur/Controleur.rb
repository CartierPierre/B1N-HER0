require_relative '../Modele/Option'

class Controleur

    @jeu
    @vue
    @modele
    @gestionnaireUtilisateur
    @@utilisateur
    @@options = Option.creer(Option::TUILE_ROUGE,Option::TUILE_BLEUE,Langue::FR) 

    def initialize(jeu)
        @jeu = jeu
        @gestionnaireUtilisateur = GestionnaireUtilisateur.instance()
    end

    def getLangue
        return @@options.langue.langueActuelle
    end

    def getImgTuile1
        return @@options.imgTuile1
    end

    def getImgTuile2
        return @@options.imgTuile2
    end

    def getImgTuileLock1
        return @@options.imgTuileLock1
    end

    def getImgTuileLock2
        return @@options.imgTuileLock2
    end

    def changerControleur(controleur)
    	@jeu.controleur = controleur
    end

    def quitterJeu
    	Gtk.main_quit
    end
end