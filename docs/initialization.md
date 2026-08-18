# INITIALIZE PROJECT MEMORY

Procédure exécutée **une seule fois**, lors de l'installation du système
dans un nouveau projet. Elle construit la mémoire initiale (Niveau 2) à
partir de l'analyse réelle du projet.

Comment la déclencher : demander explicitement à Cline d'exécuter
`INITIALIZE PROJECT MEMORY`, après avoir copié `.clinerules/` dans le
projet (voir `INSTALL.md`).

## Étape 1 — Découverte

Analyser le projet existant avant de modifier quoi que ce soit. Identifier
notamment :

- structure générale du repository ;
- langage(s) et framework(s) ;
- versions importantes ;
- dépendances principales ;
- fichiers de configuration ;
- architecture apparente ;
- base de données (le cas échéant) et migrations ;
- tests existants et leur état ;
- documentation existante ;
- CI/CD ;
- historique Git récent (derniers commits significatifs) ;
- fichiers de contexte IA déjà présents : `.clinerules` existant,
  `CLAUDE.md`, `AGENTS.md`, `README.md`, autres.

## Étape 2 — Stratégie d'analyse efficace

Ne pas charger l'intégralité du repository dans le contexte. Procéder par
étapes :

1. Fichiers de configuration et manifestes de dépendances (ex:
   `package.json`, `composer.json`, `pyproject.toml`, `pom.xml`, `.csproj`,
   `go.mod`...).
2. Documentation existante (`README.md`, `docs/`, wikis locaux).
3. Structure des dossiers (vue d'ensemble, pas le contenu de chaque
   fichier).
4. Code source, uniquement les fichiers nécessaires pour confirmer ou
   compléter ce que la configuration et la doc indiquent déjà.
5. Base de données : schémas/migrations si présents, sans se connecter à
   une base réelle ni lire de fichier `.env`.

## Étape 3 — Construire la mémoire

Créer, dans `.clinerules/` (à la racine du dossier, pas dans
`templates/`), les fichiers suivants, à partir des templates
correspondants :

```text
.clinerules/project.md
.clinerules/architecture.md
.clinerules/database.md          (uniquement si le projet a une base de données)
.clinerules/current-state.md
.clinerules/decisions.md
.clinerules/tasks.md
.clinerules/conventions.md
```

Remplir chaque section avec des informations réellement observées.
Laisser une section vide ou marquée "Non déterminé" plutôt que de deviner.

## Étape 4 — Validation

Après génération, revérifier chaque information importante contre le code
réel avant de la considérer comme définitive. Ne jamais présenter une
hypothèse comme un fait établi — si une information est déduite plutôt que
vérifiée, le signaler explicitement dans le fichier concerné (ex: "Stack
supposée d'après les dépendances, non confirmée par la documentation").

## Étape 5 — Rapport

Produire un rapport listant :

- fichiers créés ;
- fichiers existants réutilisés (le cas échéant) ;
- informations détectées avec confiance ;
- informations qui n'ont pas pu être déterminées ;
- conflits éventuels avec une configuration IA préexistante
  (`.clinerules`, `CLAUDE.md`, `AGENTS.md`...) et comment ils ont été
  résolus (voir `portability.md#coexistence-avec-des-configurations-existantes`) ;
- recommandations pour la suite.

## Ce que cette procédure ne fait pas

- Elle ne modifie aucun fichier de code métier.
- Elle ne supprime aucune configuration IA existante.
- Elle ne lit ni ne recopie le contenu de fichiers `.env` ou de secrets.
- Elle ne s'exécute normalement qu'une fois par projet ; une réexécution
  ultérieure doit être traitée comme une mise à jour explicite, pas comme
  un remplacement automatique de la mémoire existante.
