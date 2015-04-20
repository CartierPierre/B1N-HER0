class VueMenuPrincipal < Vue

	@boutonNouvellePartie
    @boutonChargerPartie
	@boutonClassement
	@boutonOptions
	@boutonProfil
    @boutonCredits
	@boutonQuitter

	def initialize(modele,titre,controleur)
		super(modele,titre,controleur)

		vbox = Box.new(:vertical, 20)

		@boutonNouvellePartie = Button.new(:label => @controleur.getLangue[:nouvellePartie])
        @boutonNouvellePartie.set_size_request(100,35)
        @boutonChargerPartie = Button.new(:label => @controleur.getLangue[:chargerPartie])
        @boutonChargerPartie.set_size_request(100,35)
		@boutonClassement = Button.new(:label => @controleur.getLangue[:classement])
        @boutonClassement.set_size_request(100,35)
		@boutonOptions = Button.new(:label => @controleur.getLangue[:options])
        @boutonOptions.set_size_request(100,35)
		@boutonProfil = Button.new(:label => @controleur.getLangue[:profil])
        @boutonProfil.set_size_request(100,35)
        @boutonCredits = Button.new(:label => @controleur.getLangue[:credits])
        @boutonCredits.set_size_request(100,35)
		@boutonQuitter = Button.new(:label => @controleur.getLangue[:quitter])
        @boutonQuitter.set_size_request(100,35)

        espaceDebut = Alignment.new(0, 0, 0, 0)
        vbox.pack_start(espaceDebut, :expand => true)

        creerAlignBouton(vbox,@boutonNouvellePartie)
        creerAlignBouton(vbox,@boutonChargerPartie)
        creerAlignBouton(vbox,@boutonClassement)
        creerAlignBouton(vbox,@boutonOptions)
        creerAlignBouton(vbox,@boutonProfil)
        creerAlignBouton(vbox,@boutonCredits)
        creerAlignBouton(vbox,@boutonQuitter)

        espaceFin = Alignment.new(0, 0, 0, 0)
        vbox.pack_start(espaceFin, :expand => true)

        @cadre.add(vbox)

        @boutonNouvellePartie.signal_connect('clicked') { onBtnNouvellePartieClicked }
        @boutonChargerPartie.signal_connect('clicked') { onBtnChargerPartieClicked }
        @boutonOptions.signal_connect('clicked') { onBtnOptionsClicked }
        @boutonCredits.signal_connect('clicked') { onBtnCreditsClicked }
        @boutonClassement.signal_connect('clicked') { onBtnClassementClicked }
        @boutonProfil.signal_connect('clicked') { onBtnProfilClicked }
        @boutonQuitter.signal_connect('clicked') { Gtk.main_quit }
      
        self.actualiser()
	end
	
	def onBtnNouvellePartieClicked
        fermerCadre()
        @controleur.nouvellePartie()
	end

    def onBtnChargerPartieClicked
        fermerCadre()
        @controleur.chargerPartie()
    end

	def onBtnOptionsClicked
        fermerCadre()
		@controleur.options()
	end

    def onBtnCreditsClicked
        fermerCadre()
        @controleur.credits()
    end

	def onBtnProfilClicked
        fermerCadre()
		@controleur.profil()
	end

    def onBtnClassementClicked
        fermerCadre()
        @controleur.classement()
    end

end