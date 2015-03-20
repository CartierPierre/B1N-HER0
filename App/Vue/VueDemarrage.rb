require_relative 'Vue'

class VueDemarrage < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        vbox = Box.new(:vertical)
        hbox = Box.new(:horizontal)
        @buttonConnexion = Button.new(:label => "Connexion")
        @buttonInscription = Button.new(:label => "Inscription")
        hbox.add(@buttonConnexion)
        hbox.add(@buttonInscription)
        vbox.add(hbox)
        @fenetre.add(vbox)

        @buttonConnexion.signal_connect('clicked')  { onBtnConnexionClicked }
        @buttonInscription.signal_connect('clicked')  { onBtnInscriptionClicked }

        self.actualiser()



	def onBtnConnexionClicked
        @controleur.connexion()
	end

	def onBtnInscriptionClicked
        @controleur.inscription()
	end

    end
end