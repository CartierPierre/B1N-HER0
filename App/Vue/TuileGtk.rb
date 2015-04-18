class TuileGtk < Gtk::Button
    attr_accessor :x, :y

    @controleur

    def initialize(x,y,controleur)
        super()
        @x,@y = x,y
        @controleur = controleur
        self.set_size_request(20, 20)
        self.set_border_width(0)
    end

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

        if(@controleur.getModeHypotheseActif)
            image.set_opacity(0.5)
        end   
        self.set_image(image)
    end
end