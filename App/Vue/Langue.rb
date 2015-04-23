# Heu ... ba quand je sérialise les option pour un utilisateur, je me dis cela va
# juste stocker 2 ou 3 variable et en fait je me retrouve avec un ***** de dico
# anglais/francais !!!
#
# Je pense qu'il serai préférable d'utiliser des constantes de classe ou je sais pas quoi ^^
#

class Langue

    EN = 0
    FR = 1

    @langueFr
    @langueEn
    @langueActuelle
    @langueConstante

    attr_reader :langueActuelle, :langueConstante

    def initialize(langue) 

        @langueFr = {
            aide: "Aide",
            anglais: "Anglais",
            annuler: "Annuler",
            annulerAction: "Annuler",
            appliquer: "Appliquer",
            appliquerRegle: "Appliquer la ",
            baseDonnees: "Base de données",
            charger: "Charger",
            chargerPartie: "Charger partie",
            chefProjet: "Chef de projet",
            classement: "Classement",
            codage: "Codage du jeu",
            confirmationQuitter: "Voulez vous vraiment quitter la partie ?",
            confirmationRecommencer: "Voulez vous vraiment recommencer cette partie ?",
            confirmationSauvegarde: "Voulez vous vraiment sauvegarder cette partie ?",
            connexion: "Connexion",
            conseil: "Conseil",
            couleurTuiles: "Couleur des tuiles",
            credits: "Crédits",
            demarrage: "Demarrage",
            difficulte: "Difficulté",
            documentaliste: "Documentaliste",
            et: " et ",
            felicitations: "Félicitations, vous avez réussi à résoudre une grille ",
            felicitations2: " en difficulté ",
            francais: "Français",
            grilleInvalide: "Grille invalide",
            grilleInvalideExplications: "La grille est invalide, vérifiez bien que toutes les règles sont respectées.",
            hypothese: "Hypothèse",
            hypotheseActive: " Hypothèse\n activé",
            inscription: "Inscription",
            interfaceGraphique: "Interface graphique",
            jouer: "Jouer",
            langue: "Langue",
            menuPrincipal: "Menu principal",
            modeDeJeuEnLigne: "Mode de jeu en ligne",
            modeDeJeuHorsLigne: "Mode de jeu hors ligne",
            motDePasse: "Mot de passe",
            nbAides: "Nombre d'aides utilisées",
            nbConseils: "Nombre de conseils utilisés",
            nbCoups: "Nombre de coups effectués",
            succesDeverrouille: "Succès déverrouillé(s)",
            niveau: "Niveau",
            non: "Non",
            nouvellePartie: "Nouvelle partie",
            options: "Options",
            oui: "Oui",
            profil: "Profil",
            pseudo: "Pseudo",
            quitter: "Quitter",
            rang: "Rang",
            recherche: "Chercher un joueur",
            recommencer: "Recommencer",
            regleColonne: " sur la colonne ",
            regleLigne: " sur la ligne ",
            regles: "Règles du jeu",
            regles1: "Règle n°1 : Il ne peut y avoir plus de deux cases possédant le même état à la suite\n\n",
            regles2: "Règle n°2 : Chaque ligne et colonne possède autant de cases à l’état n°1 et à l’état n°2\n\n",
            regles3: "Règle n°3 : Il ne peut y avoir deux lignes ou deux colonnes identiques",
            repeter: "Répéter",
            resultatPartie: "Résultat de la partie",
            retour: "Retour",
            retournerMenuPrincipal: "Retourner au menu principal",
            sauvegardeEffectuee: "La partie a bien été sauvegardée",
            sauvegarder: "Sauvegarder",
            score: "Score",
            taille: "Taille",
            tailleGrille: "Taille de la grille",
            temps: "Temps",
            valider: "Valider",
            validerGrille: "Valider la grille"
        }

        @langueEn = {
            aide: "Help",
            anglais: "English",
            annuler: "Cancel",
            annulerAction: "Undo",
            appliquer: "Apply",
            appliquerRegle: "Apply the ",
            baseDonnees: "Database",
            charger: "Load",
            chargerPartie: "Load game",
            chefProjet: "Project manager",
            classement: "Ranking",
            codage: "Coding",
            confirmationQuitter: "Do you really want to quit this game ?",
            confirmationRecommencer: "Do you really want to restart this game ?",
            confirmationSauvegarde: "Do you really want to save this game ?",
            connexion: "Login",
            conseil: "Advice",
            couleurTuiles: "Color tiles",
            credits: "Credits",
            demarrage: "Launch",
            difficulte: "Difficulty",
            documentaliste: "Archivist",
            et: " and ",
            felicitations: "Congratulations, you managed to solve a grid ",
            felicitations2: " in difficulty ",
            francais: "French",
            grilleInvalide: "Invalid grid",
            grilleInvalideExplications: "The grid is invalid, make sure that all the rules are followed.",
            hypothese: "Hypothesis",
            hypotheseActive: " Hypothesis\n enabled",
            inscription: "Sign up",
            interfaceGraphique: "Graphical User Interface",
            jouer: "Play",
            langue: "Language",
            menuPrincipal: "Main menu",
            modeDeJeuEnLigne: "Online play mode",
            modeDeJeuHorsLigne: "Offline play mode",
            motDePasse: "Password",
            nbAides: "Number of helps used",
            nbConseils: "Number of advices used",
            nbCoups: "Number of moves made",
            succesDeverrouille: "Achievement unlocked",
            niveau: "Level",
            non: "No",
            nouvellePartie: "New game",
            options: "Settings",
            oui: "Yes",
            profil: "Profile",
            pseudo: "Pseudo",
            quitter: "Quit",
            rang: "Rank",
            recherche: "Player search",
            recommencer: "Restart",
            regleColonne: " on the column ",
            regleLigne: " on the row ",
            regles: "Rules",
            regles1: "Rule n°1 : Three adjacent tiles of the same color in a row or column isn't allowed\n\n",
            regles2: "Rule n°2 : Rows and columns have an equal number of each color\n\n",
            regles3: "Rule n°3 : No two rows and no two columns are the same",
            repeter: "Redo",
            resultatPartie: "Result of the game",
            retour: "Back",
            retournerMenuPrincipal: "Back to the main menu",
            sauvegardeEffectuee: "The game has been saved.",
            sauvegarder: "Save",
            score: "Score",
            taille: "Size",
            tailleGrille: "Grid size",
            temps: "Time",
            valider: "Confirm",
            validerGrille: "Check the grid"
        }
        if(langue == FR)
            @langueActuelle = @langueFr
        else
            @langueActuelle = @langueEn
        end
        @langueConstante = langue
    end

    def getLangueConstante()
        return @langueConstante
    end

    def setLangue(langue)
        if(langue == FR)
            @langueActuelle = @langueFr
        else
            @langueActuelle = @langueEn
        end  
        @langueConstante = langue
    end

end