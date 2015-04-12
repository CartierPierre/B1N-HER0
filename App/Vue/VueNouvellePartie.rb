class VueNouvellePartie < Vue

	@bouton6x6
	@bouton8x8
	@bouton10x10
	@bouton12x12

	@labelDiff

	@boutonDiff1
    @boutonDiff2
    @boutonDiff3
    @boutonDiff4
    @boutonDiff5
    @boutonDiff6
    @boutonDiff7

	@boutonAnnuler

	@listeDiff

	@taille
	@difficulte

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)

		# Box et boutons taille de la grille
		hboxTaille = Box.new(:horizontal, 10)

		labelTaille = Label.new()
		labelTaille.set_markup("<big>" + @controleur.getLangue[:tailleGrille] + "</big>")

		@bouton6x6 = ToggleButton.new("6x6")
		@bouton8x8 = ToggleButton.new("8x8")
		@bouton10x10 = ToggleButton.new("10x10")
		@bouton12x12 = ToggleButton.new("12x12")

		@bouton6x6.signal_connect('toggled') { onBtnTailleToggle(6,@bouton6x6) }
		@bouton8x8.signal_connect('toggled') { onBtnTailleToggle(8,@bouton8x8) }
		@bouton10x10.signal_connect('toggled') { onBtnTailleToggle(10,@bouton10x10) }
		@bouton12x12.signal_connect('toggled') { onBtnTailleToggle(12,@bouton12x12) }

		hboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		hboxTaille.add(@bouton6x6)
		hboxTaille.add(@bouton8x8)
		hboxTaille.add(@bouton10x10)
		hboxTaille.add(@bouton12x12)
		hboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Box et boutons difficulté
        hboxDiff = Box.new(:horizontal, 10)

        @labelDiff = Label.new()
		@labelDiff.set_markup("<big>" + @controleur.getLangue[:difficulte] + "</big>")

        @boutonDiff1 = ToggleButton.new("1")
        @boutonDiff2 = ToggleButton.new("2")
        @boutonDiff3 = ToggleButton.new("3")
        @boutonDiff4 = ToggleButton.new("4")
        @boutonDiff5 = ToggleButton.new("5")
        @boutonDiff6 = ToggleButton.new("6")
        @boutonDiff7 = ToggleButton.new("7")

        @boutonDiff1.signal_connect('toggled') { onBtnDifficulteToggle(1,@boutonDiff1) }
        @boutonDiff2.signal_connect('toggled') { onBtnDifficulteToggle(2,@boutonDiff2) }
        @boutonDiff3.signal_connect('toggled') { onBtnDifficulteToggle(3,@boutonDiff3) }
        @boutonDiff4.signal_connect('toggled') { onBtnDifficulteToggle(4,@boutonDiff4) }
        @boutonDiff5.signal_connect('toggled') { onBtnDifficulteToggle(5,@boutonDiff5) }
        @boutonDiff6.signal_connect('toggled') { onBtnDifficulteToggle(6,@boutonDiff6) }
        @boutonDiff7.signal_connect('toggled') { onBtnDifficulteToggle(7,@boutonDiff7) }

        hboxDiff.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxDiff.add(@boutonDiff1)
        hboxDiff.add(@boutonDiff2)
        hboxDiff.add(@boutonDiff3)
        hboxDiff.add(@boutonDiff4)
        hboxDiff.add(@boutonDiff5)
        hboxDiff.add(@boutonDiff6)
        hboxDiff.add(@boutonDiff7)
        hboxDiff.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

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
        vboxPrincipale.add(@labelDiff)
        vboxPrincipale.add(hboxDiff)
        vboxPrincipale.add(hboxValiderAnnuler)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        # Actualisation et masquage des boutons de choix de difficultés
      	@cadre.add(vboxPrincipale)
        self.actualiser()

        @boutonValider.set_sensitive(false)
        @labelDiff.hide()
        @boutonDiff1.hide()
        @boutonDiff2.hide()
        @boutonDiff3.hide()
        @boutonDiff4.hide()
        @boutonDiff5.hide()
        @boutonDiff6.hide()
        @boutonDiff7.hide()
	end

	def onBtnTailleToggle(taille,bouton)
		if(@taille)
			@boutonDiff1.hide()
	        @boutonDiff2.hide()
	        @boutonDiff3.hide()
	        @boutonDiff4.hide()
	        @boutonDiff5.hide()
	        @boutonDiff6.hide()
	        @boutonDiff7.hide()
    	end

    	if(@difficulte)
    		@difficulte = nil
    		@boutonValider.set_sensitive(false)
    		@labelDiff.hide()
    		@boutonDiff1.active = false
	        @boutonDiff2.active = false
	        @boutonDiff3.active = false
	        @boutonDiff4.active = false
	        @boutonDiff5.active = false
	        @boutonDiff6.active = false
	        @boutonDiff7.active = false
    	end

		@taille = taille
		@labelDiff.show()

		if(bouton != @bouton6x6)
			@bouton6x6.active = false
		end
		if(bouton != @bouton8x8)
			@bouton8x8.active = false
		end
		if(bouton != @bouton10x10)
			@bouton10x10.active = false
		end
		if(bouton != @bouton12x12)
			@bouton12x12.active = false
		end
		@listeDiff = GestionnaireNiveau.instance.recupererListeDifficulte(@taille)
		@listeDiff.each do |niveau|
			if(niveau == 1)
				@boutonDiff1.show()
			end
			if(niveau == 2)
				@boutonDiff2.show()
			end
			if(niveau == 3)
				@boutonDiff3.show()
			end
			if(niveau == 4)
				@boutonDiff4.show()
			end
			if(niveau == 5)
				@boutonDiff5.show()
			end
			if(niveau == 6)
				@boutonDiff6.show()
			end
			if(niveau == 7)
				@boutonDiff7.show()
			end
		end
	end

	def onBtnDifficulteToggle(difficulte,bouton)
		@difficulte = difficulte
		if(bouton != @boutonDiff1)
			@boutonDiff1.active = false
		end
		if(bouton != @boutonDiff2)
			@boutonDiff2.active = false
		end
		if(bouton != @boutonDiff3)
			@boutonDiff3.active = false
		end
		if(bouton != @boutonDiff4)
			@boutonDiff4.active = false
		end
		if(bouton != @boutonDiff5)
			@boutonDiff5.active = false
		end
		if(bouton != @boutonDiff6)
			@boutonDiff6.active = false
		end
		if(bouton != @boutonDiff7)
			@boutonDiff7.active = false
		end
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