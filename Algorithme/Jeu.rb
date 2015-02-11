# encoding: UTF-8

##
# Auteur TIANQI WEI
# Version 0.1 : Date : Wed Feb 11 17:38:56 CET 2015
#

class Jeu

	# Création des objets de la classe Jeu
	#
	#	 A) S'il y a des paramètres à fournir à la création
	#		 - rendre new privée
	#		 - Ecrire une Méthode de classe de création d'instance avec un nom significatif
	#		 - Ecrire la Méthode d'instance d'initialisation
	#
	#	 B) S'il n'y a pas de paramètre à fournir à la création
	#		 - Ecrire SI BESOIN la Méthode d'instance d'initialisation
	@nbL
	@nbC
	@mat

	attr_accessor :nbL, :nbC
	def initialize(ligne,colonne) 
		@nbL = ligne
		@nbC = colonne
		@mat = Array.new(@nbL) { Array.new(@nbC,0) }
	end

	def Jeu.creer(l,c)
		new(l,c)
	end
	private_class_method :new

	def to_s
		puts "Voici le takuzu de #{@nbL}*#{@nbC}: "
		0.upto(@nbL - 1) do |i|
			0.upto(@nbC - 1) do |j|
				if @mat[i][j] == 1
					print "1"
				elsif @mat[i][j] == 2
					print "2"
				else
					print "0"
				end
			end
			print "\n"
		end
		print "\n"
	end

	def mettreRouge(i,j)
		@mat[i][j] = 1
	end

	def mettreBleu(i,j)
		@mat[i][j] = 2
	end


	def estOccupe?(i,j)
		if(@mat[i][j] == 1 || @mat[i][j] == 2)
			return true
		else
			return false
		end
	end


end # Marqueur de fin de classe
