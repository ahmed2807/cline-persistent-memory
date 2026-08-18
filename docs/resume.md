# PROJECT RESUME

Procédure exécutée à chaque fois qu'un modèle LLM commence à travailler
sur le projet sans avoir accès à la conversation précédente : nouvelle
session, changement de modèle (limite atteinte, changement volontaire),
reprise après une longue interruption.

Comment la déclencher : demander à Cline d'exécuter `PROJECT RESUME` en
début de session, ou l'appliquer par défaut au démarrage si le projet
contient déjà un dossier `.clinerules/` rempli.

## Étapes

1. Lire `.clinerules/project.md`.
2. Lire `.clinerules/current-state.md`.
3. Lire `.clinerules/tasks.md`.
4. Lire les autres fichiers de mémoire pertinents pour la tâche annoncée
   par l'utilisateur (`architecture.md`, `database.md`, `decisions.md`,
   `conventions.md`) — pas nécessairement tous, seulement ceux utiles.
5. Identifier les dernières modifications à partir de `current-state.md`
   et, si besoin, des derniers commits Git.
6. Identifier les problèmes connus (`current-state.md`, section "Known
   Bugs" de `tasks.md`).
7. Identifier la prochaine étape recommandée (`current-state.md`).
8. Vérifier dans le code réel les informations critiques avant de
   continuer — en particulier tout ce qui conditionne la tâche à venir.

## Règle de non-répétition

Si la mémoire persistante contient déjà les informations nécessaires
(objectif du projet, stack, état actuel...), **ne pas** redemander à
l'utilisateur de les réexpliquer. Cela va à l'encontre de l'objectif même
du système.

## En cas de contradiction entre la mémoire et le code

La mémoire persistante est une source de contexte pratique, mais **le
code réel reste la source de vérité finale**. Si une contradiction est
détectée :

1. La détecter explicitement (ne pas l'ignorer silencieusement).
2. Vérifier ce qu'il en est réellement dans le code.
3. Corriger le fichier de mémoire concerné pour refléter la réalité.
4. Continuer le travail sur la base de l'état réel, pas de l'ancienne
   mémoire.

## Résultat attendu

À la fin de cette procédure, le modèle doit être capable de reprendre le
travail comme s'il avait suivi toute la conversation précédente : il
comprend le projet, son état, ses problèmes connus, et sait quoi faire
ensuite — sans que l'utilisateur ait eu à tout réexpliquer.
