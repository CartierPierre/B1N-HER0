class ControleurCredits < Controleur

    def initialize(jeu)
        super(jeu)
        @modele = nil
        @vue = VueCredits.new(@modele,self.getLangue[:credits],self)
    end 

    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end