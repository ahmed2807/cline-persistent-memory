# Simulation du test de cohérence — Model A → Model B

Ce document trace une simulation du scénario décrit dans
`docs/maintenance.md#test-de-cohérence-scénario-model-a--model-b`, réalisée
sur un projet de test fictif et neutre (aucun lien avec `billing-erp`).

## Contexte simulé

Projet de test : `sample-node` (voir `tests/test-portability.sh`), une
petite API Node.js fictive.

## Étape 1 — Model A

1. Model A copie `.clinerules/` dans `sample-node/` et exécute
   `INITIALIZE PROJECT MEMORY`.
   - Découverte : projet Node.js, `package.json` minimal, pas de base de
     données détectée, pas de tests existants.
   - Fichiers créés : `project.md`, `architecture.md`, `current-state.md`,
     `decisions.md`, `tasks.md`, `conventions.md`.
     `database.md` marqué "Ce projet ne possède pas de base de données".
2. Model A ajoute un endpoint `/health`, écrit un test associé, et prend
   la décision technique d'utiliser `express` comme framework HTTP.
3. Model A applique `MEMORY UPDATE` :
   - `current-state.md` : "Dernier travail effectué : ajout de l'endpoint
     `/health` avec test associé. Tests : 1 test, passe."
   - `tasks.md` : tâche "Ajouter endpoint /health" déplacée vers
     *Completed*. Tâche "Ajouter authentification" ajoutée dans *Planned*.
   - `decisions.md` : nouvelle entrée — Decision: "Utiliser Express comme
     framework HTTP" / Reason: "Standard, léger, écosystème large" /
     Alternatives considered: "Fastify (écarté pour rester simple à ce
     stade)" / Consequence: "Toutes les routes suivent le pattern Express
     middleware."
   - `architecture.md` : section "Modules" mise à jour avec le module
     `routes/health.js`.
4. Model A atteint sa limite d'utilisation (fin de session simulée).

## Étape 2 — Passage à Model B

Nouvelle session, aucun accès à la conversation de Model A. Model B ne
dispose que du repository `sample-node/` avec son `.clinerules/` rempli.

## Étape 3 — Model B exécute PROJECT RESUME

1. Lit `project.md` → comprend que c'est une API Node.js de test.
2. Lit `current-state.md` → comprend que le dernier travail est l'ajout de
   `/health` avec un test qui passe, et voit la prochaine étape
   recommandée.
3. Lit `tasks.md` → voit que "Ajouter endpoint /health" est terminé et
   que "Ajouter authentification" est planifié.
4. Lit `decisions.md` → comprend pourquoi Express a été choisi plutôt que
   Fastify.
5. Lit `architecture.md` → localise le module `routes/health.js`.
6. Vérifie dans le code réel que `routes/health.js` existe bien et que le
   test associé passe — confirmation, pas de contradiction détectée.
7. Peut immédiatement proposer de commencer "Ajouter authentification"
   sans redemander à l'utilisateur d'expliquer le projet.

## Résultat

Tous les critères de réussite du test de cohérence sont couverts :
projet et objectif (`project.md`), architecture (`architecture.md`),
état actuel et dernières modifications (`current-state.md`), tâches
terminées/en cours (`tasks.md`), décisions et raisons (`decisions.md`),
prochaine étape (`current-state.md`). Aucune information essentielle
manquante n'a été identifiée pour ce scénario.

## Limite identifiée

Si Model A avait pris une décision technique **sans** appliquer `MEMORY
UPDATE` ensuite (oubli), Model B n'aurait aucun moyen de le savoir sans
relire l'historique Git complet. C'est une limite structurelle : la
mémoire persistante ne vaut que ce que les mises à jour successives y ont
consigné. Voir recommandations pour la v1.1 dans le rapport final de la
mission.
