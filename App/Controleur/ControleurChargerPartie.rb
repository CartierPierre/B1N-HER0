class ControleurChargerPartie < Controleur

    def initialize(jeu)
        super(jeu)
        @modele = nil
        @vue = VueChargerPartie.new(@modele,self.getLangue[:chargerPartie],self)
    end 

    def jouer(niveau)
        changerControleur(ControleurPartie.new(@jeu,niveau,nil))
    end

    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end