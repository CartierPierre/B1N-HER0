require_relative 'Vue'



class VueDemarrage < Vue

    ##
    # Méthode de création de la vue du menu de démarrage qui est le premier écran du jeu
    #
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé
    #
    def initialize(modele,titre,controleur)     #:notnew:
        super(modele,titre,controleur)


        buttonConnexion = Button.new(:label => @controleur.getLangue[:connexion])
        buttonInscription = Button.new(:label => @controleur.getLangue[:inscription])

        pixbufHero = Gdk::Pixbuf.new(:file => "Ressources/Hero.png", :width => 400, :height => 400)
        pixbufTitre = Gdk::Pixbuf.new(:file => "Ressources/Titre.png")

        imgHero = Image.new(:pixbuf => pixbufHero)
        imgTitre = Image.new(:pixbuf => pixbufTitre)

        vbox = Box.new(:vertical)
        vbox.add(imgTitre)
        vbox.add(buttonConnexion)
        vbox.add(buttonInscription)
        vbox.set_homogeneous(true);

        hbox = Box.new(:horizontal)
        hbox.add(imgHero)
        hbox.add(vbox)

        @cadre.override_background_color(:normal,Gdk::RGBA::new(1, 1, 1, 1))
        @cadre.add(hbox)


        buttonConnexion.signal_connect('clicked')  {onBtnConnexionClicked}
        buttonInscription.signal_connect('clicked')  {onBtnInscriptionClicked}

        self.actualiser()
    end

    ##
    # Méthode de connexion
    #
	def onBtnConnexionClicked
        fermerCadre()
        @controleur.connexion()
	end

    ##
    # Méthode d'inscription
    #
	def onBtnInscriptionClicked
        fermerCadre()
        @controleur.inscription()
	end

end