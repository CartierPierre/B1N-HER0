class ControleurConnexion < Controleur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,"Connexion",self)
	end


    def valider(pseudo,password)
        if (@utilisateur = @gestionnaireUtilisateur.getForAuthentication(pseudo,password)) == nil
            @vue.utilisateurInexistant()
        else
            changerControleur(ControleurMenuPrincipal.new(@jeu,@utilisateur))
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