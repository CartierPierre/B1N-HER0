class ControleurClassement < Controleur

	def initialize(jeu)
		super(jeu)
		@modele = nil
		@vue = VueClassement.new(@modele,self.getLangue[:classement],self)
	end


    def annuler()
        changerControleur(ControleurMenuPrincipal.new(@jeu))
    end

    def listeUtilisteurs
        return  @gestionnaireUtilisateur.recupererListeUtilisateur(0,@gestionnaireUtilisateur.recupererNombreUtilisateur())
    end
end