# Changelog

Toutes les modifications notables de ce système sont documentées ici.
Format inspiré de [Keep a Changelog](https://keepachangelog.com/).

## [1.0.0] - Version initiale

### Ajouté

- Structure générique en deux niveaux : mécanisme (`.clinerules/`) et mémoire projet.
- Règle principale `memory-system.md` définissant le comportement de Cline.
- 7 templates de mémoire : `project.md`, `architecture.md`, `database.md`,
  `current-state.md`, `decisions.md`, `tasks.md`, `conventions.md`.
- Quatre procédures : `INITIALIZE PROJECT MEMORY`, `PROJECT RESUME`,
  `MEMORY UPDATE`, `MEMORY AUDIT`.
- Documentation complète : installation, initialisation, reprise,
  maintenance, portabilité, sécurité.
- Protections de sécurité contre l'enregistrement de secrets.
- `.gitignore` générique protégeant contre les fuites de credentials.
- Scripts de test de cohérence et de portabilité.

### Notes

- Version testée avec un scénario simulé de passation entre deux modèles LLM
  (voir `docs/maintenance.md#test-de-cohérence`).
- Aucune dépendance technologique obligatoire.
