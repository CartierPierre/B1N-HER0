class VueMenuPrincipal < Vue

	@buttonJouer
	@buttonClassement
	@buttonOptions
	@buttonProfil
	@buttonQuitter

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)
		vbox = Box.new(:vertical)
		@buttonJouer = Button.new(:label => "Jouer")
		@buttonClassement = Button.new(:label => "Classement")
		@buttonOptions = Button.new(:label => "Options")
		@buttonProfil = Button.new(:label => "Profil")
		@buttonQuitter = Button.new(:stock_id => Gtk::Stock::QUIT)
        vbox.add(@buttonJouer)
        vbox.add(@buttonClassement)
        vbox.add(@buttonOptions)
        vbox.add(@buttonProfil)
        vbox.add(@buttonQuitter)
        @fenetre.add(vbox)

        @buttonJouer.signal_connect('clicked')  { onBtnJouerClicked }
        @buttonOptions.signal_connect('clicked')  { onBtnOptionsClicked }
        @buttonQuitter.signal_connect('clicked')  { Gtk.main_quit }
      
        self.actualiser()
	end
	
	def onBtnJouerClicked
        @controleur.jouer()
	end

	def onBtnOptionsClicked
		@controleur.options()
	end

end