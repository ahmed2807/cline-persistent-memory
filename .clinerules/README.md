# .clinerules/ — Mécanisme de mémoire persistante

Ce dossier est le seul dossier copié tel quel dans un projet cible lors de
l'installation du système (voir `INSTALL.md` à la racine de
`cline-persistent-memory`).

## Contenu

- `memory-system.md` — la règle générique lue par Cline, qui définit le
  comportement à adopter (Niveau 1, générique, aucune info métier).
- `templates/` — squelettes vides des 7 fichiers de mémoire. Ils servent
  de point de départ lors de `INITIALIZE PROJECT MEMORY`.

## Après initialisation dans un projet

Une fois `INITIALIZE PROJECT MEMORY` exécutée sur un projet, ce dossier
contient en plus, à sa racine (pas dans `templates/`) :

```text
.clinerules/
├── README.md
├── memory-system.md
├── project.md            ← créé, Niveau 2 (spécifique au projet)
├── architecture.md       ← créé, Niveau 2
├── database.md           ← créé si le projet a une base de données
├── current-state.md      ← créé, Niveau 2
├── decisions.md          ← créé, Niveau 2
├── tasks.md               ← créé, Niveau 2
├── conventions.md        ← créé, Niveau 2
└── templates/             ← conservé, pour référence et pour d'autres projets
```

Les fichiers `templates/*.md` ne sont jamais modifiés directement : ils
servent de modèle. Les fichiers réels du projet sont créés à côté, à la
racine de `.clinerules/`.
