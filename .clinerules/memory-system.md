# Memory System — Règle générique pour Cline

> Ce fichier fait partie du **Niveau 1 (mécanisme générique)** du système
> `cline-persistent-memory`. Il ne contient et ne doit jamais contenir
> aucune information spécifique à un projet (nom de projet, technologie,
> base de données, règle métier, framework imposé).
>
> Version du système : voir `VERSION` à la racine de
> `cline-persistent-memory`.

## Principe fondamental

Ce projet utilise un système de mémoire persistante versionné avec Git,
situé dans `.clinerules/`. Cette mémoire permet à n'importe quel modèle
LLM utilisé par Cline de reprendre le travail sans avoir accès à
l'historique de conversation précédent.

**Règle absolue : le code réel du projet est toujours la source de vérité
finale.** La mémoire persistante est un raccourci de contexte, jamais une
autorité qui prime sur le code. En cas de contradiction entre la mémoire
et le code, c'est le code qui a raison, et la mémoire doit être corrigée.

## Fichiers de mémoire du projet

Une fois le système initialisé sur un projet (voir procédure
`INITIALIZE PROJECT MEMORY` plus bas), les fichiers suivants existent à la
racine de `.clinerules/` et constituent le **Niveau 2 (mémoire spécifique
au projet)** :

| Fichier | Rôle | Fréquence de mise à jour |
|---|---|---|
| `project.md` | Identité du projet : nom, objectif, stack, environnement, commandes | Rare (info stable) |
| `architecture.md` | Architecture générale, modules, flux, intégrations | Quand l'architecture change |
| `database.md` | Modèle de données, si le projet en a un — jamais de secrets | Quand le schéma change |
| `current-state.md` | Mémoire opérationnelle : dernier travail, en cours, problèmes connus, prochaine étape | Fréquente, à chaque tâche importante |
| `decisions.md` | Décisions techniques importantes et leur justification | À chaque décision structurante |
| `tasks.md` | Tâches Completed / In Progress / Planned / Known Bugs / Priorities | Fréquente |
| `conventions.md` | Conventions de code, nommage, tests, sécurité, Git détectées ou décidées | Quand une convention est établie ou détectée |

Ces fichiers sont initialement vides (voir `templates/`) et sont remplis
uniquement avec des informations réellement découvertes dans le projet
réel — jamais inventées.

## Comportement attendu de Cline

### Au début d'une tâche importante

1. Lire `.clinerules/project.md`.
2. Lire `.clinerules/current-state.md`.
3. Lire `.clinerules/tasks.md`.
4. Lire uniquement les autres fichiers de mémoire pertinents pour la tâche
   en cours (`architecture.md`, `database.md`, `decisions.md`,
   `conventions.md`) — pas systématiquement tous.
5. Analyser ensuite seulement le code nécessaire à la tâche. Ne pas
   charger l'intégralité du repository dans le contexte.

### Pendant le travail

Mettre à jour le fichier concerné dès qu'un événement pertinent survient :

- Décision technique importante prise → `decisions.md`.
- Architecture modifiée → `architecture.md`.
- Modèle de données modifié → `database.md`.
- Tâche importante terminée → `tasks.md`.
- État du projet modifié (nouveau travail en cours, bug découvert, test
  cassé...) → `current-state.md`.
- Convention détectée ou décidée → `conventions.md`.

Ne mettre à jour que les fichiers réellement concernés. Ne pas transformer
`current-state.md` ou `tasks.md` en journal de conversation : rester
factuel et concis.

### À la fin d'une tâche importante

1. Vérifier et mettre à jour si besoin : `current-state.md`, `tasks.md`.
2. Mettre à jour si nécessaire : `decisions.md`, `architecture.md`,
   `database.md`, `conventions.md`.
3. Vérifier que la mémoire correspond réellement à l'état du code (pas
   seulement à ce qui était prévu de faire).

## Procédures disponibles

Ce système définit quatre procédures. Elles sont invoquées par leur nom
exact, en toutes lettres, par l'utilisateur ou par Cline lui-même quand le
contexte l'exige.

- **`INITIALIZE PROJECT MEMORY`** — à exécuter une seule fois, lors de
  l'installation du système dans un nouveau projet. Détaillée dans
  `docs/initialization.md` du repository `cline-persistent-memory`.
- **`PROJECT RESUME`** — à exécuter quand un nouveau modèle LLM commence à
  travailler sur le projet (nouvelle session, changement de modèle, reprise
  après interruption). Détaillée dans `docs/resume.md`.
- **`MEMORY UPDATE`** — à exécuter après une modification importante, pour
  répercuter les changements dans les fichiers de mémoire concernés.
  Détaillée dans `docs/maintenance.md`.
- **`MEMORY AUDIT`** — à exécuter périodiquement pour vérifier que la
  mémoire correspond toujours au projet réel. Détaillée dans
  `docs/maintenance.md`.

Résumé opérationnel minimal (si la documentation complète n'est pas
disponible dans le contexte) :

### INITIALIZE PROJECT MEMORY (résumé)

1. Analyser le projet existant (structure, langage, framework, dépendances,
   config, architecture, base de données, tests, CI/CD, Git, fichiers de
   contexte IA existants) sans tout charger d'un coup — commencer par la
   config et la doc, puis le code nécessaire.
2. Vérifier l'existence de `.clinerules`, `CLAUDE.md`, `AGENTS.md`,
   `README.md` ou autres fichiers de contexte IA déjà présents, sans les
   supprimer.
3. Remplir les templates (`project.md`, `architecture.md`, `database.md`,
   `current-state.md`, `decisions.md`, `tasks.md`, `conventions.md`) avec
   uniquement des informations vérifiées dans le code réel.
4. Valider chaque information importante contre le code réel avant de
   l'écrire. Ne jamais présenter une hypothèse comme un fait — marquer
   explicitement ce qui est incertain ou inconnu.
5. Produire un rapport : fichiers créés, fichiers réutilisés, informations
   détectées, informations indéterminées, conflits éventuels,
   recommandations.

### PROJECT RESUME (résumé)

1. Lire `project.md`, `current-state.md`, `tasks.md`, puis les autres
   fichiers pertinents.
2. Identifier les dernières modifications, les problèmes connus, la
   prochaine étape recommandée.
3. Vérifier dans le code les informations critiques avant de continuer.
4. Ne pas redemander à l'utilisateur d'expliquer le projet si la mémoire
   contient déjà l'information.
5. Si la mémoire contredit le code : détecter le conflit, vérifier le
   code, corriger la mémoire, continuer avec l'état réel.

### MEMORY UPDATE (résumé)

1. Déterminer quels fichiers de mémoire sont concernés par la modification
   qui vient d'être faite.
2. Ne modifier que ces fichiers-là.
3. Rester factuel, concis, daté si pertinent.

### MEMORY AUDIT (résumé)

1. Rechercher : informations obsolètes, architecture incorrecte, tâches
   terminées mais encore listées comme ouvertes, décisions dépassées,
   documentation incohérente, références à des fichiers supprimés,
   contradictions internes, secrets accidentellement présents.
2. Produire un rapport clair.
3. Ne pas corriger automatiquement une information importante et ambiguë
   sans validation de l'utilisateur.

## Coexistence avec d'autres configurations Cline

Si le projet possède déjà des règles Cline, un `CLAUDE.md`, un `AGENTS.md`
ou une autre configuration IA :

- Ne jamais les supprimer.
- Documenter dans `project.md` (section "Fichiers de contexte IA
  existants") quels fichiers existent et lequel est prioritaire en cas de
  chevauchement.
- Éviter de dupliquer une information déjà présente ailleurs : y renvoyer
  plutôt que la recopier.

## Sécurité — interdictions absolues

Ne jamais écrire dans un fichier de mémoire :

- mots de passe, API keys, tokens, secrets, credentials ;
- contenu de fichiers `.env` ;
- clés privées ou certificats ;
- informations personnelles sensibles.

Si une telle information est rencontrée pendant l'analyse du projet, ne
pas la recopier — décrire seulement son existence et son emplacement
(ex: "les credentials de connexion à la base sont dans `.env`, non
versionné"). Voir `docs/security.md` pour le détail.
