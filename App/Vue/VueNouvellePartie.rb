class VueNouvellePartie < Vue

    @boutonDerniereTaille
	@bouton6x6
	@bouton8x8
	@bouton10x10
	@bouton12x12

	@labelDifficulte

    @boutonDerniereDifficulte

	@boutonAnnuler

	@listeDifficulte

	@taille
	@difficulte

    def initTableauBoutonsDifficulte()
        # 7 correspond à la difficulté maximale
        1.upto(7) do |difficulte|
            boutonTemp = Button.new(:label => difficulte.to_s)
            boutonTemp.signal_connect('clicked') { onBtnDifficulteClicked(boutonTemp,difficulte) }
            @boutonsDifficulte.push(boutonTemp)
        end
    end

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)

		# Box et boutons taille de la grille
		hboxTaille = Box.new(:horizontal, 10)

		labelTaille = Label.new()
		labelTaille.set_markup("<big>" + @controleur.getLangue[:tailleGrille] + "</big>")

		@bouton6x6 = Button.new(:label => "6x6")
		@bouton8x8 = Button.new(:label => "8x8")
		@bouton10x10 = Button.new(:label => "10x10")
		@bouton12x12 = Button.new(:label => "12x12")

		@bouton6x6.signal_connect('clicked') { onBtnTailleClicked(6,@bouton6x6) }
		@bouton8x8.signal_connect('clicked') { onBtnTailleClicked(8,@bouton8x8) }
		@bouton10x10.signal_connect('clicked') { onBtnTailleClicked(10,@bouton10x10) }
		@bouton12x12.signal_connect('clicked') { onBtnTailleClicked(12,@bouton12x12) }

		hboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		hboxTaille.add(@bouton6x6)
		hboxTaille.add(@bouton8x8)
		hboxTaille.add(@bouton10x10)
		hboxTaille.add(@bouton12x12)
		hboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Box et boutons difficulté
        hboxDifficulte = Box.new(:horizontal, 10)

        @labelDifficulte = Label.new()
		@labelDifficulte.set_markup("<big>" + @controleur.getLangue[:difficulte] + "</big>")

        @boutonsDifficulte = Array.new()
        initTableauBoutonsDifficulte()

        hboxDifficulte.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        @boutonsDifficulte.each do |bouton|
            hboxDifficulte.add(bouton)
        end
        hboxDifficulte.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Boutons valider et annuler
        hboxValiderAnnuler = Box.new(:horizontal, 10)

        @boutonValider = Button.new(:label => @controleur.getLangue[:appliquer])
        @boutonValider.signal_connect('clicked')  { onBtnValiderClicked }

		@boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonAnnuler.signal_connect('clicked')  { onBtnAnnulerClicked }

        hboxValiderAnnuler.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxValiderAnnuler.add(@boutonValider)
        hboxValiderAnnuler.add(@boutonAnnuler)
        hboxValiderAnnuler.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la vbox principale        		
		vboxPrincipale = Box.new(:vertical, 20)

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
       	vboxPrincipale.add(labelTaille)
        vboxPrincipale.add(hboxTaille)
        vboxPrincipale.add(@labelDifficulte)
        vboxPrincipale.add(hboxDifficulte)
        vboxPrincipale.add(hboxValiderAnnuler)
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

	def onBtnTailleClicked(taille,bouton)
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

		@listeDifficulte = GestionnaireNiveau.instance.recupererListeDifficulte(@taille)
		@listeDifficulte.each do |niveau|
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

	def onBtnDifficulteClicked(bouton,difficulte)
		@difficulte = difficulte
        if(!@boutonDerniereDifficulte)
            @boutonDerniereDifficulte = bouton
        end
		@boutonDerniereDifficulte.set_sensitive(true)
        @boutonDerniereDifficulte = bouton
        @boutonDerniereDifficulte.set_sensitive(false)
		@boutonValider.set_sensitive(true)
	end
	
	def onBtnValiderClicked
        fermerCadre()
        @controleur.jouer(@taille,@difficulte)
	end

	def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler
	end

end