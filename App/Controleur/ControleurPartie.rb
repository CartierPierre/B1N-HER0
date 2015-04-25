class ControleurPartie < Controleur

    ##
    # Méthode de création du controleur qui gère la partie
    #
    # Paramètres::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #   * _niveau_ - Niveau en cas de création d'une nouvelle partie
    #   * _partie_ - Partie si déjà créée lorsqu'on accède aux options ou chargement d'une sauvegarde en partie puis on fait retour
    #
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

    ##
    # Retour::
    #   Image de la tuile à l'état 1 par rapport aux options de l'utilisateur sous le format Gdk Pixbuf
    #
    def getImgTuile1
        return @@utilisateur.option.imgTuile1
    end

    ##
    # Retour::
    #   Image de la tuile à l'état 2 par rapport aux options de l'utilisateur sous le format Gdk Pixbuf
    #
    def getImgTuile2
        return @@utilisateur.option.imgTuile2
    end

    ##
    # Retour::
    #   Image de la tuile à l'état vérouillé 1 par rapport aux options de l'utilisateur sous le format Gdk Pixbuf
    #
    def getImgTuileLock1
        return @@utilisateur.option.imgTuileLock1
    end

    ##
    # Retour::
    #   Image de la tuile à l'état vérouillé 2 par rapport aux options de l'utilisateur sous le format Gdk Pixbuf
    #
    def getImgTuileLock2
        return @@utilisateur.option.imgTuileLock2
    end

    ##
    # Méthode qui est utiliser pour les couleurs des labels qui indiquent le nombre de tuiles à l'état 1/2 par ligne/colonne 
    #
    # Paramètre::
    #   * _couleur_ - Constante de couleur de la classe Option
    #
    # Retour::
    #   Couleur HTML en fonction de la constante de couleur de la classe Option passée en paramètre
    #
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

    ##
    # Retour::
    #   Couleur HTML par rapport à la couleur de la tuile à l'état 1 dans les options de l'utilisateur
    #
    def getCouleurTuile1
        return getCouleurTuile(@@utilisateur.option.couleurTuile1)
    end

    ##
    # Retour::
    #   Couleur HTML par rapport à la couleur de la tuile à l'état 2 dans les options de l'utilisateur
    #
    def getCouleurTuile2
        return getCouleurTuile(@@utilisateur.option.couleurTuile2)
    end

    ##
    # Méthode utilisée dans la classe TuileGtk afin de mettre les images des nouveaux coups moins opaques
    # en mode hypothèse
    #
    # Retour::
    #   Booléen indiquant si le mode hypothèse est activé ou non
    #
    def getModeHypotheseActif
        return @modele.modeHypothese
    end

    ##
    # Retour::
    #   Nombre de sauvegardes qye possède l'utilisateur connecté
    #
    def getNombreSauvegardes()
        return @gestionnaireSauvegarde.recupererNombreSauvegardeUtilisateur(@@utilisateur)
    end

    ##
    # Méthode qui permet de sauvegarder la partie courante dans la base de données
    #
    # Paramètre::
    #   * _description_ - Description de la sauvegarde
    #
    def sauvegarder(description)  
        sauvegarde = Sauvegarde.creer(description,@modele)      
        @gestionnaireSauvegarde.sauvegarderSauvegarde(sauvegarde)
    end

    ##
    # Change de controleur pour aller dans la vue charger partie
    #
    def charger()
        changerControleur(ControleurChargerPartie.new(@jeu,@modele))
    end

    ##
    # Change de controleur pour aller dans la vue options
    #
    def options()
        changerControleur(ControleurOptions.new(@jeu,@modele))
    end

    ##
    # Retourne au menu principal
    #
    def quitter()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    ##
    # Change de controleur pour aller dans la vue résultat partie en cas de grille valide
    #
    def validerGrille()
        changerControleur(ControleurResultatPartie.new(@jeu,@modele))
    end

end