require_relative 'Controleur'

class ControleurPartie < Controleur

	def initialize(jeu, niveau, partie)
		super(jeu)
        if(partie == nil)
    		@modele = Partie.creer(@@utilisateur,niveau)
        else
            @modele = partie 
        end
        titre = self.getLangue[:niveau] + " " + @modele.niveau.difficulte.to_s + " - " + @modele.grille.taille.to_i.to_s + "x" + @modele.grille.taille.to_i.to_s
		@vue = VuePartie.new(@modele,titre,self)
	end	

    def getImgTuile1
        return @@utilisateur.option.imgTuile1
    end

    def getImgTuile2
        return @@utilisateur.option.imgTuile2
    end

    def getImgTuileLock1
        return @@utilisateur.option.imgTuileLock1
    end

    def getImgTuileLock2
        return @@utilisateur.option.imgTuileLock2
    end

    def getCouleurTuile(couleur)
        if(couleur == Option::TUILE_ROUGE)
            return "red"
        elsif(couleur == Option::TUILE_BLEUE)
            return "blue"
        elsif(couleur == Option::TUILE_VERTE)   
            return "green"
        elsif(couleur == Option::TUILE_JAUNE)
            return "GoldenRod"
        end
    end
    private :getCouleurTuile

    def getCouleurTuile1
        return getCouleurTuile(@@utilisateur.option.couleurTuile1)
    end

    def getCouleurTuile2
        return getCouleurTuile(@@utilisateur.option.couleurTuile2)
    end

    def getModeHypotheseActif
        return @modele.modeHypothese
    end

    def getNombreSauvegardes()
        return @gestionnaireSauvegarde.recupererNombreSauvegardeUtilisateur(@@utilisateur)
    end

    def sauvegarder(description)  
        sauvegarde = Sauvegarde.creer(description,@modele)      
        @gestionnaireSauvegarde.sauvegarderSauvegarde(sauvegarde)
    end

    def charger()
        changerControleur(ControleurChargerPartie.new(@jeu,@modele))
    end

    def options()
        changerControleur(ControleurOptions.new(@jeu,@modele))
    end

    def quitter()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def validerGrille()
        changerControleur(ControleurResultatPartie.new(@jeu,@modele))
    end

end