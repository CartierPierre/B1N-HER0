##
# Script de test pour la classe Stockage
#
# Version 5
#

# Dépendances
require_relative "./requireTout.rb"

# On récupère l'instance du gestionnaire d'utilisateur
gu = GestionnaireUtilisateur.instance()

# On récupère l'instance du stockage
stockage = Stockage.instance()

# On récupère un utilisateur
utilisateur = gu.recupererUtilisateur(1)

# On test la synchronisation des données d'un utilisateur
stockage.syncroniser( utilisateur )
