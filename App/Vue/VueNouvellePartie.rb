class VueNouvellePartie < Vue

	@buttonJouer
	@buttonClassement
	@buttonOptions
	@buttonProfil
	@buttonQuitter

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)
		vbox = Box.new(:vertical)
		@buttonJouer = Button.new(:label => "Partie")
		@buttonAnnuler = Button.new(:stock_id => Stock::CANCEL)
		@buttonQuitter = Button.new(:stock_id => Gtk::Stock::QUIT)
        vbox.add(@buttonJouer)
        vbox.add(@buttonAnnuler)
        @cadre.add(vbox)

        @buttonJouer.signal_connect('clicked')  { onBtnJouerClicked }
        @buttonAnnuler.signal_connect('clicked')  { onBtnAnnulerClicked }
      
        self.actualiser()
	end
	
	def onBtnJouerClicked
        fermerCadre()
        @controleur.jouer
	end

	def onBtnAnnulerClicked
        fermerCadre()
        @controleur.annuler
	end



end