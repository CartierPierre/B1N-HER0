##
# Script de test pour la classe Serveur
#
# Version 1
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère l'instance
serveur = Serveur.instance()

# Test temps de réponse
puts "Test de la connexion ..."
moy = 0
succes = 0
essais = 0
while( essais < 10 )
	t = serveur.testConnexion()
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
