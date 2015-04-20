class ControleurDemarrage < Controleur
    
	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueDemarrage.new(@modele,self.getLangue[:demarrage],self)
	end

    def connexion()
        changerControleur(ControleurConnexion.new(@jeu))
    end

    def inscription()
        changerControleur(ControleurInscription.new(@jeu,""))
    end

end