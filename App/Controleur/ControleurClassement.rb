class ControleurClassement < Controleur


	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueClassement.new(@modele,self.getLangue[:classement],self)
	end


    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def listeDesScores
        score = Array.new

        listeScores = @gestionnaireScore.recupererListeScore(0,@gestionnaireScore.recupererNombreScore())

        listeScores.each do |x|
            score << {"points" =>     x.nbPoints(@gestionnaireNiveau.recupererNiveau(x.idNiveau)),
                      "pseudo" =>     @gestionnaireUtilisateur.recupererUtilisateur(x.idUtilisateur).nom,
                      "taille" =>     @gestionnaireNiveau.recupererNiveau(x.idNiveau).dimention,
                      "difficulte" => @gestionnaireNiveau.recupererNiveau(x.idNiveau).difficulte}
        end

        @gestionnaireScore
        @gestionnaireNiveau
        @gestionnaireUtilisateur
        return score
    end
end