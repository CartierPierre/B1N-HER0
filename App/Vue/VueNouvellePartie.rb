class VueNouvellePartie < Vue

    ### Attributs d'instances

    # Boutons taille de la grille
    @boutonDerniereTaille
	@bouton6x6
	@bouton8x8
	@bouton10x10
	@bouton12x12

    # Boutons difficulté
    @boutonDerniereDifficulte
	@labelDifficulte
    @boutonsDifficulte

	@boutonRetour

    # Taille et difficulté sélectionnée
	@taille
	@difficulte

    ##
    # Initialise le tableau contenant les boutons de chaque difficulté (1 à 7)
    #
    def initTableauBoutonsDifficulte()
        # 7 correspond à la difficulté maximale
        1.upto(7) do |difficulte|
            boutonTemp = Button.new(:label => difficulte.to_s)
            boutonTemp.signal_connect('clicked') { onBtnDifficulteClicked(boutonTemp,difficulte) }
            @boutonsDifficulte.push(boutonTemp)
        end
    end

    ##
    # Méthode de création de la vue qui permet de configurer la taille de la grille 
    # et la difficulté du niveau puis de lancer une partie
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)

        @cadre.set_size_request(420,410)
        @@fenetre.set_size_request(420,410).show_all

		# Box et boutons pour choisir la taille de la grille
		hboxTaille = Box.new(:horizontal, 10)

		@bouton6x6 = Button.new(:label => "6x6")
		@bouton8x8 = Button.new(:label => "8x8")
		@bouton10x10 = Button.new(:label => "10x10")
		@bouton12x12 = Button.new(:label => "12x12")

		@bouton6x6.signal_connect('clicked') { onBtnTailleClicked(@bouton6x6,6) }
		@bouton8x8.signal_connect('clicked') { onBtnTailleClicked(@bouton8x8,8) }
		@bouton10x10.signal_connect('clicked') { onBtnTailleClicked(@bouton10x10,10) }
		@bouton12x12.signal_connect('clicked') { onBtnTailleClicked(@bouton12x12,12) }

		hboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		hboxTaille.add(@bouton6x6)
		hboxTaille.add(@bouton8x8)
		hboxTaille.add(@bouton10x10)
		hboxTaille.add(@bouton12x12)
		hboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Box et boutons pour choisir la difficulté du niveau
        hboxDifficulte = Box.new(:horizontal, 10)

        @labelDifficulte = creerLabelTailleGrosse(@controleur.getLangue[:difficulte])

        @boutonsDifficulte = Array.new()
        initTableauBoutonsDifficulte()

        hboxDifficulte.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        @boutonsDifficulte.each do |bouton|
            hboxDifficulte.add(bouton)
        end
        hboxDifficulte.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Boutons pour valider et annuler
        hboxValiderRetour = Box.new(:horizontal, 10)

        @boutonValider = Button.new(:label => @controleur.getLangue[:appliquer])
        @boutonValider.signal_connect('clicked')  { onBtnValiderClicked }

		@boutonRetour = Button.new(:label => @controleur.getLangue[:retour])
        @boutonRetour.signal_connect('clicked')  { onBtnRetourClicked }

        hboxValiderRetour.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxValiderRetour.add(@boutonValider)
        hboxValiderRetour.add(@boutonRetour)
        hboxValiderRetour.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la vbox principale        		
		vboxPrincipale = Box.new(:vertical, 20)

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
       	vboxPrincipale.add(creerLabelTailleGrosse(@controleur.getLangue[:tailleGrille]))
        vboxPrincipale.add(hboxTaille)
        vboxPrincipale.add(@labelDifficulte)
        vboxPrincipale.add(hboxDifficulte)
        vboxPrincipale.add(hboxValiderRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        # Actualisation et masquage des boutons de choix de difficultés
      	@cadre.add(vboxPrincipale)
        self.actualiser()

        @boutonValider.set_sensitive(false)
        @labelDifficulte.hide()
        @boutonsDifficulte.each do |bouton|
            bouton.hide()
        end
	end

    ##
    # Listener sur les boutons de choix de la taille de la grille
    #
    # Paramètres::
    #   * _bouton_ - Bouton qui a été cliqué
    #   * _taille_ - Taille de la grille sélectionnée
    #
	def onBtnTailleClicked(bouton, taille)
		if(@taille)
			@boutonsDifficulte.each do |bouton|
                bouton.hide()
            end
    	end

    	if(@difficulte)
    		@difficulte = nil
            @boutonDerniereDifficulte.set_sensitive(true)
    		@boutonValider.set_sensitive(false)
        end

		@taille = taille
		@labelDifficulte.show()

        if(!@boutonDerniereTaille)
            @boutonDerniereTaille = bouton
        end
		@boutonDerniereTaille.set_sensitive(true)
        @boutonDerniereTaille = bouton
        @boutonDerniereTaille.set_sensitive(false)

		listeDifficulte = GestionnaireNiveau.instance.recupererListeDifficulte(@taille)
		listeDifficulte.each do |niveau|
            case(niveau)
                when 1 then @boutonsDifficulte[0].show();
                when 2 then @boutonsDifficulte[1].show();
                when 3 then @boutonsDifficulte[2].show();
                when 4 then @boutonsDifficulte[3].show();
                when 5 then @boutonsDifficulte[4].show();
                when 6 then @boutonsDifficulte[5].show();
                when 7 then @boutonsDifficulte[6].show();
            end
		end
	end

    ##
    # Listener sur les boutons de choix de la difficulté du niveau
    #
    # Paramètres::
    #   * _bouton_ - Bouton qui a été cliqué
    #   * _difficulte_ - Difficulté du niveau sélectionnée  
    #
	def onBtnDifficulteClicked(bouton, difficulte)
		@difficulte = difficulte
        if(!@boutonDerniereDifficulte)
            @boutonDerniereDifficulte = bouton
        end
		@boutonDerniereDifficulte.set_sensitive(true)
        @boutonDerniereDifficulte = bouton
        @boutonDerniereDifficulte.set_sensitive(false)
		@boutonValider.set_sensitive(true)
	end
	
    ##
    # Listener sur le bouton valider
    # Ferme le cadre et ouvre la vue partie avec une partie choisie aléatoirement 
    # en fonction de la taille et difficulté sélectionnée
    #
	def onBtnValiderClicked
        fermerCadre()
        @controleur.jouer(@taille,@difficulte)
	end

    ##
    # Listener sur le bouton retour
    # Ferme le cadre et retourne au menu principal
    #
	def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
	end

end