<!--
TEMPLATE GÉNÉRIQUE — database.md

Rôle : décrire le modèle de données, UNIQUEMENT si le projet possède une
base de données. Si ce n'est pas le cas, indiquer simplement
"Ce projet ne possède pas de base de données" et ne rien inventer.

INTERDICTION ABSOLUE : ne jamais enregistrer mots de passe, API keys,
tokens, credentials, chaînes de connexion complètes, ou contenu de .env.
Décrire uniquement la structure et les conventions.

Supprimer ce bloc de commentaire une fois le fichier rempli.
-->

# Database

## SGBD

<!-- Ex: PostgreSQL 16, MySQL 8, SQLite, MongoDB... uniquement si vérifié. -->

## Tables / collections principales

<!-- Lister les tables/collections principales et leur rôle, sans détail
     exhaustif des colonnes sauf si structurant. -->

| Table / collection | Rôle |
|---|---|
| | |

## Relations principales

<!-- Clés étrangères importantes, cardinalités, dépendances entre tables. -->

## Contraintes importantes

<!-- Contraintes d'intégrité, index critiques, règles métier imposées au
     niveau base de données. -->

## Migrations

- Outil de migration utilisé :
- Emplacement des fichiers de migration :
- Convention de nommage des migrations :

## Conventions de nommage

<!-- Ex: snake_case pour les tables, préfixes, pluriel/singulier... -->

## Notes de sécurité

<!-- Rappel : aucune valeur sensible ici. Indiquer seulement où sont
     stockées les informations de connexion (ex: ".env, non versionné"). -->
