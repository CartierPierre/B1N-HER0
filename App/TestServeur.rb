##
# Script de test pour la classe Serveur
#
# Version 4
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère des instance de gestionnaires
gut = GestionnaireUtilisateur.instance()
gsa = GestionnaireSauvegarde.instance()
gsc = GestionnaireScore.instance()

# On récupère l'instance du serveur
serveur = Serveur.instance()

# On récupère des données de test
utilisateur = gut.recupererUtilisateur( 1 )
score = gsc.recupererScore( 1 )
sauvegarde = gsa.recupererSauvegarde( 6 )

# Test temps de réponse
puts "Test de la connexion ..."
moy = 0
succes = 0
essais = 0
while( essais < 10 )
	t = serveur.testConnexion()
	print "#{ essais } -> "
	if( t > -1 )
		puts "#{ t } ms"
		moy = moy + t
		succes = succes + 1
	else
		puts "Erreur"
	end
	essais = essais + 1
end

print "#{ succes } / #{ essais } essais reusis"
if( succes != 0)
	moy = moy / succes
	print ", moyenne : #{ moy } ms"
end
puts

# Test connexion utilisateur
puts "Test connexion utilisateur ..."
con = serveur.connexionUtilisateur( "Buddies", "azerty" )
p con

# Test liste ressources
puts "Test liste ressources ..."
listeRessources = serveur.listeRessources( Utilisateur.creer( nil, 10, nil, nil, nil, nil, nil, nil ) )
p listeRessources

# Test récupération de ressources
puts "Test récupération de ressources ..."
ressources = serveur.recupererRessources( 1, [1, 2, 3], [1, 2, 3] )
p ressources

# Test envoi de ressources
puts "Test envoi de ressources ..."
utilServ = utilisateur.clone()
utilServ.option = Option.serialiser( utilisateur.option ) # Moche à revoir
utilServ.statistique = nil # Moche à revoir
reponse = serveur.envoyerRessources( utilServ, [ score ], [ sauvegarde ] )
p reponse
