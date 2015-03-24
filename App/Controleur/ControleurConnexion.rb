class ControleurConnexion < Controleur
    @utilisateur
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueConnexion.new(@modele,"Connexion",self)
	end


    def valider(pseudo,password)
        if GU.getForAuthentication(pseudo,password)
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end


end