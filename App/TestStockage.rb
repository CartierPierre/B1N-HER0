##
# Script de test pour la classe Stockage
#
# Version 6
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère l'instance du gestionnaire d'utilisateur
gu = GestionnaireUtilisateur.instance()

# On récupère l'instance du stockage
stockage = Stockage.instance()

# Test de connexion d'un client
resultat = stockage.authentification('Test', 'azerty')
p resultat

# On récupère un utilisateur
utilisateur = gu.recupererUtilisateur( 7 )

# On test la synchronisation des données d'un utilisateur
puts "Synchronisation des données de #{ utilisateur.nom }"
stockage.syncroniser( utilisateur )
puts "Ok"
