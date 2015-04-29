class VueResultatPartie < Vue

    ### Attribut d'instance

    @boutonRetour

    ##
    # Méthode qui permet de creer une box horizontale contenant l'image du succès à gauche
    # et le titre ainsi que sa description à droite
    #
    # Paramètre::
    #   * _succes_ - Constante de la classe Succes
    #
    # Retour::
    #   La nouvelle box horizontale
    #
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

    ##
    # Méthode de création de la vue qui affiche le résultat de la partie une fois la grille validée
    #
    # Paramètres::
    #   * _modele_ - Modèle associé
    #   * _titre_ - Titre de la fenetre
    #   * _controleur_ - Controleur associé 
    #
    def initialize(modele,titre,controleur)
        super(modele,titre,controleur)

        vboxPrincipale = Box.new(:vertical, 20)

        @boutonRetour = Button.new(:label => @controleur.getLangue[:retournerMenuPrincipal])
        @boutonRetour.set_size_request(100,40)
        @boutonRetour.signal_connect('clicked') { onBtnRetourClicked }

        labelFelicitations = creerLabelTailleGrosse(@controleur.getLangue[:felicitations] + @modele.grille.taille.to_i.to_s + "x" + @modele.grille.taille.to_i.to_s + @controleur.getLangue[:felicitations2] + @modele.niveau.difficulte.to_s)

        labelScore = creerLabelTailleMoyenne(@controleur.getLangue[:score] + " : " + @controleur.score.nbPoints(@modele.niveau).to_s)
        labelTemps = creerLabelTailleMoyenne(@controleur.getLangue[:temps] + " : " + @modele.chrono.to_s)
        labelNbCoups = creerLabelTailleMoyenne(@controleur.getLangue[:nbCoups] + " : " + @modele.nbCoups.to_s)
        labelConseils = creerLabelTailleMoyenne(@controleur.getLangue[:nbConseils] + " : " + @modele.nbConseils.to_s)
        labelAides = creerLabelTailleMoyenne(@controleur.getLangue[:nbAides] + " : " + @modele.nbAides.to_s)
        labelClassement = creerLabelTailleMoyenne(@controleur.getLangue[:classement])

        # Ajout des succès dévérouillés
        vboxSucces = Box.new(:vertical, 20)

        if(@controleur.succes && @controleur.succes.size > 0)
            vboxSucces.add(creerLabelTailleGrosse(@controleur.getLangue[:succesDeverrouille]))

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

        # Classement du niveau
        scores = @controleur.getClassement()

        fenetreScrollClassement = ScrolledWindow.new()
        fenetreScrollClassement.set_policy(:never,:automatic)
        fenetreScrollClassement.set_size_request(300,200)

        liste = ListStore.new(Integer,String,Integer)
        renderer = CellRendererText.new()

        colonneRang = Gtk::TreeViewColumn.new(@controleur.getLangue[:rang],renderer,:text => 0)
        colonneRang.sort_indicator = true
        colonneRang.sort_column_id = 0
        colonneRang.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonnePseudo = Gtk::TreeViewColumn.new(@controleur.getLangue[:pseudo],renderer,:text => 1)
        colonnePseudo.sort_indicator = true
        colonnePseudo.sort_column_id = 1
        colonnePseudo.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        colonneScore = Gtk::TreeViewColumn.new(@controleur.getLangue[:score],renderer,:text => 2)
        colonneScore.sort_indicator = true
        colonneScore.sort_column_id = 2
        colonneScore.signal_connect('clicked') do |x|
            x.sort_order =
            x.sort_order == :ascending ? :descending : :ascending
        end

        view = TreeView.new(liste)
        view.append_column(colonneRang)
        view.append_column(colonnePseudo)
        view.append_column(colonneScore)
        fenetreScrollClassement.add_with_viewport(view)

        scores.each do |x|
            iter = liste.append
            iter[0] = 0
            iter[1] = x["pseudo"]
            iter[2] = x["points"]
        end

        liste.set_sort_column_id(2, :descending)

        increment = 1
        liste.each do |model, path, iter|
            iter[0] = increment
            increment =increment + 1
        end

        hboxClassement = Box.new(:horizontal, 10)
        hboxClassement.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        hboxClassement.add(fenetreScrollClassement)
        hboxClassement.pack_end(Alignment.new(0, 0, 0, 0), :expand => true)

        # Ajout dans la vbox principale
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)
        vboxPrincipale.add(labelFelicitations)
        vboxPrincipale.add(labelScore)
        vboxPrincipale.add(labelTemps)
        vboxPrincipale.add(labelNbCoups)
        vboxPrincipale.add(labelConseils)
        vboxPrincipale.add(labelAides)
        vboxPrincipale.add(vboxSucces)
        vboxPrincipale.add(labelClassement)
        vboxPrincipale.add(hboxClassement)
        creerAlignBouton(vboxPrincipale,@boutonRetour)
        vboxPrincipale.pack_start(Alignment.new(0, 0, 0, 0), :expand => true)

        @cadre.add(vboxPrincipale)      
        self.actualiser()
    end
    
    ##
    # Listener sur le bouton retour
    # Ferme le cadre et retourne au menu principal
    #
    def onBtnRetourClicked
        fermerCadre()
        @controleur.retour()
    end

end