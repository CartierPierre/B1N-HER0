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
            "tempsTotal" =>"%02d:%02d:%02d" % [(@@utilisateur.statistique.tempsTotal/3600),(@@utilisateur.statistique.tempsTotal%3600/60),(@@utilisateur.statistique.tempsTotal%60)],
            "nbGrillesReso" => @@utilisateur.statistique.nbGrillesReso,
            "nbPartiesParfaites" => @@utilisateur.statistique.partieParfaites,
            "succes" => @@utilisateur.statistique.succes.size.to_s
        }
    end

    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def annuler()
        changerControleur(ControleurProfil.new(@jeu))
    end

    def validerPasse(passe)
        if @@utilisateur.motDePasse == passe
            return false
        else
            @@utilisateur.motDePasse = passe
            @gestionnaireUtilisateur.sauvegarderUtilisateur(@@utilisateur)
            return true
        end
    end

    def validerPseudo(pseudo)
        listePseudo = Array.new
        @gestionnaireUtilisateur.recupererListeUtilisateur(0,@gestionnaireUtilisateur.recupererNombreUtilisateur).each do |x|
            listePseudo << x.nom
        end
        if listePseudo.include?(pseudo)
            return false
        else
            @@utilisateur.nom = pseudo
            @gestionnaireUtilisateur.sauvegarderUtilisateur(@@utilisateur)
            return true
        end
    end

    def actualiser
        @vue.fermerCadre
        changerControleur(ControleurProfil.new(@jeu))
    end

    def reset
        @@utilisateur.statistique = Statistique.creer(@@utilisateur)
        actualiser
    end

    def supprimerUtilisateur
        @vue.fermerCadre
        @gestionnaireSauvegarde.supprimerSauvegardeUtilisateur(@@utilisateur)
        @gestionnaireUtilisateur.supprimerUtilisateur(@@utilisateur)
        changerControleur(ControleurDemarrage.new(@jeu))
    end
end