require_relative 'Vue'

class VueDemarrage < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        vbox = Box.new(:vertical)
        hbox = Box.new(:horizontal)

        buttonConnexion = Button.new(:label => "Connexion")
        buttonInscription = Button.new(:label => "Inscription")
        buttonJeu = Button.new(:label => "Test jeu")

        pixbufHero = Gdk::Pixbuf.new(:file => './Ressources/Hero.png', :width => 400, :height => 400)
        pixbufTitre = Gdk::Pixbuf.new(:file => './Ressources/Titre.png')

        imgHero = Image.new(:pixbuf => pixbufHero)
        imgTitre = Image.new(:pixbuf => pixbufTitre)

        vbox.add(imgTitre)
        vbox.add(buttonConnexion)
        vbox.add(buttonInscription)
        vbox.add(buttonJeu)

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
        fermerCadre()
        @controleur.jeu()
    end

end