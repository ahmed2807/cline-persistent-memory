# Installation dans un projet

Ces étapes copient le **niveau 1 (mécanisme générique)** dans un projet
cible. Elles ne touchent à aucun code métier.

## 1. Copier le dossier `.clinerules/`

Depuis ce repository, copier le dossier `.clinerules/` (règle + templates)
à la racine du projet cible.

```bash
cp -r cline-persistent-memory/.clinerules /chemin/vers/mon-projet/
```

## 2. Vérifier les conflits avec l'existant

Avant d'aller plus loin, vérifier si le projet cible possède déjà :

- un dossier `.clinerules/` existant,
- des règles Cline personnalisées,
- un `CLAUDE.md`, un `AGENTS.md`, ou un autre fichier de contexte IA,
- un `README.md` déjà volumineux jouant un rôle similaire.

**Ne rien supprimer.** Si un conflit existe, voir
`docs/portability.md#coexistence-avec-des-configurations-existantes` pour
la marche à suivre (fusion, priorité, renvoi croisé).

## 3. Fusionner le `.gitignore`

Ajouter les lignes du `.gitignore` de ce système à celui du projet cible
(ne pas écraser le `.gitignore` existant du projet).

## 4. Initialiser la mémoire du projet

Dans Cline, sur le projet cible, demander d'exécuter :

```text
INITIALIZE PROJECT MEMORY
```

Voir `docs/initialization.md` pour le détail de cette procédure. Elle va
analyser le projet réel et remplir les templates vides
(`.clinerules/templates/*.md`) sous forme de fichiers de mémoire réels
placés directement dans `.clinerules/` (ex: `.clinerules/project.md`).

## 5. Committer

```bash
cd mon-projet
git add .clinerules/
git commit -m "chore: initialisation de la mémoire persistante Cline"
```

## 6. Utilisation quotidienne

Voir `docs/resume.md` et `docs/maintenance.md` pour l'usage courant
(`PROJECT RESUME`, `MEMORY UPDATE`, `MEMORY AUDIT`).

## Désinstallation

Le système est autonome : supprimer `.clinerules/` (ou seulement les
fichiers de mémoire générés, en conservant d'autres règles Cline
existantes si elles vivent dans le même dossier) suffit à retirer le
système sans effet de bord sur le code du projet.
