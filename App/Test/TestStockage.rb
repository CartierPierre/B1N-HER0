##
# Script de test pour la classe stockage, en particulier la couche réseau
#
# Version 5
#

# Dépendances
require_relative "../requireTout.rb"

stockage = Stockage.instance()

# Test temps de réponse
puts "Test de la connexion ..."
moy = 0
succes = 0
essais = 0
while( essais < 10 )
	t = stockage.testConnexion()
	print "#{ essais } -> "
	if( !t )
		puts "Erreur"
	else
		puts "#{ t } ms"
		moy = moy + t
		succes = succes + 1
	end
	essais = essais + 1
end

print "#{ succes } / #{ essais } essais reusis"
if( succes != 0)
	moy = moy / succes
	print ", moyenne : #{ moy } ms"
end
puts
