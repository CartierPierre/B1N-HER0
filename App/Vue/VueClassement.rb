class VueClassement < Vue

	@taille
	@difficulte
    @scores

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        @scores = @controleur.listeDesScores()
        @boutonsTaille  = Array.new
        @boutonsDifficulte = Array.new

        fenetreScroll = ScrolledWindow.new()
        fenetreScroll.set_policy(:never,:automatic)
        fenetreScroll.set_size_request(300,200)

		labelTaille = Label.new()
		labelTaille.set_markup("<big>" + @controleur.getLangue[:tailleGrille] + "</big>")

        labelDiff = Label.new()
		labelDiff.set_markup("<big>" + @controleur.getLangue[:difficulte] + "</big>")

        labelRecherche = Label.new()
		labelRecherche.set_markup("<big>" + @controleur.getLangue[:recherche] + "</big>")

        @entreeRecherche = Entry.new

        @boutonDiff1 = ToggleButton.new("1")
        @boutonDiff2 = ToggleButton.new("2")
        @boutonDiff3 = ToggleButton.new("3")
        @boutonDiff4 = ToggleButton.new("4")
        @boutonDiff5 = ToggleButton.new("5")
        @boutonDiff6 = ToggleButton.new("6")
        @boutonDiff7 = ToggleButton.new("7")

		@bouton6x6 = ToggleButton.new("6x6")
		@bouton8x8 = ToggleButton.new("8x8")
		@bouton10x10 = ToggleButton.new("10x10")
		@bouton12x12 = ToggleButton.new("12x12")

        @liste = ListStore.new(Integer,String,Integer,Integer,Integer)
        renderer = CellRendererText.new

        colonneRang = Gtk::TreeViewColumn.new(@controleur.getLangue[:rang],renderer,:text => 0)
        colonneRang.sort_indicator = true
        colonneRang.sort_column_id = 0
        colonneRang.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonnePseudo = Gtk::TreeViewColumn.new(@controleur.getLangue[:pseudo],renderer,:text => 1)
        colonnePseudo.sort_indicator = true
        colonnePseudo.sort_column_id = 1
        colonnePseudo.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonneScore = Gtk::TreeViewColumn.new(@controleur.getLangue[:score],renderer,:text => 2)
        colonneScore.sort_indicator = true
        colonneScore.sort_column_id = 2
        colonneScore.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonneTaille = Gtk::TreeViewColumn.new(@controleur.getLangue[:taille],renderer,:text => 3)
        colonneTaille.sort_indicator = true
        colonneTaille.sort_column_id = 3
        colonneTaille.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonneDifficulte = Gtk::TreeViewColumn.new(@controleur.getLangue[:difficulte],renderer,:text => 4)
        colonneDifficulte.sort_indicator = true
        colonneDifficulte.sort_column_id = 4
        colonneDifficulte.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        view = TreeView.new(@liste)
        view.append_column(colonneRang)
        view.append_column(colonnePseudo)
        view.append_column(colonneScore)
        view.append_column(colonneTaille)
        view.append_column(colonneDifficulte)
        fenetreScroll.add_with_viewport(view)


        @scores.each do |x|
            iter = @liste.append
            iter[0] = 0
            iter[1] = x["pseudo"]
            iter[2] = x["points"]
            iter[3] = x["taille"]
            iter[4] = x["difficulte"]
        end

        @liste.set_sort_column_id(2, :descending)

        @filtre = TreeModelFilter.new(@liste,nil)

        increment = 1
        @liste.each do |model, path, iter|
            iter[0] = increment
            increment =increment + 1
        end

        @filtre.set_visible_func { |model,iter|
            if @entreeRecherche.text.empty?
                if @boutonsDifficulte.empty? && @boutonsTaille.empty?
                    next true
                end
                if @boutonsTaille.empty? && @boutonsDifficulte.include?(iter[4])
                    next true
                end
                if @boutonsTaille.include?(iter[3]) && @boutonsDifficulte.empty?
                    next true
                end
                if @boutonsTaille.include?(iter[3]) && @boutonsDifficulte.include?(iter[4])
                    next true
                end
                next false
            end
            if iter[1].downcase.include?(@entreeRecherche.text.downcase) && @entreeRecherche.text != ""
                if @boutonsDifficulte.empty? && @boutonsTaille.empty?
                    next true
                end
                if @boutonsTaille.empty? && @boutonsDifficulte.include?(iter[4])
                    next true
                end
                if @boutonsTaille.include?(iter[3]) && @boutonsDifficulte.empty?
                    next true
                end
                if @boutonsTaille.include?(iter[3]) && @boutonsDifficulte.include?(iter[4])
                    next true
                end
                next false
            end
        }

        view.set_model(@filtre)

        @boutonRetour = Button.new(:label => @controleur.getLangue[:retour])
        @boutonRetour.signal_connect('clicked') { onBtnRetourClicked }

		@bouton6x6.signal_connect('clicked') {
            @bouton6x6.active? ? @boutonsTaille << 6 : @boutonsTaille .delete(6)
            @filtre.refilter
        }

		@bouton8x8.signal_connect('clicked')  {
            @bouton8x8.active? ? @boutonsTaille  << 8 : @boutonsTaille .delete(8)
            @filtre.refilter
        }

		@bouton10x10.signal_connect('clicked') {
            @bouton10x10.active? ? @boutonsTaille  << 10 : @boutonsTaille .delete(10)
            @filtre.refilter
        }

		@bouton12x12.signal_connect('clicked') {
            @bouton12x12.active? ? @boutonsTaille  << 12 : @boutonsTaille .delete(12)
            @filtre.refilter
        }

        @boutonDiff1.signal_connect('clicked') {
            @boutonDiff1.active? ? @boutonsDifficulte << 1 : @boutonsDifficulte .delete(1)
            @filtre.refilter
        }

        @boutonDiff2.signal_connect('clicked') {
            @boutonDiff2.active? ? @boutonsDifficulte << 2 : @boutonsDifficulte.delete(2)
            @filtre.refilter
        }

        @boutonDiff3.signal_connect('clicked') {
            @boutonDiff3.active? ? @boutonsDifficulte << 3 : @boutonsDifficulte.delete(3)
            @filtre.refilter
        }

        @boutonDiff4.signal_connect('clicked') {
            @boutonDiff4.active? ? @boutonsDifficulte << 4 : @boutonsDifficulte.delete(4)
            @filtre.refilter
        }

        @boutonDiff5.signal_connect('clicked') {
            @boutonDiff5.active? ? @boutonsDifficulte << 5 : @boutonsDifficulte.delete(5)
            @filtre.refilter
        }

        @boutonDiff6.signal_connect('clicked') {
            @boutonDiff6.active? ? @boutonsDifficulte << 6 : @boutonsDifficulte.delete(6)
            @filtre.refilter
        }

        @boutonDiff7.signal_connect('clicked') {
            @boutonDiff7.active? ? @boutonsDifficulte << 7 : @boutonsDifficulte.delete(7)
            @filtre.refilter
        }


		vboxTaille = Box.new(:vertical, 10)
		vboxTaille.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		vboxTaille.add(labelTaille)
		vboxTaille.add(@bouton6x6)
		vboxTaille.add(@bouton8x8)
		vboxTaille.add(@bouton10x10)
		vboxTaille.add(@bouton12x12)
		vboxTaille.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hboxRecherche = Box.new(:horizontal,10)
        hboxRecherche.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxRecherche.add(labelRecherche)
        hboxRecherche.add(@entreeRecherche)
        hboxRecherche.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

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

		hboxRetour = Box.new(:horizontal)
        hboxRetour.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxRetour.add(@boutonRetour)
        hboxRetour.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxPrincipale = Box.new(:vertical, 20)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
		vboxPrincipale.add(labelDiff)
        vboxPrincipale.add(hboxDiff)
        vboxPrincipale.add(hboxClass)
        vboxPrincipale.add(hboxRecherche)
        vboxPrincipale.add(hboxRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)



        @entreeRecherche.signal_connect("key-release-event"){@filtre.refilter}

        @cadre.add(vboxPrincipale)
        self.actualiser()
    end

	def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
	end

	def onBtnTailleClicked(taille)
		@taille = taille
	end

	def onBtnDifficulteClicked(difficulte)
		@difficulte = difficulte
	end
end