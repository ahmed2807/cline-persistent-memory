# Portabilité

Le système ne dépend d'aucune technologie particulière. Il doit pouvoir
être installé aussi bien dans un projet PHP/Laravel que Node.js, Python,
Java, React, Vue, Angular, avec ou sans base de données, dans un monorepo
ou un petit projet isolé.

## Pourquoi c'est possible

- Le mécanisme générique (`.clinerules/memory-system.md` +
  `templates/`) ne fait référence à aucun langage, framework ou SGBD.
- Les templates utilisent des formulations neutres ("Langage(s) :",
  "Framework(s) :") à remplir selon le projet réel.
- `database.md` est explicitement optionnel : un projet sans base de
  données indique simplement qu'il n'en a pas.
- Aucune commande, script ou outil spécifique à un écosystème n'est imposé
  par le système lui-même.

## Copier le système vers un autre projet

Identique pour tout projet, quelle que soit sa technologie : suivre
`INSTALL.md`. Résumé :

1. Copier `.clinerules/` (avec `memory-system.md` et `templates/`) à la
   racine du projet cible.
2. Vérifier les conflits avec une configuration IA existante (section
   suivante).
3. Fusionner le `.gitignore`.
4. Exécuter `INITIALIZE PROJECT MEMORY` dans ce nouveau projet.
5. Committer.

## Coexistence avec des configurations existantes

Si le projet cible possède déjà l'un de ces éléments, **ne pas les
supprimer** :

- un dossier `.clinerules/` avec d'autres règles ;
- un `CLAUDE.md` ou `AGENTS.md` ;
- un `README.md` jouant déjà un rôle de documentation de contexte.

### Comment coexister

- Si un `.clinerules/` existe déjà avec des règles non liées à la mémoire
  (ex: règles de style de code, règles de sécurité spécifiques), ajouter
  `memory-system.md` et les fichiers de mémoire à côté, sans toucher aux
  fichiers existants.
- Si `CLAUDE.md` ou `AGENTS.md` contiennent déjà des informations sur le
  projet qui recoupent `project.md` ou `architecture.md` : ne pas dupliquer
  le contenu. Documenter dans `project.md` (section "Fichiers de contexte
  IA existants") que ces fichiers existent, ce qu'ils couvrent, et lequel
  fait autorité en cas de chevauchement.
- Règle par défaut de priorité en cas de conflit non résolu explicitement :
  **le fichier le plus récemment mis à jour fait foi**, et l'incohérence
  doit être signalée à l'utilisateur plutôt que tranchée silencieusement.
- `.clinerules/README.md` de ce système peut être renommé ou fusionné si le
  projet a déjà un `README.md` à cet emplacement — le contenu prime sur le
  nom du fichier.

## Extension : ajouter une nouvelle catégorie de mémoire

Le système peut être étendu avec une nouvelle catégorie (ex:
`api-contracts.md`, `deployment.md`, `performance.md`) si un projet en a
réellement besoin.

1. Créer un nouveau template générique dans
   `cline-persistent-memory/.clinerules/templates/`, en suivant le même
   style que les templates existants (bloc de commentaire d'en-tête,
   sections en Markdown, aucune info métier).
2. Documenter son rôle dans `memory-system.md` (tableau des fichiers de
   mémoire) et dans ce fichier si la catégorie est suffisamment générale
   pour être proposée par défaut.
3. Ajouter la référence dans les procédures concernées
   (`INITIALIZE PROJECT MEMORY`, `MEMORY UPDATE`) si la nouvelle catégorie
   doit être maintenue automatiquement.
4. Incrémenter la version **MINOR** du système (`VERSION`,
   `CHANGELOG.md`).
5. Si la catégorie est spécifique à un seul projet plutôt qu'utile en
   général, la créer directement dans ce projet (Niveau 2) sans la
   remonter dans le système générique (Niveau 1).

## Test de portabilité

Objectif : vérifier que le système peut être installé dans un projet
totalement différent de tout projet métier existant (ne dépend pas de
`billing-erp` ni d'aucun projet particulier).

### Procédure de test

1. Créer un projet minimal et neutre, dans une technologie différente à
   chaque test si possible (ex: un petit projet Node.js, puis un petit
   projet Python), sans aucun lien avec un projet métier réel.
2. Copier `.clinerules/` de `cline-persistent-memory` dans ce projet.
3. Exécuter `INITIALIZE PROJECT MEMORY`.
4. Vérifier que :
   - les 7 fichiers attendus sont créés (ou 6 si le projet n'a pas de
     base de données, `database.md` étant alors omis ou marqué "N/A") ;
   - aucun fichier ne contient de référence à une technologie ou un
     domaine métier autre que ceux réellement présents dans ce projet de
     test ;
   - aucun secret n'a été copié dans la mémoire ;
   - le rapport de fin d'initialisation est cohérent avec le contenu
     réel du projet de test.
5. Répéter avec un second projet de technologie différente pour confirmer
   qu'aucune supposition technologique n'a été codée en dur dans le
   système.

Un script d'assistance à ce test est fourni dans
`cline-persistent-memory/tests/test-portability.sh` (voir ce repository).
Il ne fait que préparer un projet de test minimal ; l'exécution de
`INITIALIZE PROJECT MEMORY` elle-même se fait via Cline, pas via ce
script.
