class Option
    @tuile1 #chemin du fichier en string
    @tuile2
    @langue
    @tuileRouge='Vue/img/CaseRouge32.png'
    @tuileBleue='Vue/img/CaseBleue32.png'
    @tuileVerte='Vue/img/CaseVerte32.png'
    @tuileJaune='Vue/img/CaseJaune32.png'
    
    attr_reader :langue
    
    private_class_method :new
    
    def Option.creer()
        new()
    end
    
    def initialize()
        @tuile1=@tuileBleue
        @tuile2=@tuileRouge
        @langue = Langue.new() 
    end
    
    #Deuxieme constructeur si on charge le profil
    
    def changerTuile1(couleur)# couleur est une tuile choisie par clic
        if(couleur==@tuile2)
            #gerer l'affichage de l'erreur de meme couleur
        else
            @tuile1=couleur
        end
    end
    
    def changerTuile2(couleur)# couleur est une tuile choisie par clic
        if(couleur==@tuile1)
            #gerer l'affichage de l'erreur de meme couleur
        else
            @tuile2=couleur
        end
    end

    def setLangueFr()
        @langue.setLangueFr()
    end

    def setLangueEn()
        @langue.setLangueEn()
    end
end
