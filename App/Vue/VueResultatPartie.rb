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
        labelScore.set_markup("<big>" + @controleur.getLangue[:score] + " : " + @controleur.score.nbPoints(@modele.niveau).to_s + "</big>")

        labelTemps = Label.new()
        labelTemps.set_markup("<big>" + @controleur.getLangue[:temps] + " : " + @modele.chrono.to_s + "</big>")

        labelNbCoups = Label.new()
        labelNbCoups.set_markup("<big>" + @controleur.getLangue[:nbCoups] + " : " + @modele.nbCoups.to_s + "</big>")

        labelConseils = Label.new()
        labelConseils.set_markup("<big>" + @controleur.getLangue[:nbConseils] + " : " + @modele.nbConseils.to_s + "</big>")

        labelAides = Label.new()
        labelAides.set_markup("<big>" + @controleur.getLangue[:nbAides] + " : " + @modele.nbAides.to_s + "</big>")

        # Ajout des succès dévérouillés
        vboxSucces = Box.new(:vertical, 20)

        if(@controleur.succes && @controleur.succes.size > 0)
            labelSucces = Label.new()
            labelSucces.set_markup("<big>" + @controleur.getLangue[:succesDeverrouille] + "</big>")
            vboxSucces.add(labelSucces)

            # Affichage de 2 succès par ligne
            hbox = Box.new(:horizontal, 30)

            0.upto(@controleur.succes.size-1) do |i|
                if(i%2 == 0) # Pair
                    hbox = Box.new(:horizontal, 30)
                    hbox.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
                    hbox.add(creerSucces(@controleur.succes[i]))
                    hbox.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)
                    vboxSucces.add(hbox)
                else # Impair
                    hbox.add(creerSucces(@controleur.succes[i]))                    
                end
            end
        end

        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(labelFelicitations)
        vboxPrincipale.add(labelScore)
        vboxPrincipale.add(labelTemps)
        vboxPrincipale.add(labelNbCoups)
        vboxPrincipale.add(labelConseils)
        vboxPrincipale.add(labelAides)
        vboxPrincipale.add(vboxSucces)
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