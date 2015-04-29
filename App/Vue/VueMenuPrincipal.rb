class VueMenuPrincipal < Vue

    ### Attributs d'instances

	@boutonNouvellePartie
    @boutonChargerPartie
	@boutonClassement
	@boutonOptions
	@boutonProfil
    @boutonRegles
    @boutonCredits
	@boutonQuitter

    ### Attribut de classe

    @@premiereFois = true # Indique si c'est la première fois qu'on visite le menu principal ou non

    ##
    # Méthode de création de la vue menu principal qui permet de sélectionner 
    # les différents éléments et fonctionnalités du jeu
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)

		vboxPrincipale = Box.new(:vertical, 20)

        # Boite de dialogue qui propose de reprendre la dernière partie si on visite le menu principal pour la première fois
        if(@@premiereFois && @controleur.getNombreSauvegardes() > 0)
            @@premiereFois = false
            confirmation = false
            dialogReprendrePartie = Dialog.new(:parent => @@fenetre, :title => @controleur.getLangue[:reprendrePartie], :flags => :modal,:buttons => [[@controleur.getLangue[:oui],ResponseType::YES],[@controleur.getLangue[:non],ResponseType::NO]])
            
            labelReprendrePartie = creerLabelTailleMoyenne(@controleur.getLangue[:confirmationReprendrePartie])
            dialogReprendrePartie.child.set_spacing(20)
            dialogReprendrePartie.child.add(labelReprendrePartie)

            dialogReprendrePartie.show_all()
            dialogReprendrePartie.run do |reponse|
                if(reponse == ResponseType::YES)
                    confirmation = true
                else
                    confirmation = false
                end             
            end
            dialogReprendrePartie.destroy()

            if(confirmation)
                fermerCadre()
                @controleur.reprendrePartie()
            end
        end

        # Création des boutons
		@boutonNouvellePartie = Button.new(:label => @controleur.getLangue[:nouvellePartie])
        @boutonNouvellePartie.set_size_request(100,35)
        @boutonChargerPartie = Button.new(:label => @controleur.getLangue[:chargerPartie])
        @boutonChargerPartie.set_size_request(100,35)
		@boutonClassement = Button.new(:label => @controleur.getLangue[:classement])
        @boutonClassement.set_size_request(100,35)
		@boutonOptions = Button.new(:label => @controleur.getLangue[:options])
        @boutonOptions.set_size_request(100,35)
		@boutonProfil = Button.new(:label => @controleur.getLangue[:profil])
        @boutonProfil.set_size_request(100,35)
        @boutonRegles = Button.new(:label => @controleur.getLangue[:regles])
        @boutonRegles.set_size_request(100,35)
        @boutonCredits = Button.new(:label => @controleur.getLangue[:credits])
        @boutonCredits.set_size_request(100,35)
		@boutonQuitter = Button.new(:label => @controleur.getLangue[:quitter])
        @boutonQuitter.set_size_request(100,35)

        # Ajout des boutons dans la vbox principale
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        creerAlignBouton(vboxPrincipale,@boutonNouvellePartie)
        creerAlignBouton(vboxPrincipale,@boutonChargerPartie)
        creerAlignBouton(vboxPrincipale,@boutonClassement)
        creerAlignBouton(vboxPrincipale,@boutonOptions)
        creerAlignBouton(vboxPrincipale,@boutonProfil)
        creerAlignBouton(vboxPrincipale,@boutonRegles)
        creerAlignBouton(vboxPrincipale,@boutonCredits)
        creerAlignBouton(vboxPrincipale,@boutonQuitter)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)

        # Signaux des boutons
        @boutonNouvellePartie.signal_connect('clicked') { onBtnNouvellePartieClicked }
        @boutonChargerPartie.signal_connect('clicked') { onBtnChargerPartieClicked }
        @boutonClassement.signal_connect('clicked') { onBtnClassementClicked }
        @boutonOptions.signal_connect('clicked') { onBtnOptionsClicked }        
        @boutonProfil.signal_connect('clicked') { onBtnProfilClicked }  
        @boutonRegles.signal_connect('clicked') { onBtnReglesClicked }      
        @boutonCredits.signal_connect('clicked') { onBtnCreditsClicked }
        @boutonQuitter.signal_connect('clicked') { @controleur.quitterJeu }
     
        self.actualiser()
	end
	
    ##
    # Listener sur le bouton nouvelle partie
    # Ferme le cadre et ouvre la vue qui permet de lancer une nouvelle partie
    #
	def onBtnNouvellePartieClicked
        fermerCadre()
        @controleur.nouvellePartie()
	end

    ##
    # Listener sur le bouton charger partie
    # Ferme le cadre et ouvre la vue qui permet de charger une partie précédente
    #
    def onBtnChargerPartieClicked
        fermerCadre()
        @controleur.chargerPartie()
    end

    ##
    # Listener sur le bouton classement
    # Ferme le cadre et ouvre la vue qui permet de voir le classement du jeu
    #
    def onBtnClassementClicked
        fermerCadre()
        @controleur.classement()
    end

    ##
    # Listener sur le bouton options
    # Ferme le cadre et ouvre la vue qui permet de configurer les options du jeu
    #
	def onBtnOptionsClicked
        fermerCadre()
		@controleur.options()
	end

    ##
    # Listener sur le bouton profil
    # Ferme le cadre et ouvre la vue qui permet de voir le profil de l'utilisateur connecté
    #
    def onBtnProfilClicked
        fermerCadre()
        @controleur.profil()
    end

    ##
    # Listener sur le bouton règles du jeu
    # Ferme le cadre et ouvre la vue qui affiche les règles du jeu
    #
    def onBtnReglesClicked
        fermerCadre()
        @controleur.regles()
    end

    ##
    # Listener sur le bouton crédits
    # Ferme le cadre et ouvre la vue qui affiche les crédits du jeu
    #
    def onBtnCreditsClicked
        fermerCadre()
        @controleur.credits()
    end

end