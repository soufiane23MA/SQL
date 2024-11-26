EXO_SQL_CINEMA

a: Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et
réalisateur ;

SELECT f.titre,f.annee_Sortie,f.duree_Filme,SEC_TO_TIME(f.duree_filme*60) AS 'duree' ,
CONCAT(p.nom_Personne,p.prenom_Personne) AS 'Realisateur' FROM film f

INNER JOIN realisateur r ON f.id_Realisateur=r.id_Realisateur
INNER JOIN personne p ON r.id_Personne = p.id_Personne
WHERE f.id_Filme=6; 

b: Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)
 
SELECT f.titre AS 'TITRE', f.duree_Filme AS 'DUREE DE Filme' FROM film f 
WHERE  duree_Filme > 135
ORDER BY  duree_Filme DESC;

c: Liste des films d’un réalisateur (en précisant l’année de sortie) 
/* ici on cherche a affiché l'enssemble de films d'un réalisateur précis, et l'année de sortie de filme 
 la methode CONCAT() permer la concaténation des chaine de caractéres
  comme nom et prenom de réalisateur ici*/


SELECT f.titre AS Titre, f.annee_Sortie AS "Année de sortie",CONCAT(nom_Personne," ",prenom_Personne) AS "nom Realisateur"
FROM film f
JOIN realisateur r ON f.id_Realisateur = r.id_Realisateur
JOIN personne p ON r.id_Personne = p.id_Personne
WHERE r.id_Realisateur = 1;

d. Nombre de films par genre (classés dans l’ordre décroissant)
/* pour compter le nombre de filme par genre, il faut utiliser la fonction d'agrégation count(), 
/* pour l'ordre décroissant on utilisra DESC
*/

 SELECT g.libelle AS genre,COUNT(f.id_Filme) AS nombre_films
FROM genre g
INNER JOIN appartenir ap ON g.id_Genre = ap.id_Genre
INNER JOIN film f ON ap.id_Filme = f.id_Filme
GROUP BY g.id_Genre
ORDER BY nombre_films DESC;

e. Nombre de films par réalisateur (classés dans l’ordre décroissant)
/*  dans la table filme , on compte le nombre de filme regrouper par le nom du realisateur, 
avec DESC on obtien l'ordre décroissant .*/


SELECT p.nom_Personne AS 'Realisateur',COUNT(f.id_Filme) AS 'nombre_films'
FROM film f
INNER JOIN realisateur r ON r.id_Realisateur = f.id_Realisateur
INNER JOIN personne p ON r.id_Personne = p.id_Personne
GROUP BY p.id_Personne
ORDER BY nombre_films DESC;

f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe


SELECT p.nom_Personne,p.prenom_Personne, p.sex_Personne FROM personne p 
INNER JOIN acteur a ON a.id_Personne = p.id_Personne
INNER JOIN jouer j ON j.id_Acteur=a.id_Acteur
 
WHERE j.id_Filme =2;

g. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de
sortie (du film le plus récent au plus ancien)

 SELECT f.titre,f.annee_Sortie,ro.nom_Role FROM film f
INNER JOIN jouer j ON j.id_Filme=f.id_Filme
INNER JOIN  role ro ON j.id_Role=ro.id_Role
INNER JOIN acteur a ON j.id_Acteur= a.id_Acteur
WHERE a.id_Acteur=1
ORDER BY f.annee_Sortie DESC;

h. Liste des personnes qui sont à la fois acteurs et réalisateurs.
 
 SELECT p.nom_Personne,p.prenom_Personne  FROM personne p
 INNER  JOIN acteur a ON a.id_Personne= p.id_Personne
 INNER JOIN jouer j ON j.id_Acteur=a.id_Acteur
 INNER JOIN film f ON f.id_Filme=j.id_Filme
 INNER JOIN realisateur r ON p.id_Personne=r.id_Personne
 GROUP BY p.id_Personne;

i. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)
/* la fonction year curdate(), retourne l'annee courante */

SELECT f.titre,f.annee_Sortie 
FROM film f
WHERE YEAR(CURDATE()) - f.annee_Sortie < 5
ORDER BY f.annee_Sortie DESC;

j. Nombre d’hommes et de femmes parmi les acteurs

SELECT p.sex_Personne, COUNT(*) AS nombre
FROM personne p
INNER JOIN acteur a ON a.id_Personne = p.id_Personne
GROUP BY p.sex_Personne;

k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)
/* j'utilise la fonction DATEDIFF aui retourne la difference entre
2 date , et NOW() retounre la date d'aujourd'hui*/

SELECT p.date_naissance,p.nom_Personne AS ACTEUR  from personne p
INNER JOIN acteur a ON a.id_Personne=p.id_Personne
WHERE DATEDIFF (NOW(),p.date_Naissance)>=50; 

. Acteurs ayant joué dans 3 films ou plus.
/* je electione le nom prenom de l'acteur , avec la jointure PERSONNE
et ACTEUR, avec count je compte le totatal de filme associer
à l'acteur , et je filtre vec having , les acteur qui ont un total
filme >3*/

SELECT  p.nom_Personne,p.prenom_Personne,COUNT(j.id_Filme) AS nombreFilme  FROM personne p
INNER JOIN acteur a ON a.id_Personne=p.id_Personne
INNER JOIN jouer j ON j.id_Acteur=a.id_Acteur
GROUP BY p.id_Personne
HAVING COUNT(j.id_Filme)>=3;
