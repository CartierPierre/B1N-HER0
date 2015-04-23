class ControleurChargerPartie < Controleur

    @partie

    def initialize(jeu, partie)
        super(jeu)
        @modele = nil
        @partie = partie
        @vue = VueChargerPartie.new(@modele,self.getLangue[:chargerPartie],self)
    end 

    def charger(partie)
        changerControleur(ControleurPartie.new(@jeu,nil,partie))
    end

    def getParties()
        parties = Array.new()
        sauvegardes = @gestionnaireSauvegarde.recupererSauvegardeUtilisateur(@@utilisateur, 0, 10)

        sauvegardes.each do |sauvegarde|
            niveau = @gestionnaireNiveau.recupererNiveau(sauvegarde.idNiveau)
            partie = Partie.charger(@@utilisateur, niveau, sauvegarde)
            parties.push(partie)
        end

        return parties
    end

    def annuler()
        if(@partie == nil)
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            changerControleur(ControleurPartie.new(@jeu,nil,@partie))
        end
    end

end