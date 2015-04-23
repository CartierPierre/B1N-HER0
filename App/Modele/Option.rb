##
# Classe Option
#
# Version 2
#
# Mettre les types de tuiles en constante de classe
#
class Option
	
	### Constante de classe
	
 #    IMG = [
	# 	Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseRouge32.png"),
 #        Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseBleue32.png"),
 #        Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseVerte32.png"),
 #        Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseJaune32.png")
	# ]
	
 #    IMG_LOCK = [
	# 	Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseRouge32Lock.png"),
 #        Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseBleue32Lock.png"),
 #        Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseVerte32Lock.png"),
 #        Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/CaseJaune32Lock.png")
	# ]

    IMG = [
      Gdk::Pixbuf.new(:file => "Ressources/CaseRouge32.png"),
        Gdk::Pixbuf.new(:file => "Ressources/CaseBleue32.png"),
        Gdk::Pixbuf.new(:file => "Ressources/CaseVerte32.png"),
        Gdk::Pixbuf.new(:file => "Ressources/CaseJaune32.png")
    ]
    
    IMG_LOCK = [
      Gdk::Pixbuf.new(:file => "Ressources/CaseRouge32Lock.png"),
        Gdk::Pixbuf.new(:file => "Ressources/CaseBleue32Lock.png"),
        Gdk::Pixbuf.new(:file => "Ressources/CaseVerte32Lock.png"),
        Gdk::Pixbuf.new(:file => "Ressources/CaseJaune32Lock.png")
    ]
	
    TUILE_ROUGE = 0
    TUILE_BLEUE = 1
    TUILE_VERTE = 2
    TUILE_JAUNE = 3
	
	### Attributs d'instances
	
    @imgTuile1
    @imgTuile2
    @imgTuileLock1
    @imgTuileLock2
    @langue
	
    @couleurTuile1
    @couleurTuile2
    
    attr_reader :langue, :imgTuile1, :imgTuile2, :imgTuileLock1, :imgTuileLock2, :couleurTuile1, :couleurTuile2
	
	### Méthodes de classe
	
	##
	# Constructeur
	#
    private_class_method :new
    def initialize(couleur1,couleur2,langue)
        @imgTuile1 = IMG[couleur1]
        @imgTuile2 = IMG[couleur2]
        @imgTuileLock1 = IMG_LOCK[couleur1]
        @imgTuileLock2 = IMG_LOCK[couleur2]
        @couleurTuile1 = couleur1
        @couleurTuile2 = couleur2
        @langue = Langue.new(langue) 
    end
	
	##
	# Instancie un object option
	#
    def Option.creer(couleur1,couleur2,langue)
        new(couleur1,couleur2,langue)
    end
	
	##
	# Sérialise un objet option
	#
	def Option.serialiser( option )
		return [ option.couleurTuile1, option.couleurTuile2, option.langue.langueConstante ].join(':')
	end
	
	##
	# Dé-sérialise un objet option
	#
	def Option.deserialiser( str )
		tab = str.split(':')
		return Option.creer( Integer(tab[0]), Integer(tab[1]), Integer(tab[2]) )
	end
	
	### Méthodes d'instances
    
    def changerTuile1(couleur) # couleur est une tuile choisie par clic
        @couleurTuile1 = couleur
        @imgTuile1 = IMG[couleur]
        @imgTuileLock1 = IMG_LOCK[couleur]
    end
    
    def changerTuile2(couleur) # couleur est une tuile choisie par clic
        @couleurTuile2 = couleur
        @imgTuile2 = IMG[couleur]
        @imgTuileLock2 = IMG_LOCK[couleur]
    end
	
    def setLangue(langue)
        @langue.setLangue(langue)
    end
	
end
