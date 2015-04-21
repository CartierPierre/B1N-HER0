class VueClassement < Vue

	@taille
	@difficulte
    @scores

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @scores = @controleur.listeScores()

        fenetreScroll = ScrolledWindow.new()
        fenetreScroll.set_policy(:never,:automatic)
        fenetreScroll.set_size_request(300,200)

        liste = ListStore.new(Integer,String,Integer,Integer,Integer)

        colonneRang = Gtk::TreeViewColumn.new(@controleur.getLangue[:rang],CellRendererText.new,:text => 0)
        colonneRang.sort_indicator = true
        colonneRang.sort_column_id = 0
        colonneRang.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end


        colonnePseudo = Gtk::TreeViewColumn.new(@controleur.getLangue[:pseudo],CellRendererText.new,:text => 1)
        colonnePseudo.sort_indicator = true
        colonnePseudo.sort_column_id = 1
        colonnePseudo.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonneScore = Gtk::TreeViewColumn.new(@controleur.getLangue[:score],CellRendererText.new,:text => 2)
        colonneScore.sort_indicator = true
        colonneScore.sort_column_id = 2
        colonneScore.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonneTaille = Gtk::TreeViewColumn.new(@controleur.getLangue[:taille],CellRendererText.new,:text => 3)
        colonneTaille.sort_indicator = true
        colonneTaille.sort_column_id = 3
        colonneTaille.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonneDifficulte = Gtk::TreeViewColumn.new(@controleur.getLangue[:difficulte],CellRendererText.new,:text => 4)
        colonneDifficulte.sort_indicator = true
        colonneDifficulte.sort_column_id = 4
        colonneDifficulte.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        view = TreeView.new(liste)
        view.append_column(colonneRang)
        view.append_column(colonnePseudo)
        view.append_column(colonneScore)
        view.append_column(colonneTaille)
        view.append_column(colonneDifficulte)
        fenetreScroll.add_with_viewport(view)

        @scores.each do |x|
            iter = liste.append
            iter[0] = 0
            iter[1] = "test"
            iter[2] = x.nbPoints
            iter[3] = 3
            iter[4] = 4
        end

		labelTaille = Label.new()
		labelTaille.set_markup("<big>" + @controleur.getLangue[:tailleGrille] + "</big>")

        labelDiff = Label.new()
		labelDiff.set_markup("<big>" + @controleur.getLangue[:difficulte] + "</big>")

        @boutonAnnuler = Button.new(:label => @controleur.getLangue[:annuler])
        @boutonAnnuler.signal_connect('clicked') { onBtnAnnulerClicked }

		@bouton6x6 = ToggleButton.new("6x6")
		@bouton8x8 = ToggleButton.new("8x8")
		@bouton10x10 = ToggleButton.new("10x10")
		@bouton12x12 = ToggleButton.new("12x12")

		@bouton6x6.signal_connect('clicked') { onBtnTailleClicked(6) }
		@bouton8x8.signal_connect('clicked') { onBtnTailleClicked(8) }
		@bouton10x10.signal_connect('clicked') { onBtnTailleClicked(10) }
		@bouton12x12.signal_connect('clicked') { onBtnTailleClicked(12) }

        @boutonDiff1 = ToggleButton.new("1")
        @boutonDiff2 = ToggleButton.new("2")
        @boutonDiff3 = ToggleButton.new("3")
        @boutonDiff4 = ToggleButton.new("4")
        @boutonDiff5 = ToggleButton.new("5")
        @boutonDiff6 = ToggleButton.new("6")
        @boutonDiff7 = ToggleButton.new("7")

        @boutonDiff1.signal_connect('clicked') { onBtnDifficulteClicked(1) }
        @boutonDiff2.signal_connect('clicked') { onBtnDifficulteClicked(2) }
        @boutonDiff3.signal_connect('clicked') { onBtnDifficulteClicked(3) }
        @boutonDiff4.signal_connect('clicked') { onBtnDifficulteClicked(4) }
        @boutonDiff5.signal_connect('clicked') { onBtnDifficulteClicked(5) }
        @boutonDiff6.signal_connect('clicked') { onBtnDifficulteClicked(6) }
        @boutonDiff7.signal_connect('clicked') { onBtnDifficulteClicked(7) }

		vboxTaille = Box.new(:vertical, 10)
		vboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		vboxTaille.add(labelTaille)
		vboxTaille.add(@bouton6x6)
		vboxTaille.add(@bouton8x8)
		vboxTaille.add(@bouton10x10)
		vboxTaille.add(@bouton12x12)
		vboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)


        hboxDiff = Box.new(:horizontal, 10)
        hboxDiff.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxDiff.add(@boutonDiff1)
        hboxDiff.add(@boutonDiff2)
        hboxDiff.add(@boutonDiff3)
        hboxDiff.add(@boutonDiff4)
        hboxDiff.add(@boutonDiff5)
        hboxDiff.add(@boutonDiff6)
        hboxDiff.add(@boutonDiff7)
        hboxDiff.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

		hboxClass = Box.new(:horizontal, 10)
        hboxClass.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxClass.add(vboxTaille)
        hboxClass.add(fenetreScroll)
        hboxClass.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

		hboxAnnuler = Box.new(:horizontal, 10)
        hboxAnnuler.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxAnnuler.add(@boutonAnnuler)
        hboxAnnuler.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxPrincipale = Box.new(:vertical, 20)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		vboxPrincipale.add(labelDiff)
        vboxPrincipale.add(hboxDiff)
        vboxPrincipale.add(hboxClass)
        vboxPrincipale.add(hboxAnnuler)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)
        self.actualiser()
    end

	def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler()
	end

	def onBtnTailleClicked(taille)
		@taille = taille
	end

	def onBtnDifficulteClicked(difficulte)
		@difficulte = difficulte
	end


end