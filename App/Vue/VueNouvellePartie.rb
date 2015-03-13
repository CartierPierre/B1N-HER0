require_relative 'Vue.rb'
require_relative '../Modele/Grille'

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
		@buttonQuitter = Button.new(:stock_id => Gtk::Stock::QUIT)
        vbox.add(@buttonJouer)
        @fenetre.add(vbox)

      
        self.actualiser()
	end
	
	def onBtnJouerClicked 
	  @controleur.jouer
	end



end