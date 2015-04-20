#Règle 3: 2 lignes ou 2 colonnes ne peuvent être identiques.

class RegleTrois
		
    private_class_method :new
    	
    def RegleTrois.creer()
        new()
    end
    	
    def initialize()
    	new()
    end
    
    def RegleTrois.appliquer(partie)
	#Retourner un string contient les information
    	#Pour chaque ligne
    	0.upto partie.grille().taille() - 1 do |x|
			(x+1).upto partie.grille().taille() - 1 do |z|
				if partie.grille.getLigne(x).eql?(partie.grille.getLigne(z))
		    			return String.new("La ligne #{x} et #{z} est identique")
    			end
    		end
    	end
    	#Pour chaque colonne 
    	0.upto partie.grille().taille() - 1 do |y|
			(y+1).upto partie.grille().taille() - 1 do |z|
				if partie.grille.getColonne(y).eql?(partie.grille.getColonne(z))
		    			return String.new("La colonne #{y} et #{z} est identique")
    			end
    		end
    	end
    	return String.new("regle trois true")
    end
end				
    			
    			
    	
