##
# Classe Succes
#
# Version 2
#
class Succes
	
	### Attributs d'instances
	
	# String
	# Nom du succès
	@nom
	
	# String
	# Description du succès
	@description
	
	# GTK image
	# Image du succès
	@image
	
	attr_reader :nom, :description, :image
	### Méthode de classe
	
	##
	# Constructeur
	#
	def initialize( nom, description, image )
		@nom, @description, @image = nom, description, image
	end
	private_class_method :new
	
	##
	# Instancie un succès
	#
	def Succes.creer( nom, description, image )
		new( nom, description, image )
	end
	
	### Constantes de classe
	
	# S_10_PARTIES = Succes.creer( "Débutant", "Terminer avec succès 10 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_10_PARTIES.png") )
	# S_50_PARTIES = Succes.creer( "Petit joueur", "Terminer avec succès 50 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_50_PARTIES.png") )
	# S_100_PARTIES = Succes.creer( "Initié", "Terminer avec succès 100 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_100_PARTIES.png") )
	# S_500_PARTIES = Succes.creer( "Joueur invétéré", "Terminer avec succès 500 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_500_PARTIES.png"))
	# S_1000_PARTIES = Succes.creer( "Hardcore gamer", "Terminer avec succès 1000 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_1000_PARTIES.png") )
	
	# S_10_PARFAIT = Succes.creer( "La chance du débutant", "Terminer sans aides ni conseils 10 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_10_PARFAIT.png") )
	# S_50_PARFAIT = Succes.creer( "Trop facile", "Terminer sans aides ni conseils 50 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_50_PARFAIT.png") )
	# S_100_PARFAIT = Succes.creer( "Sage", "Terminer sans aides ni conseils 100 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_100_PARFAIT.png") )
	# S_500_PARFAIT = Succes.creer( "Calculateur", "Terminer sans aides ni conseils 500 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_500_PARFAIT.png") )
	# S_1000_PARFAIT = Succes.creer( "Devin", "Terminer sans aides ni conseils 1000 grilles.", Gdk::Pixbuf.new(:file => File.dirname(__FILE__) + "/../Ressources/S_1000_PARFAIT.png") )

	S_10_PARTIES = Succes.creer( "Débutant", "Terminer avec succès 10 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_10_PARTIES.png") )
	S_50_PARTIES = Succes.creer( "Petit joueur", "Terminer avec succès 50 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_50_PARTIES.png") )
	S_100_PARTIES = Succes.creer( "Initié", "Terminer avec succès 100 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_100_PARTIES.png") )
	S_500_PARTIES = Succes.creer( "Joueur invétéré", "Terminer avec succès 500 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_500_PARTIES.png"))
	S_1000_PARTIES = Succes.creer( "Hardcore gamer", "Terminer avec succès 1000 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_1000_PARTIES.png") )
	
	S_10_PARFAIT = Succes.creer( "La chance du débutant", "Terminer sans aides ni conseils 10 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_10_PARFAIT.png") )
	S_50_PARFAIT = Succes.creer( "Trop facile", "Terminer sans aides ni conseils 50 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_50_PARFAIT.png") )
	S_100_PARFAIT = Succes.creer( "Sage", "Terminer sans aides ni conseils 100 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_100_PARFAIT.png") )
	S_500_PARFAIT = Succes.creer( "Calculateur", "Terminer sans aides ni conseils 500 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_500_PARFAIT.png") )
	S_1000_PARFAIT = Succes.creer( "Devin", "Terminer sans aides ni conseils 1000 grilles.", Gdk::Pixbuf.new(:file => "Ressources/S_1000_PARFAIT.png") )

end
