#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "[1/4] Controllo sintassi Bash"
find packages -type f \
    \( -name '*.sh' -o -name 'aggiorna' -o -name '00-server-motd' \) \
    -print0 |
while IFS= read -r -d '' file; do
    bash -n "$file"
    printf 'OK  %s\n' "$file"
done

echo
echo "[2/4] Controllo riferimenti sensibili"
if grep -RniE \
    --exclude="validate.sh" \
    'SPVL|spvl|RDA|\.local|password|passwd|token|secret|api[_-]?key' \
    packages scripts .github 2>/dev/null; then
    echo "ERRORE: trovati possibili riferimenti sensibili." >&2
    exit 1
fi
echo "OK  Nessun riferimento sensibile rilevato"

echo
echo "[3/4] Controllo IP"
if grep -RniE \
    --exclude="validate.sh" \
    '([0-9]{1,3}\.){3}[0-9]{1,3}' \
    packages scripts .github 2>/dev/null |
    grep -vE '192\.0\.2\.|198\.51\.100\.|203\.0\.113\.'; then
    echo "ERRORE: trovato un IP non appartenente alle reti di documentazione." >&2
    exit 1
fi
echo "OK  Nessun IP reale rilevato"

echo
echo "[4/4] File pubblicabili"
git ls-files --cached --others --exclude-standard | sort

echo
echo "VALIDAZIONE_COMPLETATA"
