class VueMenuPrincipal < Vue

	@boutonJouer
	@boutonClassement
	@boutonOptions
	@boutonProfil
	@boutonQuitter

    def creerAlignBouton(box,bouton) 
        align = Alignment.new(0.5, 0, 0.6, 0)
        align.add(bouton)
        box.add(align)
    end

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)

		vbox = Box.new(:vertical, 20)

		@boutonJouer = Button.new(:label => "Jouer")
        @boutonJouer.set_size_request(100,40)
		@boutonClassement = Button.new(:label => "Classement")
        @boutonClassement.set_size_request(100,40)
		@boutonOptions = Button.new(:label => "Options")
        @boutonOptions.set_size_request(100,40)
		@boutonProfil = Button.new(:label => "Profil")
        @boutonProfil.set_size_request(100,40)
		@boutonQuitter = Button.new(:stock_id => Gtk::Stock::QUIT)
        @boutonQuitter.set_size_request(100,40)

        espaceDebut = Alignment.new(0, 0, 0, 0)
        vbox.pack_start(espaceDebut, :expand => true)

        creerAlignBouton(vbox,@boutonJouer)
        creerAlignBouton(vbox,@boutonClassement)
        creerAlignBouton(vbox,@boutonOptions)
        creerAlignBouton(vbox,@boutonProfil)
        creerAlignBouton(vbox,@boutonQuitter)

        espaceFin = Alignment.new(0, 0, 0, 0)
        vbox.pack_start(espaceFin, :expand => true)

        @cadre.add(vbox)

        @boutonJouer.signal_connect('clicked')  {onBtnJouerClicked}
        @boutonOptions.signal_connect('clicked')  {onBtnOptionsClicked}
        @boutonQuitter.signal_connect('clicked')  {Gtk.main_quit}
      
        self.actualiser()
	end
	
	def onBtnJouerClicked
        fermerCadre()
        @controleur.jouer()
	end

	def onBtnOptionsClicked
        fermerCadre()
		@controleur.options()
	end

end