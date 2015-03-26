load 'Grille.rb'
class RegleUn
		
	attr_reader:ligne, :colonne, :grille
		
	private_class_method :new
    	def RegleUn.creer(grille)
        	new(grille)
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
    		nbRouge = 0
    		nbBleu = 0
    		while i < @ligne do
    			while j < @colonne do
    				if grille.getTuile(i,j).etat() == 1 then
    					nbRouge += 1
    				
    				elsif grille.getTuile(i,j).etat() == 2 then
    					nbBleu += 1
    				else
    				end
    				j += 1
    			end
    				if nbBleu != nbRouge then
    					return false
    				end
    		end
    		
    		i = 0
    		j = 0
    		nbRouge = 0
    		nbBleu = 0
    		while j < @colonne do
    			while i < @ligne do
    				if grille.getTuile(i,j).etat() == 1 then
    					nbRouge += 1;
    				
    				elsif grille.getTuile(i,j).etat() == 2 then
    					nbBleu += 1;
    				
    				else
    				end
    				i += 1
    			end
    			if nbBleu != nbRouge then
    				return false
    			end
    		end
    		return true
    	end
end
