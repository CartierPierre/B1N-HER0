##
# Script de test pour la classe GestionnaireSauvegarde
#
# Version 7
#

# Dépendances
require_relative "../requireTout.rb"

# On récupère l'instance du gestionnaire d'utilisateur
gu = GestionnaireUtilisateur.instance()

# On récupère l'instance du gestionnaire de sauvegarde
gs = GestionnaireSauvegarde.instance()

# On récupère un utilisateur
utilisateur = gu.recupererUtilisateur(2)

# Nombre de sauvegardes
nbSauvegardes = gs.recupererNombreSauvegardeUtilisateur(utilisateur)
puts "L'utilisateur #{ utilisateur.nom } à #{ nbSauvegardes } sauvegarde(s)"

# Lister les sauvegardes d'un utilisateur
listeSauvegardes = gs.recupererSauvegardeUtilisateur(utilisateur, 0, 10)
listeSauvegardes.each do |sauvegarde|
	puts " - id : #{ sauvegarde.id }, description : #{ sauvegarde.description }"
end

# Récupèrer une sauvegarde
sauvegarde = gs.recupererSauvegarde(1)
if ( sauvegarde != nil )
	puts "La sauvegarde avec l'id 1 existe, description : #{ sauvegarde.description }"
end