class ControleurConnexion < Controleur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,self.getLangue[:connexion],self)
	end


    def valider(pseudo,passe)
        if (@@utilisateur = @gestionnaireUtilisateur.connexionUtilisateur(pseudo,passe)) == nil
            @vue.utilisateurInexistant()
        elsif
            @@utilisateur.motDePasse == passe
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            @vue.mauvaisPasse
        end
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end

    def oui(pseudo)
        changerControleur(ControleurInscription.new(@jeu,pseudo))
    end

    def non()
        changerControleur(ControleurConnexion.new(@jeu))
    end
end