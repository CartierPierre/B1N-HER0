class Langue

    ### Constantes de classe

    EN = 0
    FR = 1

    ### Attributs d'instances

    @langueFr
    @langueEn
    @langueActuelle
    @langueConstante

    attr_reader :langueActuelle, :langueConstante

    ##
    # Méthode de création de la Langue.
    #
    # Paramètre::
    #   * _langue_ - Langue du jeu sous la forme des constantes de cette classe
    #
    def initialize(langue) 

        @langueFr = {
            aide: "Aide",
            anglais: "Anglais",
            annuler: "Annuler",
            annulerAction: "Annuler",
            appliquer: "Appliquer",
            appliquerRegle: "Appliquer la ",
            aucunesSauvegardes: "Aucunes sauvegardes pour cette taille de grille",
            baseDonnees: "Base de données",
            changerPasse: "Changer de mot de passe",
            changerPseudo: "Changer de Pseudo",
            charger: "Charger",
            chargerPartie: "Charger partie",
            chefProjet: "Chef de projet",
            classement: "Classement",
            codage: "Codage du jeu",
            compte2: "Deuxième compte",
            compteActuel: "Compte actuel",
            compteSync: "Compte à synchroniser",
            compteGarde: "Lequel des deux comptes désirez-vous garder ?",
            gestion: "Gestion",
            confirmationQuitter: "Voulez vous vraiment quitter la partie ?",
            confirmationRecommencer: "Voulez vous vraiment recommencer cette partie ?",
            confirmationReprendrePartie: "Voulez vous reprendre la dernière partie ?",
            confirmationSauvegarde: "Voulez vous vraiment sauvegarder cette partie ?",
            confirmationSuppressionSauvegarde: "Voulez vous vraiment supprimer cette sauvegarde ?",
            connexion: "Connexion",
            conseil: "Conseil",
            couleurTuiles: "Couleur des tuiles",
            credits: "Crédits",
            creerCompte: "Voulez-vous créer un compte avec ce pseudo ?",
            demarrage: "Demarrage",
            descriptionSauvegarde: "Entrer une description pour la sauvegarde (20 caractères max)",
            difficulte: "Difficulté",
            documentaliste: "Documentaliste",
            et: " et ",
            existe: " existe déjà",
            felicitations: "Félicitations, vous avez réussi à résoudre une grille ",
            felicitations2: " en difficulté ",
            fermer: "Fermer",
            formatDate: "%d/%m/%Y",
            francais: "Français",
            fusion: "Fusion de Compte",
            grilleInvalide: "Grille invalide",
            grilleInvalideExplications: "La grille est invalide, vérifiez bien que toutes les règles sont respectées.",
            hypothese: "Hypothèse",
            hypotheseActive: " Hypothèse\n activé",
            inscription: "Inscription",
            inscrit: "Inscrit le",
            interfaceGraphique: "Interface graphique",
            jouer: "Jouer",
            langue: "Langue",
            lUtilisateur: "L'utilisateur ",
            mauvaisPasse: "L'ancien mot de passe est incorrect",
            menuPrincipal: "Menu principal",
            modeDeJeuEnLigne: "Mode de jeu en ligne",
            modeDeJeuHorsLigne: "Mode de jeu hors ligne",
            motDePasse: "Mot de passe",
            nbAides: "Nombre d'aides utilisées",
            nbConseils: "Nombre de conseils utilisés",
            nbCoups: "Nombre de coups effectués",
            nbPartiesTermines: "Nombre de parties terminées",
            niveau: "Niveau",
            non: "Non",
            nouveauPseudo: "Nouveau pseudo",
            nouvellePartie: "Nouvelle partie",
            options: "Options",
            oui: "Oui",
            partiesParfaites: "parties parfaites",
            partiesTermines: "parties terminées",
            pasDeCompte: "Il n'existe pas de compte associé à ce pseudo.",
            pasInternetInscription: "La connexion avec le serveur n'a pu être établie. Il est donc impossible de créer un compte en ligne. Nous vous invitons donc à créer un compte local temporaire. Ce dernier pourra être converti ultérieurement vers un compte en ligne dès le retour de la connexion.",
            pasInternetOffline: "Identifiants incorrects",
            pasInternetOnline: "La connexion avec le serveur n'a pu être établie. Il est donc impossible de synchroniser vos données dans l'immédiat. Vous pourrez les synchroniser ultérieurement si la connexion est rétablie.",
            passeAncien: "Ancien mot de passe.",
            passeChange: "Votre mot de passe à été changé",
            passeChanger: "Changement de mot de passe",
            passeDifferent: "Le nouveau mot de passe doit être différent de l'ancien.",
            passeNouveau: "Nouveau mot de passe.",
            pause: "Pause",
            profil: "Profil",
            pseudo: "Pseudo",
            pseudoChange: "Votre pseudo à été changé",
            pseudoChanger: "changement de Pseudo",
            quitter: "Quitter",
            rang: "Rang",
            recherche: "Chercher un joueur",
            recommencer: "Recommencer",
            regleColonne: " sur la colonne ",
            regleLigne: " sur la ligne ",
            regle: "Règle",
            regles: "Règles du jeu",
            regles1: "Règle n°1 : Il ne peut y avoir plus de deux cases possédant le même état à la suite",
            regles2: "Règle n°2 : Chaque ligne et colonne possède autant de cases à l’état n°1 et à l’état n°2",
            regles3: "Règle n°3 : Il ne peut y avoir deux lignes ou deux colonnes identiques",
            reglesRespectees: "L'ensemble des règles sont respectées.\nUtiliser l'aide ou le mode hypothèse si vous êtes bloqué.",
            repeter: "Répéter",
            reprendrePartie: "Reprendre la partie",
            reset: "Remise à zéro du compte",
            resultatPartie: "Résultat de la partie",
            retour: "Retour",
            retournerMenuPrincipal: "Retourner au menu principal",
            sauvegardeEffectuee: "La partie a bien été sauvegardée",
            sauvegarder: "Sauvegarder",
            score: "Score",
            statistiques: "Statistiques",
            succes: "Succes",
            succesDeverrouille: "Succès déverrouillé",
            supprimer: "Supprimer",
            supprimerCompte: "Supprimer le compte",
            taille: "Taille",
            tailleGrille: "Taille de la grille",
            temps: "Temps",
            tempsDeJeu: "Temps de jeu total",
            utilisateurInexistant: "Utilisateur inexistant",
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
            aucunesSauvegardes: "No saves for this grid size",
            baseDonnees: "Database",
            changerPasse: "Password change",
            changerPseudo: "Username change",
            charger: "Load",
            chargerPartie: "Load game",
            chefProjet: "Project manager",
            classement: "Ranking",
            codage: "Coding",
            compte2: "Second account",
            compteActuel: "Actual account",
            compteSync: "Account to synchronize to",
            compteGarde: "Which account do you want to keep ?",
            confirmationQuitter: "Do you really want to quit this game ?",
            confirmationRecommencer: "Do you really want to restart this game ?",
            confirmationReprendrePartie: "Do you want to resume the last game ?",
            confirmationSauvegarde: "Do you really want to save this game ?",
            confirmationSuppressionSauvegarde: "Do you really want to delete this save ?",
            connexion: "Login",
            conseil: "Advice",
            couleurTuiles: "Color tiles",
            credits: "Credits",
            creerCompte: "Would you like to create an account with this username ?",
            demarrage: "Launch",
            descriptionSauvegarde: "Enter a description for the save (20 characters max)",
            difficulte: "Difficulty",
            documentaliste: "Archivist",
            et: " and ",
            existe: " already exist.",
            felicitations: "Congratulations, you managed to solve a grid ",
            felicitations2: " in difficulty ",
            fermer: "Close",
            formatDate: "%m/%d/%Y",
            francais: "French",
            fusion: "Merge Accounts",
            gestion: "Management",
            grilleInvalide: "Invalid grid",
            grilleInvalideExplications: "The grid is invalid, make sure that all the rules are followed.",
            hypothese: "Hypothesis",
            hypotheseActive: " Hypothesis\n enabled",
            inscription: "Sign up",
            inscrit: "Registered",
            interfaceGraphique: "Graphical User Interface",
            jouer: "Play",
            langue: "Language",
            lUtilisateur: "The user ",
            mauvaisPasse: "The old password you entered is incorrect",
            menuPrincipal: "Main menu",
            modeDeJeuEnLigne: "Online play mode",
            modeDeJeuHorsLigne: "Offline play mode",
            motDePasse: "Password",
            nbAides: "Number of helps used",
            nbConseils: "Number of advices used",
            nbCoups: "Number of moves made",
            nbPartiesTermines: "Number of finished games",
            niveau: "Level",
            non: "No",
            nouveauPseudo: "New username",
            nouvellePartie: "New game",
            options: "Settings",
            oui: "Yes",
            partiesParfaites: "completed games",
            partiesTermines: "perfect games",
            pasDeCompte: "There is no account associated with this username.",
            pasInternetInscription: "Connection to the server couldn't be established so you can't sign up with an online account. If needed, you can create a temporary offline account, the statistics of this account can be merged with an online account later.",
            pasInternetOffline: "Connection to  the server couldn't be established so you can't sign in with an online account. If needed, you can create a temporary offline account, the statistics of this account can be merged with an online account later.",
            pasInternetOnline: "Connection to  the server couldn't be established so you can't synchronise your data for now. You will be able to when the connexion can be achieved.",
            passeDifferent: "The new password must differ from the old one.",
            passeChange: "Password changed",
            passeChanger: "Change password",
            passeNouveau: "New password.",
            pause: "Pause",
            profil: "Profile",
            pseudo: "Username",
            pseudoChange: "Your username has been changed.",
            pseudoChanger: "Change username",
            quitter: "Quit",
            rang: "Rank",
            recherche: "Player search",
            recommencer: "Restart",
            regleColonne: " on the column ",
            regleLigne: " on the row ",
            regle: "Rule",
            regles: "Rules",
            regles1: "Rule n°1 : Three adjacent tiles of the same color in a row or column isn't allowed",
            regles2: "Rule n°2 : Rows and columns have an equal number of each color",
            regles3: "Rule n°3 : No two rows and no two columns are the same",
            reglesRespectees: "All the rules are followed.\nUse helps or hypothesis if you get stuck.",
            repeter: "Redo",
            reprendrePartie: "Resume the game",
            reset: "Reset account",
            resultatPartie: "Result of the game",
            retour: "Back",
            retournerMenuPrincipal: "Back to the main menu",
            sauvegardeEffectuee: "The game has been saved.",
            sauvegarder: "Save",
            score: "Score",
            statistiques: "Statistics",
            succes: "Achievement",
            succesDeverrouille: "Achievement unlocked",
            supprimer: "Delete",
            supprimerCompte: "Delete account",
            taille: "Size",
            tailleGrille: "Grid size",
            temps: "Time",
            tempsDeJeu: "Total play time",
            utilisateurInexistant: "Unknown user",
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

    ##
    # Retour::
    #   La constante de langue actuellement active
    #
    def getLangueConstante()
        return @langueConstante
    end

    ##
    # Affecte une nouvelle langue
    #
    # Paramètre::
    #   * _langue_ - La nouvelle langue à affecter sous la forme des constantes de cette classe
    #
    def setLangue(langue)
        if(langue == FR)
            @langueActuelle = @langueFr
        else
            @langueActuelle = @langueEn
        end  
        @langueConstante = langue
    end

end