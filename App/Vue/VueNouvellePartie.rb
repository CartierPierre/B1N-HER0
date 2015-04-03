class VueNouvellePartie < Vue

	@button6x6
	@button8x8
	@button10x10
	@button12x12

	@buttonAnnuler

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)
		vboxPrincipale = Box.new(:vertical)

		vboxPrincipale.add(Label.new("Taille de la grille"))

		# Boutons taille de la grille
		hboxTaille = Box.new(:horizontal)
		@button6x6 = Button.new(:label => "6x6")
		@button8x8 = Button.new(:label => "8x8")
		@button10x10 = Button.new(:label => "10x10")
		@button12x12 = Button.new(:label => "12x12")

		hboxTaille.add(@button6x6)
		hboxTaille.add(@button8x8)
		hboxTaille.add(@button10x10)
		hboxTaille.add(@button12x12)

		vboxPrincipale.add(hboxTaille)

		@buttonAnnuler = Button.new(:stock_id => Gtk::Stock::CANCEL)
		vboxPrincipale.add(@buttonAnnuler)
        @buttonAnnuler.signal_connect('clicked')  { onBtnAnnulerClicked }
      
      	@cadre.add(vboxPrincipale)
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