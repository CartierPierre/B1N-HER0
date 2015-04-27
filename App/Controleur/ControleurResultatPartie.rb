class ControleurResultatPartie < Controleur

    ### Attributs d'instances

    @succes
    @score

    attr_reader :succes, :score

    ##
    # Méthode de création du controleur qui gère le résultat de la partie (après la validation de la grille)
    #
    # Paramètres::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #   * _partie_ - Partie qui vient de se terminer
    #
    def initialize(jeu, partie)
        super(jeu)
        @modele = partie

        @gestionnaireSauvegarde.supprimerSauvegardeUtilisateurNiveau(@@utilisateur,partie.niveau.id)

        # Création du score puis enregistrement dans la base de données et récupèration des succès déverrouillés grâce à cette partie
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

    ##
    # Retourne au menu principal
    #
    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end