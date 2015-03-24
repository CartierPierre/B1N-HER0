class ControleurConnexion < Controleur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,"Connexion",self)
	end


    def valider(pseudo,password)
        if (@utilisateur = @gestionnaireUtilisateur.getForAuthentication(pseudo,password)) == nil
            @vue.mauvaisIdentifiants()
        else
            changerControleur(ControleurMenuPrincipal.new(@jeu))
        end
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end


end