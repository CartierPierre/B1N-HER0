class ControleurCredits < Controleur

    ##
    # Méthode de création du controleur qui gère la vue crédits
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
    def initialize(jeu)
        super(jeu)
        @modele = nil
        @vue = VueCredits.new(@modele,self.getLangue[:credits],self)
    end 

    ##
    # Retourne au menu principal
    #
    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end