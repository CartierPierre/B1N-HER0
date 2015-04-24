class ControleurResultatPartie < Controleur

    @succes
    @score

    attr_reader :succes, :score

    def initialize(jeu, partie)
        super(jeu)
        @modele = partie

        @score = Score.creer(@modele.chrono.tempsFin.to_i, @modele.nbCoups, @modele.nbConseils, @modele.nbAides, @@utilisateur.id, @modele.niveau.id)
        @@utilisateur.statistique.mettreAJour()
        succesAvant = @@utilisateur.statistique.succes
        @gestionnaireScore.sauvegarderScore(@score)
        @@utilisateur.statistique.mettreAJour()
        succesApres = @@utilisateur.statistique.succes

        if(succesAvant)
            @succes = succesApres-succesAvant
        else
            @succes = succesApres
        end

        @vue = VueResultatPartie.new(@modele,self.getLangue[:resultatPartie],self)
    end 

    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end