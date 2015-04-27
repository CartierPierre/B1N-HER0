class ControleurConnexion < Controleur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,self.getLangue[:connexion],self)
	end


    def valider(pseudo,passe)
        if (@@utilisateur = @gestionnaireUtilisateur.connexionUtilisateur(pseudo,passe)) == nil
            if connexion > -1
                @vue.utilisateurInexistant()
            else
                @vue.pasInternet("offline")
            end
        else
            if connexion > -1
                if @@utilisateur.motDePasse == passe
                    @vue.fermerCadre
                    changerControleur(ControleurMenuPrincipal.new(@jeu))
                else
                    @vue.mauvaisPasse
                end
            else
                if @@utilisateur.type == Utilisateur::ONLINE
                    @vue.pasInternet("online")
                else
                    if @@utilisateur.motDePasse == passe
                        @vue.fermerCadre
                        changerControleur(ControleurMenuPrincipal.new(@jeu))
                    else
                        @vue.mauvaisPasse
                    end
                end
            end
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