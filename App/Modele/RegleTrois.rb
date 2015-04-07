#Règle 3: 2 lignes ou 2 colonnes ne peuvent être identiques.

load 'Grille.rb'
load "Partie.rb"

class RegleTrois
		
    private_class_method :new
    	
    def RegleTrois.creer()
        new()
    end
    	
    def initialize()
    	new()
    end
    
    def RegleTrois.appliquer(partie)
    	#Pour chaque ligne
    	0.upto Math.sqrt(partie.grille().taille() - 1) do |x|
			x.upto Math.sqrt(partie.grille().taille() - 1) do |z|
				if !((partie.grille.getLigne(x) & partie.grille.getLigne(z)).empty?) && (partie.grille.getLigne(x) & partie.grille.getLigne(z)).size == partie.grille().taille()
					#si il y a intersection entre deux ligne et la taille d'intersection est égale à la taille de ligne
		    			return false
    			end
    		end
    	end
    	#Pour chaque colonne
    	0.upto Math.sqrt(partie.grille().taille() - 1) do |y|
			x.upto Math.sqrt(partie.grille().taille() - 1) do |z|
				if !((partie.grille.getColonne(y) & partie.grille.getColonne(z)).empty?) && (partie.grille.getColonne(y) & partie.grille.getColonne(z)).size == partie.grille().taille()
				#si il y a intersection entre deux colonne et la taille d'intersection est égale à la taille de colonne	
		    			return false
    			end
    		end
    	end
    	return true
    end
end				
    			
    			
    	
