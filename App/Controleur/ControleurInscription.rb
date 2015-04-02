class ControleurInscription < Controleur

	def initialize(jeu,pseudo)
		super(jeu)
		@modele = nil
		@vue = VueInscription.new(@modele,"Inscription",self,pseudo)
	end



    def valider(pseudo,password)
        @utilisateur = Utilisateur.creer(pseudo,password,Utilisateur::ONLINE)
        begin
            @gestionnaireUtilisateur.persist(@utilisateur)
            rescue SQLite3::ConstraintException => erreur
                @vue.utilisateurExistant(pseudo)
        end
                changerControleur(ControleurMenuPrincipal.new(@jeu,nil))
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end


end