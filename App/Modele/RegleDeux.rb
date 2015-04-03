#Règle 2: pas plus de 2 chiffres identiques côte à côte 

load 'Grille.rb'

class RegleDeux
		
    attr_reader:ligne, :colonne, :grille
		
    private_class_method :new
	
    def RegleDeux.creer()
        new()
    end
    	
    def initialize()
    	new()
    end
    
    def appliquer(grille)
    
    	@grille = grille
    	@ligne = grille.ligne()
    	@colonne = grille.colonne()
    		
    	i = 0
    	j = 0
	while i < @ligne do
    		while j < @colonne -2 do
 			if grille.getTuile(i,j).etat() == 1 && grille.getTuile(i,j+1).etat() == 1 && grille.getTuile(i,j+2).etat() == 1
 				#Meme si plus que trois, il retourne faux 
 					return false
    			end
    			
    			if grille.getTuile(i,j).etat() == 2 && grille.getTuile(i,j+1).etat() == 2 && grille.getTuile(i,j+2).etat() == 2
 					return false
    			end
    			
    			j += 1
    		end
    		i += 1
    	end

	i = 0
    	j = 0
    	while j < @colonne do
    		while i < @ligne - 2 do
    			if grille.getTuile(i,j).etat() == 1 && grille.getTuile(i+1,j).etat() == 1 && grille.getTuile(i+2,j).etat() == 1
 				#Meme si plus que trois, il retourne faux 
 					return false
    			end
    			
    			if grille.getTuile(i,j).etat() == 2 && grille.getTuile(i+2,j).etat() == 2 && grille.getTuile(i+2,j).etat() == 2
 					return false
    			end			
    			i += 1
    		end
    		j += 1
    	end
    	return true
    end
end
