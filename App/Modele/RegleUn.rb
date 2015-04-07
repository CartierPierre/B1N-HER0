#Règle 1: autant de 1 et de 0 sur chaque ligne et sur chaque colonne 
load 'Grille.rb'
load "Partie.rb"

class RegleUn
		
	private_class_method :new
    
    	def RegleUn.creer()
        	new()
	end
    	
    	def initialize()
    		new()
	end
	
	def RegleUn.appliquer(partie)
	
    		0.upto(Math.sqrt(partie.grille.taille()) - 1) do |x|
    			tab = partie.compterCasesLigne(x)
    			if  tab[0] != tab[1] then
    				return false
    			end
    		end
    		
    		0.upto(Math.sqrt(partie.grille.taille()) - 1) do |y|
    			tab = partie.compterCasesColonne(y)
    			if  tab[0] != tab[1] then
    				return false
    			end
    		end
    		return true
    end
end
