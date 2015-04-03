class VueNouvellePartie < Vue

	@button6x6
	@button8x8
	@button10x10
	@button12x12

	@buttonAnnuler

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)
		vboxPrincipale = Box.new(:vertical)

		# Boutons taille de la grille
		hboxTaille = Box.new(:horizontal)



		@buttonAnnuler = Button.new(:stock_id => Gtk::Stock::CANCEL)
		vboxPrincipale.add(@buttonAnnuler)
        @buttonAnnuler.signal_connect('clicked')  { onBtnAnnulerClicked }
      
      	@cadre.add(vboxPrincipale)
        self.actualiser()
	end

	def onBtnAnnulerClicked
	  @controleur.annuler
	end

end