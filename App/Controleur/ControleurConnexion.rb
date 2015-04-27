class ControleurConnexion < Controleur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,self.getLangue[:connexion],self)
	end


    def valider(pseudo,passe)
        if (@@utilisateur = @gestionnaireUtilisateur.connexionUtilisateur(pseudo,passe)) == nil
            if testConnexion
                @vue.utilisateurInexistant()
            else
                @vue.pasInternet("offline")
            end
        else
            if testConnexion
                if @@utilisateur.motDePasse == passe
                    changerControleur(ControleurMenuPrincipal.new(@jeu))
                else
                    @vue.mauvaisPasse
                end
            else
                if @@utilisateur.type == Utilisateur::ONLINE
                    @vue.pasInternet("online")
                end
            end
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