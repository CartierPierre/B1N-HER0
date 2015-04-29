class ControleurProfil < Controleur

    ##
    # Méthode de création du controleur qui est responsable de la vue du menu profil
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
	def initialize(jeu)       #:notnew:
		super(jeu)
		@modele = nil
		@vue = VueProfil.new(@modele,self.getLangue[:profil],self)
	end

    ##
    # Méthode de récupération des statistiques de l'utilisateur courant
    #
    #
    #
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
            "succes" => @@utilisateur.statistique.succes.size.to_s,
            "statut" => @@utilisateur.type
        }
    end

    ##
    # Change de controleur pour aller dans la vue menu principal
    #
    def retour()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    ##
    # Change de controleur pour actualiser la vue profil
    #
    def annuler()
        changerControleur(ControleurProfil.new(@jeu))
    end

    ##
    # Méthode de vérification du mot de passe lors du changement de mot de passe
    #
    # Paramètre::
    #   * _passe_ - Le nouveau mot de passe à vérifier
    #
    def validerPasse(passe)
        if @@utilisateur.motDePasse == passe
            return false
        else
            @@utilisateur.motDePasse = passe
            @gestionnaireUtilisateur.sauvegarderUtilisateur(@@utilisateur)
            return true
        end
    end

    ##
    # Méthode de vérification du pseudo lors du changement de pseudo
    #
    # Paramètre::
    #   * _pseudo_ - Le nouveau pseudo à vérifier
    #
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

    ##
    # Méthode d'actualisation de la Vue Profil
    #
    def actualiser
        @vue.fermerCadre
        changerControleur(ControleurProfil.new(@jeu))
    end

    ##
    # Méthode de remise à zéro de l'Utilisateur
    #
    def reset
        Stockage.instance().miseAZeroUtilisateur( @@utilisateur )
        actualiser
    end

    ##
    # Méthode de suppression à zéro de l'Utilisateur
    #
    def supprimerUtilisateur
        @vue.fermerCadre
        @gestionnaireSauvegarde.supprimerSauvegardeUtilisateur(@@utilisateur)
        @gestionnaireUtilisateur.supprimerUtilisateur(@@utilisateur)
        changerControleur(ControleurDemarrage.new(@jeu))
    end

    ##
    # Méthode pour changer le mode de Jeu de l'Utilisateur
    #
    def changerType
        Stockage.instance().changerTypeUtilisateur( @@utilisateur )
    end

    ##
    # Méthode pour fusionner deux compte Utilisateur
    #
    def fusion(pseudo,passe,compte)
        Stockage.instance().fusionUtilisateurs( @@utilisateur, pseudo, passe, compte )
    end
end