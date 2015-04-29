class ControleurClassement < Controleur

    ##
    # Méthode de création du controleur qui est responsable de la vue du classement
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
	def initialize(jeu)             #:notnew:
		super(jeu)
		@modele = nil
		@vue = VueClassement.new(@modele,self.getLangue[:classement],self)
	end

    ##
    # Méthode de changement de controleur vers la vue menu principal
    #
    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    ##
    # Méthode de récupération des scores à partir de la base de données
    #
    # Retour::
    #   Les Score sous forme de tableau

    def listeDesScores
        score = Array.new

        listeScores = @gestionnaireScore.recupererListeScore(0,@gestionnaireScore.recupererNombreScore())

        listeScores.each do |x|
            score << {"points" =>     x.nbPoints(@gestionnaireNiveau.recupererNiveau(x.idNiveau)),
                      "pseudo" =>     @gestionnaireUtilisateur.recupererUtilisateur(x.idUtilisateur).nom,
                      "taille" =>     @gestionnaireNiveau.recupererNiveau(x.idNiveau).dimention,
                      "difficulte" => @gestionnaireNiveau.recupererNiveau(x.idNiveau).difficulte}
        end
        return score
    end
end