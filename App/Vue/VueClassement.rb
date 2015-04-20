class VueClassement < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)


        @view = Gtk::TreeView.new()

        col = Gtk::TreeViewColumn.new(@controleur.getLangue[:pseudo])
        col2 = Gtk::TreeViewColumn.new(@controleur.getLangue[:score])

        @view.append_column(col)
        @view.append_column(col2)

		labelTaille = Label.new()
		labelTaille.set_markup("<big>" + @controleur.getLangue[:tailleGrille] + "</big>")

        @labelDiff = Label.new()
		@labelDiff.set_markup("<big>" + @controleur.getLangue[:difficulte] + "</big>")

        @boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonAnnuler.signal_connect('clicked') { onBtnAnnulerClicked }

		@bouton6x6 = Button.new(:label => "6x6")
		@bouton8x8 = Button.new(:label => "8x8")
		@bouton10x10 = Button.new(:label => "10x10")
		@bouton12x12 = Button.new(:label => "12x12")

		@bouton6x6.signal_connect('clicked') { onBtnTailleClicked(6,@bouton6x6) }
		@bouton8x8.signal_connect('clicked') { onBtnTailleClicked(8,@bouton8x8) }
		@bouton10x10.signal_connect('clicked') { onBtnTailleClicked(10,@bouton10x10) }
		@bouton12x12.signal_connect('clicked') { onBtnTailleClicked(12,@bouton12x12) }

        @boutonDiff1 = Button.new(:label => "1")
        @boutonDiff2 = Button.new(:label => "2")
        @boutonDiff3 = Button.new(:label => "3")
        @boutonDiff4 = Button.new(:label => "4")
        @boutonDiff5 = Button.new(:label => "5")
        @boutonDiff6 = Button.new(:label => "6")
        @boutonDiff7 = Button.new(:label => "7")

        @boutonDiff1.signal_connect('clicked') { onBtnDifficulteClicked(1,@boutonDiff1) }
        @boutonDiff2.signal_connect('clicked') { onBtnDifficulteClicked(2,@boutonDiff2) }
        @boutonDiff3.signal_connect('clicked') { onBtnDifficulteClicked(3,@boutonDiff3) }
        @boutonDiff4.signal_connect('clicked') { onBtnDifficulteClicked(4,@boutonDiff4) }
        @boutonDiff5.signal_connect('clicked') { onBtnDifficulteClicked(5,@boutonDiff5) }
        @boutonDiff6.signal_connect('clicked') { onBtnDifficulteClicked(6,@boutonDiff6) }
        @boutonDiff7.signal_connect('clicked') { onBtnDifficulteClicked(7,@boutonDiff7) }

		vboxTaille = Box.new(:vertical, 10)
		vboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		vboxTaille.add(labelTaille)
		vboxTaille.add(@bouton6x6)
		vboxTaille.add(@bouton8x8)
		vboxTaille.add(@bouton10x10)
		vboxTaille.add(@bouton12x12)
		vboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)


        vboxDiff = Box.new(:vertical, 10)
        vboxDiff.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		vboxDiff.add(@labelDiff)
        vboxDiff.add(@boutonDiff1)
        vboxDiff.add(@boutonDiff2)
        vboxDiff.add(@boutonDiff3)
        vboxDiff.add(@boutonDiff4)
        vboxDiff.add(@boutonDiff5)
        vboxDiff.add(@boutonDiff6)
        vboxDiff.add(@boutonDiff7)
        vboxDiff.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

		hboxClass = Box.new(:horizontal, 10)
        hboxClass.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxClass.add(vboxTaille)
        hboxClass.add(vboxDiff)
        hboxClass.add(@view)
        hboxClass.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

		hboxAnnuler = Box.new(:horizontal, 10)
        hboxAnnuler.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxAnnuler.add(@boutonAnnuler)
        hboxAnnuler.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxPrincipale = Box.new(:vertical, 20)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(hboxClass)
        vboxPrincipale.add(hboxAnnuler)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)
        self.actualiser()

        @labelDiff.hide()
        @boutonDiff1.hide()
        @boutonDiff2.hide()
        @boutonDiff3.hide()
        @boutonDiff4.hide()
        @boutonDiff5.hide()
        @boutonDiff6.hide()
        @boutonDiff7.hide()
    end

	def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler()
	end

	def onBtnTailleClicked(taille,bouton)
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
            @boutonDerniereDiff.set_sensitive(true)
    		@boutonValider.set_sensitive(false)
        end

		@taille = taille
		@labelDiff.show()

        if(!@boutonDerniereTaille)
            @boutonDerniereTaille = bouton
        end
		@boutonDerniereTaille.set_sensitive(true)
        @boutonDerniereTaille = bouton
        @boutonDerniereTaille.set_sensitive(false)

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
end