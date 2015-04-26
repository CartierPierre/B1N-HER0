class ControleurChargerPartie < Controleur

    ### Attribut d'instance

    @partie

    ##
    # Méthode de création du controleur qui est responsable du chargement d'une partie
    #
    # Paramètres::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #   * _partie_ - Partie chargée si la vue précédente est la vue partie
    #
    def initialize(jeu, partie)
        super(jeu)
        @modele = nil
        @partie = partie
        @vue = VueChargerPartie.new(@modele,self.getLangue[:chargerPartie],self)
    end 

    ##
    # Méthode qui permet de lancer la partie passée en paramètre
    #
    # Paramètre::
    #   * _partie_ - Partie à charger
    #
    def charger(partie)
        changerControleur(ControleurPartie.new(@jeu,nil,partie))
    end

    ##
    # Méthode qui permet de récupèrer les sauvegardes d'une certaine taille de grille de l'utilisateur connecté
    #
    # Paramètre::
    #   * _taille_ - Taille de la grille
    #
    # Retour::
    #   Tableau contenant les parties sauvegardées ainsi que la description associée
    #
    def getParties(taille)
        parties = Array.new()
        sauvegardes = @gestionnaireSauvegarde.recupererSauvegardeUtilisateurDimention(@@utilisateur, 0, 50, taille)

        sauvegardes.each do |sauvegarde|
            niveau = @gestionnaireNiveau.recupererNiveau(sauvegarde.idNiveau)
            partie = Array[sauvegarde.description, Partie.charger(@@utilisateur, niveau, sauvegarde)]
            parties.push(partie)
        end

        return parties
    end

    ##
    # Retourne au menu principal ou alors en partie selon la vue précédente
    #
    def annuler()
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

end