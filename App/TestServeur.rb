##
# Script de test pour la classe Serveur
#
# Version 2
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère l'instance du gestionnaire d'utilisateur
gu = GestionnaireUtilisateur.instance()

# On récupère l'instance du serveur
serveur = Serveur.instance()

# On récupère un utilisateur
utilisateur = gu.recupererUtilisateur(1)

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

# Test liste ressources
listeRessources = serveur.listeRessources( utilisateur )
puts listeRessources

# Test récupération de ressources
ressources = serveur.recupererRessources( [1, 2, 3], [1, 2, 3] )
puts ressources
