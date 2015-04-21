##
# Script de test pour la classe GestionnaireSauvegarde
#
# Version 8
#

# Dépendances
require_relative "../requireTout.rb"



# On récupère l'instance du gestionnaire d'utilisateur
gut = GestionnaireUtilisateur.instance()

# On récupère l'instance du gestionnaire de niveau
gni = GestionnaireNiveau.instance()

# On récupère l'instance du gestionnaire de sauvegarde
gsa = GestionnaireSauvegarde.instance()



# On récupère un utilisateur
utilisateur = gut.recupererUtilisateur(1)

# Nombre de sauvegardes de l'utilisateur
nbSauvegardes = gsa.recupererNombreSauvegardeUtilisateur(utilisateur)
puts "L'utilisateur #{ utilisateur.nom } à #{ nbSauvegardes } sauvegarde(s)"

# Lister les sauvegardes d'un utilisateur
listeSauvegardes = gsa.recupererSauvegardeUtilisateur(utilisateur, 0, 10)
listeSauvegardes.each do |sauvegarde|
	puts " - id : #{ sauvegarde.id }, description : #{ sauvegarde.description }"
end
puts

## Récupèrer une sauvegarde et exploiter son contenu

# On récupère une sauvegarde
sauvegarde = gsa.recupererSauvegarde(1)
if ( sauvegarde == nil )
	puts "La sauvegarde avec l'id 1 n'existe pas !"
	abord
end
puts "La sauvegarde avec l'id 1 existe, description : #{ sauvegarde.description }, sur le niveau #{ sauvegarde.idNiveau }"

# On récupère son niveau
niveau = gni.recupererNiveau( sauvegarde.idNiveau )

partie = Partie.charger(utilisateur, niveau, sauvegarde)

puts "La partie de cette sauvegarde à vu #{ partie.nbCoups() } coup(s) joué(s)"
