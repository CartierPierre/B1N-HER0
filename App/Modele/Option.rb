require_relative '../Vue/Langue'

##
# Classe Option
#
# Version 2
#
# Mettre les types de tuiles en constante de classe
#
class Option

	### Constante de classe
	
	TUILE_ROUGE = Gdk::Pixbuf.new(:file => './Ressources/CaseRouge32.png')
    TUILE_BLEUE = Gdk::Pixbuf.new(:file => './Ressources/CaseBleue32.png')
    TUILE_VERTE = Gdk::Pixbuf.new(:file => './Ressources/CaseVerte32.png')
    TUILE_JAUNE = Gdk::Pixbuf.new(:file => './Ressources/CaseJaune32.png')

    TUILE_ROUGE_LOCK = Gdk::Pixbuf.new(:file => './Ressources/CaseRouge32Lock.png')
    TUILE_BLEUE_LOCK = Gdk::Pixbuf.new(:file => './Ressources/CaseBleue32Lock.png')
    TUILE_VERTE_LOCK = Gdk::Pixbuf.new(:file => './Ressources/CaseVerte32Lock.png')
    TUILE_JAUNE_LOCK = Gdk::Pixbuf.new(:file => './Ressources/CaseJaune32Lock.png')

	### Attributs d'instances
	
    @imgTuile1
    @imgTuile2
    @imgTuileLock1
    @imgTuileLock2
    @langue
    
    attr_reader :langue, :imgTuile1, :imgTuile2, :imgTuileLock1, :imgTuileLock2
	
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
        @imgTuile1 = TUILE_ROUGE
        @imgTuile2 = TUILE_BLEUE
        @imgTuileLock1 = TUILE_ROUGE_LOCK
        @imgTuileLock2 = TUILE_BLEUE_LOCK
        @langue = Langue.new() 
    end
	
	### Méthodes d'instances
    
    def changerTuile1(couleur) # couleur est une tuile choisie par clic
        if( couleur == "Rouge" )
            @imgTuile1 = TUILE_ROUGE
            @imgTuileLock1 = TUILE_ROUGE_LOCK
        end
        if( couleur == "Bleue" )
            @imgTuile1 = TUILE_BLEUE
            @imgTuileLock1 = TUILE_BLEUE_LOCK
        end
        if( couleur == "Jaune" )
            @imgTuile1 = TUILE_JAUNE
            @imgTuileLock1 = TUILE_JAUNE_LOCK
        end
        if( couleur == "Verte" )
            @imgTuile1 = TUILE_VERTE
            @imgTuileLock1 = TUILE_VERTE_LOCK
        end
    end
    
    def changerTuile2(couleur) # couleur est une tuile choisie par clic
        if( couleur == "Rouge" )
            @imgTuile2 = TUILE_ROUGE
            @imgTuileLock2 = TUILE_ROUGE_LOCK
        end
        if( couleur == "Bleue" )
            @imgTuile2 = TUILE_BLEUE
            @imgTuileLock2 = TUILE_BLEUE_LOCK
        end
        if( couleur == "Jaune" )
            @imgTuile2 = TUILE_JAUNE
            @imgTuileLock2 = TUILE_JAUNE_LOCK
        end
        if( couleur == "Verte" )
            @imgTuile2 = TUILE_VERTE
            @imgTuileLock2 = TUILE_VERTE_LOCK
        end
    end

    def setLangueFr()
        @langue.setLangueFr()
    end

    def setLangueEn()
        @langue.setLangueEn()
    end
	
end
