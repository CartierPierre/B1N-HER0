require_relative 'Controleur'

class ControleurPartie < Controleur

	def initialize(jeu, niveau, partie)
		super(jeu)
        if(partie == nil)
    		@modele = Partie.creer(nil,niveau)
        else
            @modele = partie 
        end
        titre = self.getLangue[:niveau] + " " + @modele.niveau.difficulte.to_s + " - " + @modele.grille.taille.to_i.to_s + "x" + @modele.grille.taille.to_i.to_s
		@vue = VuePartie.new(@modele,titre,self)
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
        return getCouleurTuile(@@options.couleurTuile1)
    end

    def getCouleurTuile2
        return getCouleurTuile(@@options.couleurTuile2)
    end

    def getModeHypotheseActif
        return @modele.modeHypothese
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