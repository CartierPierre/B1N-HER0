class ControleurConnexion < Controleur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,self.getLangue[:connexion],self)
	end


    def valider(pseudo,passe)
        connexion = testConnexion

        if connexion == -1
            if (@@utilisateur = @gestionnaireUtilisateur.connexionUtilisateur(pseudo,passe)) == nil
                @vue.utilisateurInexistant()
            else
                if @@utilisateur.type == Utilisateur::ONLINE
                    @vue.pasInternet
                end
                if @@utilisateur.motDePasse == passe
                    @vue.fermerCadre
                    changerControleur(ControleurMenuPrincipal.new(@jeu))
                else
                    @vue.mauvaisPasse
                end
            end
        elsif connexion > -1
            if (@@utilisateur = @gestionnaireUtilisateur.connexionUtilisateur(pseudo,passe)) == nil
                @vue.utilisateurInexistant()
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