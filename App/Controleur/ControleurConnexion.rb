class ControleurConnexion < Controleur

    ##
    # Méthode de création du controleur qui est responsable de la vue du menu de connexion
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,self.getLangue[:connexion],self)
	end

    ##
    # Verifie le pseudo et le mot de passe en allant chercher dans la base de données
    #
    # Paramètre::
    #   * _passe_ - Le mot de passe à vérifier
    #   * _pseudo_ - Le pseudo à vérifier
    #
    def valider(pseudo,passe)                            #:notnew:
		validation = Stockage.instance().authentification( pseudo, passe )
        @@utilisateur = validation[1]
        case validation[0]
        when 0..1
            validerPasse(passe)
		when 2
			validerPasse(passe)
			Stockage.instance().syncroniser( @@utilisateur, true )
        when 3
			@vue.pasInternet("Online")
        when 4
            validerPasse(passe)
			Stockage.instance().syncroniser( @@utilisateur, true )
        when 5
            @vue.pasInternet("Offline")
            @vue.utilisateurInexistant()
        when 6
            @vue.utilisateurInexistant()
        end
    end

    ##
    # Verifie le mot de passe en le comparant à celui de l'utilisateur actuel
    #
    # Paramètre::
    #   * _passe_ - Le mot de passe à vérifier
    #
    def validerPasse(passe)
        if @@utilisateur.motDePasse == passe
            @vue.fermerCadre
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            @vue.mauvaisPasse
        end
    end

    ##
    # Change de controleur pour aller dans la vue Demarrage
    #
    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end

    ##
    # Change de controleur pour aller dans la vue inscription
    #
    # Paramètre::
    #   * _pseudo_ - Le pseudo à entrer dans le formulaire d'inscription
    #
    def oui(pseudo)
        changerControleur(ControleurInscription.new(@jeu,pseudo))
    end

    ##
    # Change de controleur pour actualiser la vue nouvelle partie
    #
    def non()
        changerControleur(ControleurConnexion.new(@jeu))
    end
end