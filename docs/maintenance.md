# Maintenance de la mémoire : MEMORY UPDATE et MEMORY AUDIT

## MEMORY UPDATE

À exécuter après une modification importante du projet (fonctionnalité
livrée, décision technique prise, architecture changée, bug corrigé,
schéma de base de données modifié...).

### Étapes

1. Identifier ce qui vient de changer.
2. Déterminer lesquels des fichiers suivants sont concernés :
   - `current-state.md` — quasi systématiquement, dès qu'un travail
     avance.
   - `tasks.md` — si une tâche change de statut.
   - `decisions.md` — uniquement si une décision technique structurante a
     été prise (pas pour chaque petit choix).
   - `architecture.md` — si l'architecture a changé.
   - `database.md` — si le modèle de données a changé.
   - `conventions.md` — si une convention a été établie ou détectée.
3. Ne modifier que les fichiers réellement concernés — ne pas toucher aux
   autres.
4. Rester factuel et concis. Dater les entrées quand c'est pertinent
   (`decisions.md`, en-tête de `current-state.md`).

### Ce qu'il ne faut pas faire

- Ne pas transformer `current-state.md` ou `tasks.md` en journal complet
  de conversation.
- Ne pas enregistrer de décision mineure dans `decisions.md`.
- Ne jamais écrire de secret, credential, token ou clé (voir
  `security.md`).

## MEMORY AUDIT

À exécuter périodiquement (par exemple au début d'une session de travail
conséquente, ou à intervalle régulier décidé par l'équipe) pour vérifier
que la mémoire correspond toujours au projet réel.

### Ce qu'il faut rechercher

- Informations obsolètes (ex: une dépendance ou version qui a changé).
- Architecture décrite qui ne correspond plus au code.
- Tâches marquées "In Progress" ou "Planned" alors qu'elles sont en
  réalité terminées, ou l'inverse.
- Décisions dans `decisions.md` qui ont depuis été remplacées par une
  autre décision non documentée.
- Documentation interne incohérente entre les fichiers (ex:
  `architecture.md` et `database.md` qui se contredisent).
- Références à des fichiers, modules ou tables qui n'existent plus dans le
  code.
- Contradictions internes à un même fichier.
- Secrets accidentellement présents dans un fichier de mémoire (voir
  `security.md` pour la procédure de détection).

### Résultat attendu

Produire un rapport clair listant, pour chaque fichier de mémoire :

- ce qui est toujours correct ;
- ce qui est obsolète ou incorrect ;
- ce qui est ambigu et nécessite une décision humaine.

### Règle de prudence

Ne pas corriger automatiquement une information importante si le
changement pourrait être ambigu ou impacter la compréhension du projet —
signaler dans le rapport et demander validation avant modification. Les
corrections évidentes et non ambiguës (ex: une tâche clairement terminée
d'après le code et les tests) peuvent être appliquées directement, en le
mentionnant dans le rapport.

---

## Test de cohérence (scénario Model A → Model B)

Ce test valide que le système fonctionne réellement comme prévu : un
second modèle, sans aucun accès à la conversation du premier, doit pouvoir
reprendre le travail à partir de la seule mémoire persistante.

### Scénario

1. **Model A** travaille sur un projet : il exécute `INITIALIZE PROJECT
   MEMORY`, réalise plusieurs modifications, prend plusieurs décisions
   techniques, met à jour la mémoire via `MEMORY UPDATE` au fur et à
   mesure.
2. Model A atteint sa limite d'utilisation (simulé : fin de la session).
3. L'utilisateur passe à **Model B**, dans une session totalement
   nouvelle, sans aucun accès à la conversation de Model A.
4. Model B exécute `PROJECT RESUME` en ne disposant que du repository et
   de la mémoire persistante.

### Critères de réussite

Model B doit être capable, à l'issue de `PROJECT RESUME`, d'expliquer sans
aide supplémentaire de l'utilisateur :

- ce qu'est le projet et son objectif ;
- son architecture ;
- son état actuel ;
- les dernières modifications faites par Model A ;
- les tâches terminées et en cours ;
- les problèmes connus ;
- les décisions techniques prises et leurs raisons ;
- la prochaine étape recommandée.

Si une de ces informations manque ou est insuffisante, c'est le système
(templates, règle `memory-system.md`, procédures) qui doit être amélioré —
pas seulement le contenu d'un projet particulier.

### Résultat de la validation de la version 1.0.0

Un test de cohérence a été simulé lors de la conception de cette version
(voir rapport final de la mission). Les 7 fichiers de mémoire couvrent
ensemble l'intégralité des 8 points ci-dessus : `project.md` +
`architecture.md` pour le projet et son architecture, `current-state.md`
pour l'état/dernières modifications/prochaine étape, `tasks.md` pour les
tâches, `decisions.md` pour les décisions, `database.md` si applicable.
Aucun point n'est resté sans fichier porteur.

---

## Test de portabilité

Voir `portability.md#test-de-portabilité` pour la procédure et le script
de test permettant de vérifier que le système peut être installé dans un
projet totalement différent, indépendamment de toute technologie
particulière.
