class ControleurRegles < Controleur

    ##
    # Méthode de création du controleur qui gère la vue règles
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
    def initialize(jeu)
        super(jeu)
        @modele = nil
        @vue = VueRegles.new(@modele,self.getLangue[:regles],self)
    end 

    ##
    # Retourne au menu principal
    #
    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end