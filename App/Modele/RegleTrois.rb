#Règle 3: 2 lignes ou 2 colonnes ne peuvent être identiques.

load 'Grille.rb'
load "Partie.rb"
load "Tuile.rb"

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
    	0.upto partie.grille().taille() - 1 do |x|
			(x+1).upto partie.grille().taille() - 1 do |z|
				#print "#{(partie.grille.getLigne(x) & partie.grille.getLigne(z)).empty?}\n"
				#print "#{(partie.grille.getLigne(x) & partie.grille.getLigne(z)).size}\n"
				p partie.grille.getLigne(x)
				p partie.grille.getLigne(z)
				if partie.grille.getLigne(x).eql?(partie.grille.getLigne(z))
		    			return false
    			end
    		end
    	end
    	#Pour chaque colonne 
    	0.upto partie.grille().taille() - 1 do |y|
			(y+1).upto partie.grille().taille() - 1 do |z|
				p partie.grille.getColonne(y)
				p partie.grille.getColonne(z)
				if partie.grille.getColonne(y).eql?(partie.grille.getColonne(z))
		    			return false
    			end
    		end
    	end
    	return true
    end
end				
    			
    			
    	
