require_relative 'Vue'



class VueDemarrage < Vue

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        vbox = Box.new(:vertical)
        hbox = Box.new(:horizontal)

        buttonConnexion = Button.new(:label => "Connexion")
        buttonInscription = Button.new(:label => "Inscription")

        pixbufHero = Gdk::Pixbuf.new(:file => './Ressources/Hero.png', :width => 400, :height => 400)
        pixbufTitre = Gdk::Pixbuf.new(:file => './Ressources/Titre.png')

        imgHero = Image.new(:pixbuf => pixbufHero)
        imgTitre = Image.new(:pixbuf => pixbufTitre)

        vbox.add(imgTitre)
        vbox.add(buttonConnexion)
        vbox.add(buttonInscription)
        vbox.set_homogeneous(true);

        hbox.add(imgHero)
        hbox.add(vbox)

        @cadre.override_background_color(:normal,Gdk::RGBA::new(1, 1, 1, 1))
        @cadre.add(hbox)

        buttonConnexion.signal_connect('clicked')  {onBtnConnexionClicked}
        buttonInscription.signal_connect('clicked')  {onBtnInscriptionClicked}

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

end