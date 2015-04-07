#Règle 3: 2 lignes ou 2 colonnes ne peuvent être identiques.
#pas fini

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
    	#Pour la ligne
    	0.upto(Math.sqrt(partie.grille().taille() - 1) do |x|
    		tab = getLigne(x)
			x.upto(Math.sqrt(partie.grille().taille() - 1) do |z|
				if !(tab & getLigne(z)).empty? #si il y a intersection entre deux ligne 
					if((tab & getLigne(z)).size == partie.grille().taille()) #Si la taille d'intersection est égale à la taille de ligne
		    			return false
    				end
    			end
    		end
    	end
    	#Pour la colonne
    	0.upto(Math.sqrt(partie.grille().taille() - 1) do |y|
    		tab = getLigne(y)
			x.upto(Math.sqrt(partie.grille().taille() - 1) do |i|	
    			if !(tab & getColonne(i)).empty? #si il y a intersection entre deux ligne 
					if((tab & getColonne(z)).size == partie.grille().taille()) #Si la taille d'intersection est égale à la taille de ligne
		    			return false
    				end
    			end
    		end
    	end
    	return true
    end
end				
    			
    			
    	