##
# Classe Option
#
# Version 2
#
# Mettre les types de tuiles en constante de classe
#
class Option

	### Attributs d'instances
	
    @tuile1 #chemin du fichier en string
    @tuile2
    @langue
    @tuileRouge = 'Vue/img/CaseRouge32.png'
    @tuileBleue = 'Vue/img/CaseBleue32.png'
    @tuileVerte = 'Vue/img/CaseVerte32.png'
    @tuileJaune = 'Vue/img/CaseJaune32.png'
    
    attr_reader :langue
	
	### Méthodes de classe
    
	##
	# Instancie un object option
	#
    def Option.creer()
        new()
    end
	
	##
	# Constructeur
	#
    private_class_method :new
    def initialize()
        @tuile1 = @tuileBleue
        @tuile2 = @tuileRouge
        @langue = Langue.new() 
    end
	
	### Méthodes d'instances
    
    def changerTuile1(couleur) # couleur est une tuile choisie par clic
        if( couleur==@tuile2 )
            # gerer l'affichage de l'erreur de meme couleur
        else
            @tuile1 = couleur
        end
    end
    
    def changerTuile2(couleur) # couleur est une tuile choisie par clic
        if( couleur==@tuile1 )
            # gerer l'affichage de l'erreur de meme couleur
        else
            @tuile2 = couleur
        end
    end

    def setLangueFr()
        @langue.setLangueFr()
    end

    def setLangueEn()
        @langue.setLangueEn()
    end
	
end
