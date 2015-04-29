class ControleurInscription < Controleur

    ##
    # Méthode de création du controleur qui est responsable de la vue du menu d'inscription
    #
    # Paramètre::
    #   * _jeu_ - Jeu associé (classe principale du BinHero qui charge GTK)
    #   * _pseudo_ - Pseudo à rentrer dans le formulaire si besoin
    #
	def initialize(jeu,pseudo)             #:notnew:
		super(jeu)
		@modele = nil
		@vue = VueInscription.new(@modele,self.getLangue[:inscription],self,pseudo)
	end

    ##
    # Valide le pseudo et le mot de passe en allant chercher dans la base de données
    #
    # Paramètre::
    #   * _passe_ - Le mot de passe à vérifier
    #   * _pseudo_ - Le pseudo à vérifier
    #   * _statut_ - Le mode de jeu choisi lors de l'inscription
    #
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

    ##
    # Change de controleur pour aller dans la vue Demarrage
    #
    def annuler()
        changerControleur(ControleurDemarrage.new(@jeu))
    end


    ##
    # Change de controleur pour actualiser la vue Inscription
    #
    def retour(pseudo)
        changerControleur(ControleurInscription.new(@jeu,pseudo))
    end


end