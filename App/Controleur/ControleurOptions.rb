class ControleurOptions < Controleur

    ### Attribut d'instance

    @partie

    ##
    # Méthode de création du controleur qui gère la vue crédits
    #
    # Paramètres::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #   * _partie_ - Partie chargée si la vue précédente est la vue partie
    #
	def initialize(jeu, partie)
		super(jeu)
		@modele = @@utilisateur.option
        @partie = partie
		@vue = VueOptions.new(@modele,self.getLangue[:options],self)	
    end

    ##
    # Applique les options sélectionnées dans la base de données
    # Puis retour au menu principal ou en partie selon la vue précédente
    #
    def appliquer()
        @gestionnaireUtilisateur.sauvegarderUtilisateur(@@utilisateur)
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

    ##
    # Retour au menu principal ou en partie selon la vue précédente
    #
    def annuler()
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

    ##
    # Méthode qui permet d'affecter une nouvelle langue
    #
    # Paramètre::
    #   * _langue_ - Constante de la classe Langue 
    #
    def setLangue(langue)
        @@utilisateur.option.setLangue(langue)
    end

    ##
    # Retour::
    #   Constante de langue actuellement active dans les options de l'utilisateur
    #
    def getLangueConstante()
        return @@utilisateur.option.langue.getLangueConstante()
    end

end