#!/usr/bin/env bash
#
# test-portability.sh
#
# Prépare un (ou plusieurs) projet(s) de test minimal(aux), totalement
# indépendant(s) de tout projet métier existant (ne touche jamais à
# billing-erp ni à aucun projet réel), et y copie le mécanisme générique
# .clinerules/. L'exécution de INITIALIZE PROJECT MEMORY elle-même se fait
# ensuite via Cline (ce script ne simule pas un LLM).
#
# Usage:
#   ./tests/test-portability.sh [dossier_de_sortie]
#
# Par défaut, crée les projets de test sous /tmp/cline-memory-portability-test

set -euo pipefail

SYSTEM_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${1:-/tmp/cline-memory-portability-test}"

echo "== Test de portabilité — cline-persistent-memory =="
echo "Repository système : $SYSTEM_ROOT"
echo "Dossier de sortie  : $OUT_DIR"
echo

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

create_sample_project () {
  local name="$1"
  local kind="$2"
  local dir="$OUT_DIR/$name"
  mkdir -p "$dir"

  case "$kind" in
    node)
      cat > "$dir/package.json" <<'EOF'
{
  "name": "sample-node-project",
  "version": "0.1.0",
  "scripts": { "start": "node index.js", "test": "echo \"no tests yet\"" },
  "dependencies": {}
}
EOF
      echo "console.log('sample node project');" > "$dir/index.js"
      echo "# Sample Node Project" > "$dir/README.md"
      ;;
    python)
      cat > "$dir/pyproject.toml" <<'EOF'
[project]
name = "sample-python-project"
version = "0.1.0"
EOF
      echo "print('sample python project')" > "$dir/main.py"
      echo "# Sample Python Project" > "$dir/README.md"
      ;;
    *)
      echo "Type de projet inconnu: $kind" >&2
      exit 1
      ;;
  esac

  echo "Projet de test créé : $dir (type: $kind)"
}

create_sample_project "sample-node" "node"
create_sample_project "sample-python" "python"

for proj in "$OUT_DIR"/*/; do
  echo
  echo "-- Copie de .clinerules dans $proj --"
  cp -r "$SYSTEM_ROOT/.clinerules" "$proj"

  # Vérifications automatiques de base (le fond de INITIALIZE PROJECT
  # MEMORY reste manuel / piloté par Cline)
  if [ ! -f "${proj}.clinerules/memory-system.md" ]; then
    echo "ÉCHEC: memory-system.md manquant dans $proj" >&2
    exit 1
  fi

  missing_templates=0
  for tpl in project architecture database current-state decisions tasks conventions; do
    if [ ! -f "${proj}.clinerules/templates/${tpl}.md" ]; then
      echo "ÉCHEC: template ${tpl}.md manquant dans $proj" >&2
      missing_templates=1
    fi
  done
  if [ "$missing_templates" -eq 1 ]; then
    exit 1
  fi

  echo "OK: structure .clinerules valide dans $proj"
done

echo
echo "== Résultat =="
echo "Les projets de test sont prêts sous: $OUT_DIR"
echo "Prochaine étape manuelle : ouvrir chaque projet dans Cline et exécuter"
echo "la procédure INITIALIZE PROJECT MEMORY, puis vérifier le rapport produit"
echo "(voir docs/portability.md#test-de-portabilité)."
