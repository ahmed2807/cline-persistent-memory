# Sécurité

## Ce qui ne doit jamais être enregistré dans la mémoire

Aucun fichier de `.clinerules/` (ni dans les templates, ni dans la mémoire
remplie d'un projet) ne doit jamais contenir :

- mots de passe ;
- API keys ;
- tokens (accès, rafraîchissement, session...) ;
- secrets applicatifs ;
- credentials de connexion (base de données, services tiers) ;
- contenu de fichiers `.env` ou équivalents ;
- clés privées, certificats ;
- informations personnelles sensibles (données de santé, identifiants
  nationaux, données financières personnelles...).

Cette interdiction s'applique aussi bien pendant `INITIALIZE PROJECT
MEMORY` que pendant `MEMORY UPDATE` : si une information sensible est
rencontrée en analysant le projet, ne jamais la recopier telle quelle.
Décrire uniquement son existence et son emplacement, par exemple :

> Les identifiants de connexion à la base de données sont définis dans
> `.env` (non versionné). Variables attendues : `DB_HOST`, `DB_USER`,
> `DB_PASSWORD` (noms uniquement, pas les valeurs).

## Protection au niveau Git

- Le `.gitignore` fourni avec ce système (voir racine du repository et
  `INSTALL.md`) exclut par défaut les fichiers `.env`, clés, certificats
  et fichiers de credentials courants.
- Lors de l'installation dans un projet, fusionner ce `.gitignore` avec
  celui du projet plutôt que de l'écraser, pour ne pas perdre de règles
  déjà en place.
- Avant chaque commit touchant `.clinerules/`, une relecture rapide des
  fichiers modifiés est recommandée pour repérer une fuite accidentelle.

## Détection de secrets accidentellement présents

Cette vérification fait partie de la procédure `MEMORY AUDIT` (voir
`maintenance.md`), mais peut aussi être lancée isolément.

### Ce qu'il faut rechercher dans les fichiers `.clinerules/*.md`

- Motifs typiques de secrets : chaînes ressemblant à des clés (longues
  chaînes alphanumériques précédées de `key`, `token`, `secret`,
  `password`, `api_key`...).
- Chaînes de connexion complètes (`postgres://user:password@host/...`,
  `mongodb://...`).
- Blocs copiés-collés depuis un fichier `.env`.
- Adresses e-mail ou identifiants personnels non nécessaires à la
  compréhension du projet.

### En cas de détection

1. Ne pas laisser l'information dans le fichier.
2. La remplacer par une description non sensible de son existence et de
   son emplacement réel (ex: "voir `.env`, non versionné").
3. Si le secret a déjà été commité dans l'historique Git, le signaler
   clairement dans le rapport d'audit : la suppression du fichier ne
   suffit pas à l'effacer de l'historique. La rotation du secret concerné
   et un nettoyage de l'historique Git (hors du périmètre de ce système)
   peuvent être nécessaires.

## Principe général

En cas de doute sur le caractère sensible d'une information : ne pas
l'enregistrer dans la mémoire persistante, et le signaler à l'utilisateur
plutôt que de trancher silencieusement.
