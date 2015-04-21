class ControleurChargerPartie < Controleur

    @partie

    def initialize(jeu, partie)
        super(jeu)
        @modele = nil
        @partie = partie
        @vue = VueChargerPartie.new(@modele,self.getLangue[:chargerPartie],self)
    end 

    def charger(niveau)
        changerControleur(ControleurPartie.new(@jeu,niveau,nil))
    end

    def annuler()
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

end