class VueNouvellePartie < Vue

	@button6x6
	@button8x8
	@button10x10
	@button12x12

	@labelDiff

	@buttonDiff1
    @buttonDiff2
    @buttonDiff3
    @buttonDiff4
    @buttonDiff5
    @buttonDiff6
    @buttonDiff7

	@buttonAnnuler

	@listeDiff

	@taille
	@difficulte

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)
		vboxPrincipale = Box.new(:vertical)

		labelTaille = Label.new()
		labelTaille.set_markup("<big>Taille de la grille</big>")
		vboxPrincipale.add(labelTaille)

		# Boutons taille de la grille
		hboxTaille = Box.new(:horizontal)
		@button6x6 = ToggleButton.new("6x6")
		@button8x8 = ToggleButton.new("8x8")
		@button10x10 = ToggleButton.new("10x10")
		@button12x12 = ToggleButton.new("12x12")

		@button6x6.signal_connect('toggled') { onBtnTailleToggle(6,@button6x6) }
		@button8x8.signal_connect('toggled') { onBtnTailleToggle(8,@button8x8) }
		@button10x10.signal_connect('toggled') { onBtnTailleToggle(10,@button10x10) }
		@button12x12.signal_connect('toggled') { onBtnTailleToggle(12,@button12x12) }

		hboxTaille.add(@button6x6)
		hboxTaille.add(@button8x8)
		hboxTaille.add(@button10x10)
		hboxTaille.add(@button12x12)

		vboxPrincipale.add(hboxTaille)

        @labelDiff = Label.new()
		@labelDiff.set_markup("<big>Difficulté</big>")
		vboxPrincipale.add(@labelDiff)

        # Boutons difficulté
        hboxDiff = Box.new(:horizontal)
        @buttonDiff1 = ToggleButton.new("1")
        @buttonDiff2 = ToggleButton.new("2")
        @buttonDiff3 = ToggleButton.new("3")
        @buttonDiff4 = ToggleButton.new("4")
        @buttonDiff5 = ToggleButton.new("5")
        @buttonDiff6 = ToggleButton.new("6")
        @buttonDiff7 = ToggleButton.new("7")

        @buttonDiff1.signal_connect('toggled') { onBtnDifficulteToggle(1,@buttonDiff1) }
        @buttonDiff2.signal_connect('toggled') { onBtnDifficulteToggle(2,@buttonDiff2) }
        @buttonDiff3.signal_connect('toggled') { onBtnDifficulteToggle(3,@buttonDiff3) }
        @buttonDiff4.signal_connect('toggled') { onBtnDifficulteToggle(4,@buttonDiff4) }
        @buttonDiff5.signal_connect('toggled') { onBtnDifficulteToggle(5,@buttonDiff5) }
        @buttonDiff6.signal_connect('toggled') { onBtnDifficulteToggle(6,@buttonDiff6) }
        @buttonDiff7.signal_connect('toggled') { onBtnDifficulteToggle(7,@buttonDiff7) }

        hboxDiff.add(@buttonDiff1)
        hboxDiff.add(@buttonDiff2)
        hboxDiff.add(@buttonDiff3)
        hboxDiff.add(@buttonDiff4)
        hboxDiff.add(@buttonDiff5)
        hboxDiff.add(@buttonDiff6)
        hboxDiff.add(@buttonDiff7)

        vboxPrincipale.add(hboxDiff)

        @buttonValider = Button.new(:stock_id => Gtk::Stock::APPLY)
		vboxPrincipale.add(@buttonValider)
        @buttonValider.signal_connect('clicked')  { onBtnValiderClicked }

		@buttonAnnuler = Button.new(:stock_id => Gtk::Stock::CANCEL)
		vboxPrincipale.add(@buttonAnnuler)
        @buttonAnnuler.signal_connect('clicked')  { onBtnAnnulerClicked }
      
      	@cadre.add(vboxPrincipale)
        self.actualiser()

        @buttonValider.hide()
        @labelDiff.hide()
        @buttonDiff1.hide()
        @buttonDiff2.hide()
        @buttonDiff3.hide()
        @buttonDiff4.hide()
        @buttonDiff5.hide()
        @buttonDiff6.hide()
        @buttonDiff7.hide()
	end

	def onBtnTailleToggle(taille,bouton)
		if(@taille)
			@buttonDiff1.hide()
	        @buttonDiff2.hide()
	        @buttonDiff3.hide()
	        @buttonDiff4.hide()
	        @buttonDiff5.hide()
	        @buttonDiff6.hide()
	        @buttonDiff7.hide()
    	end

    	if(@difficulte)
    		@difficulte = nil
    		@buttonValider.hide()
    		@labelDiff.hide()
    		@buttonDiff1.active = false
	        @buttonDiff2.active = false
	        @buttonDiff3.active = false
	        @buttonDiff4.active = false
	        @buttonDiff5.active = false
	        @buttonDiff6.active = false
	        @buttonDiff7.active = false
    	end

		@taille = taille
		@labelDiff.show()

		if(bouton != @button6x6)
			@button6x6.active = false
		end
		if(bouton != @button8x8)
			@button8x8.active = false
		end
		if(bouton != @button10x10)
			@button10x10.active = false
		end
		if(bouton != @button12x12)
			@button12x12.active = false
		end
		@listeDiff = GestionnaireNiveau.instance.recupererListeDifficulte(@taille)
		@listeDiff.each do |niveau|
			if(niveau == 1)
				@buttonDiff1.show()
			end
			if(niveau == 2)
				@buttonDiff2.show()
			end
			if(niveau == 3)
				@buttonDiff3.show()
			end
			if(niveau == 4)
				@buttonDiff4.show()
			end
			if(niveau == 5)
				@buttonDiff5.show()
			end
			if(niveau == 6)
				@buttonDiff6.show()
			end
			if(niveau == 7)
				@buttonDiff7.show()
			end
		end
	end

	def onBtnDifficulteToggle(difficulte,bouton)
		@difficulte = difficulte
		if(bouton != @buttonDiff1)
			@buttonDiff1.active = false
		end
		if(bouton != @buttonDiff2)
			@buttonDiff2.active = false
		end
		if(bouton != @buttonDiff3)
			@buttonDiff3.active = false
		end
		if(bouton != @buttonDiff4)
			@buttonDiff4.active = false
		end
		if(bouton != @buttonDiff5)
			@buttonDiff5.active = false
		end
		if(bouton != @buttonDiff6)
			@buttonDiff6.active = false
		end
		if(bouton != @buttonDiff7)
			@buttonDiff7.active = false
		end
		@buttonValider.show()
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