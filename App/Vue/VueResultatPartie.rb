class VueResultatPartie < Vue

    @boutonRetour

    def creerSucces(succes)
        hbox = Box.new(:horizontal, 10)
        hbox.override_background_color(0,Gdk::RGBA::new(0.85,0.85,0.85,1.0))
        vbox = Box.new(:vertical, 10)

        labelNom = Label.new()
        labelNom.set_markup("<big>" + succes.nom + "</big>")

        vbox.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vbox.add(labelNom)
        vbox.add(Label.new(succes.description))
        vbox.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        hbox.add(Image.new(:pixbuf => succes.image()))
        hbox.add(vbox)
        return hbox
    end

    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        vboxPrincipale = Box.new(:vertical, 20)

        @boutonRetour = Button.new(:label => @controleur.getLangue[:retournerMenuPrincipal])
        @boutonRetour.set_size_request(100,40)

        labelFelicitations = Label.new()
        labelFelicitations.set_markup("<big>" + @controleur.getLangue[:felicitations] + @modele.grille.taille.to_i.to_s + "x" + @modele.grille.taille.to_i.to_s + @controleur.getLangue[:felicitations2] + @modele.niveau.difficulte.to_s + "</big>")

        labelScore = Label.new()
        labelScore.set_markup("<big>" + @controleur.getLangue[:score] + " : " + @modele.score.nbPoints(@modele.niveau).to_s + "</big>")

        labelTemps = Label.new()
        labelTemps.set_markup("<big>" + @controleur.getLangue[:temps] + " : " + @modele.chrono.to_s + "</big>")

        labelNbCoups = Label.new()
        labelNbCoups.set_markup("<big>" + @controleur.getLangue[:nbCoups] + " : " + @modele.nbCoups.to_s + "</big>")

        labelConseils = Label.new()
        labelConseils.set_markup("<big>" + @controleur.getLangue[:nbConseils] + " : " + @modele.nbConseils.to_s + "</big>")

        labelAides = Label.new()
        labelAides.set_markup("<big>" + @controleur.getLangue[:nbAides] + " : " + @modele.nbAides.to_s + "</big>")

        hboxSucces = Box.new(:horizontal, 30)
        hboxSucces.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxSucces.add(creerSucces(Succes::S_10_PARTIES))
        hboxSucces.add(creerSucces(Succes::S_10_PARFAIT))
        hboxSucces.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(labelFelicitations)
        vboxPrincipale.add(labelScore)
        vboxPrincipale.add(labelTemps)
        vboxPrincipale.add(labelNbCoups)
        vboxPrincipale.add(labelConseils)
        vboxPrincipale.add(labelAides)
        vboxPrincipale.add(hboxSucces)
        creerAlignBouton(vboxPrincipale,@boutonRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)

        @boutonRetour.signal_connect('clicked') { onBtnRetourClicked }
      
        self.actualiser()
    end
    
    def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
    end

end