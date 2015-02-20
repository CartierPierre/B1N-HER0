/*
	Requêtes SQL à implémenter dans la classe Data du client (variantes pour le serveur)
	Toutes ne sont pas forcément utiles et tous les cas ne sont pas couvert mais c'est déjà bien large
	
	WIP : les requêtes de calcul de scores
*/

/*
	---
	Utilisateurs
	---
*/

/* Récupérer le nombre d'utilisateur */
SELECT COUNT(id)
FROM utilisateur;

/* Lister les utilisateurs */
SELECT *
FROM utilisateur
LIMIT var0
OFFSET var1;

/* Sélectionner un utilisateur par son pseudo et mot de passe (connexion) */
SELECT *
FROM utilisateur
WHERE
	nom = var0
	AND mot_de_passe = var1
LIMIT 1;

/* Sélectionner un utilisateur par son uuid (voir profil autre utilisateur) */
SELECT *
FROM utilisateur
WHERE uuid = var0
LIMIT 1;

/*
	---
	Scores
	---
*/

/* Compter le nombre de scores */
SELECT COUNT(id)
FROM score;

/* Lister les scores */
SELECT *
FROM score
LIMIT var0
OFFSET var1;

/* Compter le nombre de scores pour une grille */
SELECT COUNT(id)
FROM score
WHERE id_grille = var0;

/* Lister les scores d'une grille */
SELECT *
FROM score
WHERE id_grille = var0
LIMIT var0
OFFSET var1;

/* Compter le nombre de scores d'un utilisateur */
SELECT COUNT(id)
FROM score
WHERE id_utilisateur = var0;

/* Lister les scores d'un utilisateur */
SELECT *
FROM score
WHERE id_utilisateur = var0
LIMIT var0
OFFSET var1;

/* Sélectionner un score selon un uuid (utile ?) */
SELECT *
FROM score
WHERE uuid = var0
lIMIT 1;

/* Sélectionner un score selon l'utilisateur et la grille (utile ?) */
SELECT *
FROM score
WHERE
	id_utilisateur = var0
	AND id_grille = var1
LIMIT 1;

/*
	Calculer le score total d'un utilisateur
	
	t : le temps nécessaire pour résoudre la grille (en seconde).
	x : le nombre de changement de case.
	a : le nombre de demande d'aide
	c : le nombre de demande conseil
	g : la taille de la grille
	n : le niveau de difficulté de la grille
	
	F = (g * n) / (1 + t + c + a)
*/
SELECT SUM()
FROM score
WHERE id_utilisateur = var0;

/* Lire le meilleur score d'un utilisateur sur une grille */
SELECT *
FROM score
WHERE
	id_utilisateur = var0
	AND id_grille = var1
ORDER BY
	temps_total,
	nb_coups DESC,
	nb_conseils DESC,
	nb_aides DESC
LIMIT 1;

/* Lire le meilleur score d'une grille */
SELECT *
FROM score
WHERE id_grille = var0
ORDER BY
	temps_total,
	nb_coups DESC,
	nb_conseils DESC,
	nb_aides DESC
LIMIT 1;

/* Ajouter un score */
INSERT INTO score
VALUES (
	null
	*
);

/* Supprimer les scores d'un utilisateur (réinitialisation) */
DELETE FROM score
WHERE id_utilisateur = var0;

/*
	---
	Sauvegardes
	---
*/

/* Compter le nombre de sauvegardes d'un utilisateur */
SELECT COUNT(id)
FROM sauvegarde
WHERE id_utilisateur = var0;

/* Lister les sauvegardes d'un utilisateur */
SELECT *
FROM sauvegarde
WHERE id_utilisateur = var0;

/* Lire une sauvegarde selon son uuid */
SELECT *
FROM sauvegarde
WHERE uuid = var0
LIMIT 1;

/* Ajouter une sauvegarde */
INSERT INTO sauvegarde
VALUES (
	null
	*
);

/* Supprimer une sauvegarde */
DELETE FROM sauvegarde
WHERE uuid = var0;

/* Supprimer les sauvegardes d'un utilisateur (réinitialisation) */
DELETE FROM sauvegarde
WHERE id_utilisateur = var0;

/*
	---
	Grilles
	---
*/

/* Compter le nombre de grille */
SELECT COUNT(id)
FROM grille;

/* Lister les grilles */
SELECT *
FROM grille;

/* Lire une grille selon son uuid */
SELECT *
FROM grille
WHERE uuid = var0
LIMIT 1;

/*
	---
	Singleton :
	---
	
	http://www.apprendre-php.com/tutoriels/tutoriel-45-singleton-instance-unique-d-une-classe.html
*/
