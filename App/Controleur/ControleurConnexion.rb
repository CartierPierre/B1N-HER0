class ControleurConnexion < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,self.getLangue[:connexion],self)
	end


    def valider(pseudo,passe)
		validation = Stockage.instance().authentification( pseudo, passe )
        @@utilisateur = validation[1]
        case validation[0]
        when 0..2
            validerPasse(passe)
        when 3
            @vue.pasInternet("Offline")
        when 4
            validerPasse(passe)
        when 5
            @vue.pasInternet("Online")
            @vue.utilisateurInexistant()
        when 6
            @vue.utilisateurInexistant()
        end
    end

    def validerPasse(passe)
        if @@utilisateur.motDePasse == passe
            @vue.fermerCadre
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            @vue.mauvaisPasse
        end
    end

    def annuler()
        @vue.fermerCadre
        changerControleur(ControleurDemarrage.new(@jeu))
    end

    def oui(pseudo)
        changerControleur(ControleurInscription.new(@jeu,pseudo))
    end

    def non()
        changerControleur(ControleurConnexion.new(@jeu))
    end
end