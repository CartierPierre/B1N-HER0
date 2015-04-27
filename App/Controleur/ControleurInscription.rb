class ControleurInscription < Controleur

	def initialize(jeu,pseudo)
		super(jeu)
		@modele = nil
		@vue = VueInscription.new(@modele,self.getLangue[:inscription],self,pseudo)
	end



    def valider(pseudo,password,statut)
        if  statut == Utilisateur::OFFLINE || testConnexion > -1
            @@utilisateur = Utilisateur.creer(pseudo,password,statut)
            begin
                @gestionnaireUtilisateur.sauvegarderUtilisateur(@@utilisateur)
                rescue Exception => erreur
                    @vue.utilisateurExistant(pseudo)
            end
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        else
            @vue.pasInternet(pseudo)
        end
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end

    def retour(pseudo)
        changerControleur(ControleurInscription.new(@jeu,pseudo))
    end


end