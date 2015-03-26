class ControleurInscription < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueInscription.new(@modele,"Inscription",self)
	end


    def valider(pseudo,password)
        @utilisateur = Utilisateur.creer(pseudo,password,Utilisateur::ONLINE)
        begin
            @gestionnaireUtilisateur.persist(@utilisateur)
            rescue SQLite3::ConstraintException => erreur
                @vue.utilisateurExistant(pseudo)
        end
                changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end


end