# cline-persistent-memory

Système générique de **mémoire persistante** pour [Cline](https://github.com/cline/cline),
conçu pour être copié dans n'importe quel projet de développement afin qu'un
changement de modèle LLM (limite atteinte, changement volontaire, nouvelle
session) n'entraîne pas de perte de contexte.

## Le problème

Cline peut utiliser différents modèles LLM. Quand un modèle atteint sa
limite ou est remplacé par un autre, le nouveau modèle n'a **aucun accès**
à l'historique de conversation précédent. Sans mécanisme externe, il doit
repartir de zéro : re-analyser le projet, redemander le contexte à
l'utilisateur, risquer de répéter des erreurs déjà résolues ou de revenir
sur des décisions déjà prises.

## Le principe

Le **repository du projet lui-même devient la source de mémoire**. Un
ensemble de fichiers Markdown versionnés avec Git, rangés dans
`.clinerules/`, contient tout ce qu'un nouveau modèle doit savoir pour
reprendre le travail immédiatement :

- ce qu'est le projet et son objectif,
- son architecture et sa stack,
- son modèle de données (le cas échéant),
- son état actuel (dernier travail, en cours, prochaine étape),
- les décisions techniques prises et pourquoi,
- les tâches terminées / en cours / planifiées,
- les conventions à respecter.

**Le code réel reste toujours la source de vérité finale.** La mémoire est
un raccourci de contexte, jamais une autorité supérieure au code.

## Deux niveaux, complètement séparés

| Niveau | Contenu | Où |
|---|---|---|
| **1. Mécanisme générique** | Comment gérer la mémoire (règles, templates, procédures) | Ce repository |
| **2. Mémoire spécifique au projet** | Ce que Cline a réellement découvert sur *votre* projet | Copié dans chaque projet cible |

Le niveau 1 ne contient **aucune** information métier, aucune techno
imposée, aucune règle spécifique à un domaine. Il est indépendant de tout
projet.

## Structure du repository

```text
cline-persistent-memory/
│
├── README.md                  # Ce fichier
├── INSTALL.md                 # Comment installer le système dans un projet
├── CHANGELOG.md                # Historique des versions du système
├── VERSION                    # Version courante (semver)
├── .gitignore                 # Protection anti-secrets, générique
│
├── .clinerules/                # NIVEAU 1 - mécanisme générique, à copier tel quel
│   ├── README.md               # Vue d'ensemble du dossier .clinerules
│   ├── memory-system.md        # Règle principale : comportement de Cline
│   └── templates/              # Squelettes vides des fichiers de mémoire
│       ├── project.md
│       ├── architecture.md
│       ├── database.md
│       ├── current-state.md
│       ├── decisions.md
│       ├── tasks.md
│       └── conventions.md
│
└── docs/                       # Documentation d'usage détaillée
    ├── initialization.md       # Procédure INITIALIZE PROJECT MEMORY
    ├── resume.md                # Procédure PROJECT RESUME
    ├── maintenance.md          # Procédures MEMORY UPDATE / MEMORY AUDIT + tests
    ├── portability.md          # Comment installer le système ailleurs
    └── security.md              # Ce qui ne doit jamais être stocké
```

Quand le système est installé dans un projet cible, seuls `.clinerules/`
(règle + templates devenus fichiers remplis) sont copiés dans ce projet.
Le reste (`README.md`, `docs/`, tests) reste dans ce repository système
comme référence.

## Démarrage rapide

1. Lire `INSTALL.md` pour copier le système dans un projet cible.
2. Dans Cline, demander d'exécuter la procédure `INITIALIZE PROJECT MEMORY`
   (documentée dans `docs/initialization.md`).
3. À chaque nouvelle session ou changement de modèle, demander `PROJECT
   RESUME` (documenté dans `docs/resume.md`).
4. Après une modification importante, Cline applique `MEMORY UPDATE`.
5. Périodiquement, exécuter `MEMORY AUDIT` pour vérifier la cohérence de
   la mémoire (voir `docs/maintenance.md`).

## Contribuer / faire évoluer le système

Ce repository est indépendant de tout projet métier : les évolutions ici
profitent à tous les projets qui l'utilisent.

- Toute modification de `.clinerules/memory-system.md` ou des templates
  doit rester **générique** : aucune techno, aucun framework, aucune règle
  métier ne doit y apparaître.
- Documenter tout changement de comportement dans `CHANGELOG.md`.
- Incrémenter `VERSION` en suivant [semver](https://semver.org/) :
  - **MAJOR** : changement incompatible dans la structure des fichiers de
    mémoire ou dans une procédure existante.
  - **MINOR** : nouvelle procédure, nouveau template, nouvelle catégorie
    de mémoire, rétro-compatible.
  - **PATCH** : clarification, correction de documentation, sans impact
    sur la structure.
- Pour ajouter une nouvelle catégorie de mémoire (ex: `api-contracts.md`),
  suivre la procédure décrite dans `docs/portability.md#extension`.
- Toute nouvelle version doit être testée avec le scénario de passation
  Model A → Model B décrit dans `docs/maintenance.md`.

## Licence / statut

Système interne, à adapter librement selon vos besoins.
