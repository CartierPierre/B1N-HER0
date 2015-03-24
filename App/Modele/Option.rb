class Option
    @tuile0 #chemin du fichier en string
    @tuile1
    @langue
    @tuileRouge='Vue/img/CaseRouge32.png'
    @tuileBleue='Vue/img/CaseBleue32.png'
    @tuileVerte='Vue/img/CaseVerte32.png'
    @tuileJaune='Vue/img/CaseJaune32.png'
    
    attr_accessor :tuile0, :tuile1, :langue
    
    private_class_method :new
    
    
    def Option.creer()
        new()
    end
    
    def initialize()
        @tuile0=@tuileBleue
        @tuile1=@tuileRouge
        #@langue='Vue/img/langue.lang'
    end
    
    def changerTuile0(couleur)# couleur est une tuile choisie par clic
        if(couleur==@tuile1)
            #gerer l'affichage de l'erreur de meme couleur
        else
            @tuile0=couleur
        end
    end
    
    def changerTuile1(couleur)# couleur est une tuile choisie par clic
        if(couleur==@tuile0)
            #gerer l'affichage de l'erreur de meme couleur
        else
            @tuile1=couleur
        end
    end
end
