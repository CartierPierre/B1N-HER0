require_relative 'Vue'

class VueDemarrage < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        vbox = Box.new(:vertical)
        hbox = Box.new(:horizontal)

        buttonConnexion = Button.new(:label => "Connexion")
        buttonInscription = Button.new(:label => "Inscription")
        buttonJeu = Button.new(:label => "Test jeu")

        hbox.add(buttonConnexion)
        hbox.add(buttonInscription)
        hbox.add(buttonJeu)
        vbox.add(hbox)
        @fenetre.add(vbox)

        buttonConnexion.signal_connect('clicked')  { onBtnConnexionClicked }
        buttonInscription.signal_connect('clicked')  { onBtnInscriptionClicked }
        buttonJeu.signal_connect('clicked')  { onBtnJeuClicked }

        self.actualiser()
    end

	def onBtnConnexionClicked
        @controleur.connexion()
	end

	def onBtnInscriptionClicked
        @controleur.inscription()
	end

    def onBtnJeuClicked
        @controleur.jeu()
    end

end