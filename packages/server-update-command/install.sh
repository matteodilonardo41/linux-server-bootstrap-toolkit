#!/bin/bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "ERRORE: eseguire con sudo: sudo ./install.sh" >&2
    exit 1
fi

SRC_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
SOURCE="$SRC_DIR/aggiorna"

TARGET="/usr/local/sbin/aggiorna"
LINK="/usr/local/bin/aggiorna"

STAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="/root/backup-server-update-$STAMP"

if [ ! -f "$SOURCE" ]; then
    echo "ERRORE: file sorgente non trovato: $SOURCE" >&2
    exit 1
fi

bash -n "$SOURCE"

mkdir -p \
    "$BACKUP_DIR/target" \
    "$BACKUP_DIR/link"

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
    touch "$BACKUP_DIR/target.existed"
    cp -a "$TARGET" "$BACKUP_DIR/target/"
fi

if [ -e "$LINK" ] || [ -L "$LINK" ]; then
    touch "$BACKUP_DIR/link.existed"
    cp -a "$LINK" "$BACKUP_DIR/link/"
fi

install -o root -g root -m 0755 "$SOURCE" "$TARGET"
ln -sfn "$TARGET" "$LINK"

cat > "$BACKUP_DIR/rollback.sh" <<ROLLBACK
#!/bin/bash
set -euo pipefail

BACKUP_DIR="$BACKUP_DIR"
TARGET="$TARGET"
LINK="$LINK"

rm -f "\$LINK" "\$TARGET"

if [ -f "\$BACKUP_DIR/target.existed" ]; then
    cp -a "\$BACKUP_DIR/target/aggiorna" "\$TARGET"
fi

if [ -f "\$BACKUP_DIR/link.existed" ]; then
    cp -a "\$BACKUP_DIR/link/aggiorna" "\$LINK"
fi

echo "Rollback completato."
ROLLBACK

chmod 700 "$BACKUP_DIR/rollback.sh"

echo
echo "Installazione completata."
echo "Comando disponibile: aggiorna"
echo "Log: /var/log/server-update/"
echo "Backup e rollback: $BACKUP_DIR"
