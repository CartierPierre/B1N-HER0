##
# Classe Option
#
# Version 2
#
# Mettre les types de tuiles en constante de classe
#
class Option

	### Constante de classe
	
	TUILE_ROUGE = 'Vue/img/CaseRouge32.png'
    TUILE_BLEUE = 'Vue/img/CaseBleue32.png'
    TUILE_VERTE = 'Vue/img/CaseVerte32.png'
    TUILE_JAUNE = 'Vue/img/CaseJaune32.png'

	### Attributs d'instances
	
    @tuile1
    @tuile2
    @langue
    
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
        @tuile1 = Option.TUILE_BLEUE
        @tuile2 = Option.TUILE_ROUGE
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
