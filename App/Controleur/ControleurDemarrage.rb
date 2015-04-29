class ControleurDemarrage < Controleur

    ##
    # Méthode de création du controleur qui est responsable de la vue du menu de démarrage
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueDemarrage.new(@modele,self.getLangue[:demarrage],self)
	end

    ##
    # Change de controleur pour aller dans la vue connexion
    #
    def connexion()
        changerControleur(ControleurConnexion.new(@jeu))
    end

    ##
    # Change de controleur pour aller dans la vue inscription
    #
    def inscription()
        changerControleur(ControleurInscription.new(@jeu,""))
    end

end