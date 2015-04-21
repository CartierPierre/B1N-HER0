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

		vboxPrincipale = Box.new(:vertical, 20)

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

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        creerAlignBouton(vboxPrincipale,@boutonNouvellePartie)
        creerAlignBouton(vboxPrincipale,@boutonChargerPartie)
        creerAlignBouton(vboxPrincipale,@boutonClassement)
        creerAlignBouton(vboxPrincipale,@boutonOptions)
        creerAlignBouton(vboxPrincipale,@boutonProfil)
        creerAlignBouton(vboxPrincipale,@boutonCredits)
        creerAlignBouton(vboxPrincipale,@boutonQuitter)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)

        @boutonNouvellePartie.signal_connect('clicked') { onBtnNouvellePartieClicked }
        @boutonChargerPartie.signal_connect('clicked') { onBtnChargerPartieClicked }
        @boutonOptions.signal_connect('clicked') { onBtnOptionsClicked }
        @boutonClassement.signal_connect('clicked') { onBtnClassementClicked }
        @boutonProfil.signal_connect('clicked') { onBtnProfilClicked }        
        @boutonCredits.signal_connect('clicked') { onBtnCreditsClicked }
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