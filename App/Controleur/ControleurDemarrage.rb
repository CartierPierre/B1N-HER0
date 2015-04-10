class ControleurDemarrage < Controleur
    
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueDemarrage.new(@modele,"Demarrage",self)
	end

    def connexion()
        changerControleur(ControleurConnexion.new(@jeu))
    end

    def inscription()
        changerControleur(ControleurInscription.new(@jeu,""))
    end

end