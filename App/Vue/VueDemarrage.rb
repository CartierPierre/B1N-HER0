require_relative 'Vue'

class VueDemarrage < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)
        vbox = Box.new(:vertical)
        hbox = Box.new(:horizontal)

        buttonConnexion = Button.new(:label => "Connexion")
        buttonInscription = Button.new(:label => "Inscription")
        buttonJeu = Button.new(:label => "Test jeu")

        vbox.add(buttonConnexion)
        vbox.add(buttonInscription)
        vbox.add(buttonJeu)
        pb = Gdk::Pixbuf.new(:file => './Vue/img/Hero.png', :width => 400, :height => 400)
        imgHero = Image.new(:pixbuf => pb)
        #imgHero.scale(50,50)
        hbox.add(imgHero)
        hbox.add(vbox)
        @cadre.add(hbox)

        buttonConnexion.signal_connect('clicked')  {onBtnConnexionClicked}
        buttonInscription.signal_connect('clicked')  {onBtnInscriptionClicked}
        buttonJeu.signal_connect('clicked')  {onBtnJeuClicked}

        self.actualiser()
    end

	def onBtnConnexionClicked
        fermerCadre()
        @controleur.connexion()
	end

	def onBtnInscriptionClicked
        fermerCadre()
        @controleur.inscription()
	end

    def onBtnJeuClicked
        @controleur.jeu()
    end

end