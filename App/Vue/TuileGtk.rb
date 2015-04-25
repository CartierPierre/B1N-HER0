class TuileGtk < Gtk::Button
    
    ### Attributs d'instances

    @controleur

    attr_accessor :x, :y

    ##
    # Méthode de création d'une tuile GTK qui correspond à une tuile de la grille dans l'interface graphique
    #
    # Paramètres::
    #   * _x_ - Coordonnée en x de la tuile
    #   * _y_ - Coordonnée en y de la tuile
    #   * _controleur_ - Controleur associé 
    #
    def initialize(x,y,controleur)
        super()
        @x,@y = x,y
        @controleur = controleur
        self.set_size_request(20, 20)
        self.set_border_width(0)
    end

    ##
    # Actualise l'image de la tuile en fonction de l'état passé en paramètre
    #
    # Paramètre::
    #   * _etat_ - Nouvel état de la tuile
    #
    def setImageTuile(etat)
        if (etat == Etat.etat_1)
            image = Image.new(:pixbuf => @controleur.getImgTuile1)
        elsif (etat == Etat.etat_2)
            image = Image.new(:pixbuf => @controleur.getImgTuile2)
        elsif (etat == Etat.lock_1)
            image = Image.new(:pixbuf => @controleur.getImgTuileLock1)
        elsif (etat == Etat.lock_2)
            image = Image.new(:pixbuf => @controleur.getImgTuileLock2)
        else
            image = Image.new()
        end 

        # En mode hypothèse, les images sont moins opaques.
        if(@controleur.getModeHypotheseActif)
            image.set_opacity(0.5)
        end  
         
        self.set_image(image)
    end
end