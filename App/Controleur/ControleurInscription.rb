class ControleurInscription < Controleur

	def initialize(jeu,pseudo)
		super(jeu)
		@modele = nil
		@vue = VueInscription.new(@modele,self.getLangue[:inscription],self,pseudo)
	end

    def valider(pseudo,password,statut)
		utilisateur = Utilisateur.creer( pseudo, password, statut )
		begin
			Stockage.instance().inscription( utilisateur )
		rescue Exception => e
			case( e.message )
				when "L'utilisateur existe déjà !"
					return 0
				when "Erreur de connexion !"
					return 1
			end
		end
		@@utilisateur = utilisateur
        @vue.fermerCadre
		changerControleur(ControleurMenuPrincipal.new(@jeu))
		
    end

    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end

    def retour(pseudo)
        @vue.fermerCadre
        changerControleur(ControleurInscription.new(@jeu,pseudo))
    end


end