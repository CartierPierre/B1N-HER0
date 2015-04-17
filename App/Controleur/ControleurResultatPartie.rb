class ControleurResultatPartie < Controleur

    def initialize(jeu, partie)
        super(jeu)
        @modele = partie
        @vue = VueResultatPartie.new(@modele,self.getLangue[:resultatPartie],self)
    end 

    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end