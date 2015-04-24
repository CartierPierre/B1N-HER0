class ControleurProfil < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueProfil.new(@modele,self.getLangue[:profil],self)
	end

    def getStatistiques()
        @@utilisateur.statistique.mettreAJour
        return {
            "pseudo" => @@utilisateur.nom,
            "motDePasse" => @@utilisateur.motDePasse,
            "dateInscription" => Time.at(@@utilisateur.dateInscription).strftime(self.getLangue[:formatDate]),
            "nbCoups" => @@utilisateur.statistique.nbCoups.to_s,
            "nbConseils" => @@utilisateur.statistique.nbConseils.to_s,
            "nbAides" => @@utilisateur.statistique.nbAides.to_s,
            "tempsTotal" => Time.at(@@utilisateur.statistique.tempsTotal).strftime("%T"),
            "nbGrillesReso" => @@utilisateur.statistique.nbGrillesReso,
            "nbPartiesParfaites" => @@utilisateur.statistique.partieParfaites,
            "succes" => @@utilisateur.statistique.succes.size.to_s
        }
    end

    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

end