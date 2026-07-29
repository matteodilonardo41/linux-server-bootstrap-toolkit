#!/bin/bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "ERRORE: eseguire con sudo: sudo ./install.sh" >&2
    exit 1
fi

BASE_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
SOURCE_MOTD="$BASE_DIR/00-server-motd"
SOURCE_CONFIG="$BASE_DIR/server-motd.conf.example"

TARGET_MOTD="/etc/update-motd.d/00-server-motd"
TARGET_CONFIG="/etc/default/server-motd"

STAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="/root/backup-server-motd-$STAMP"

if [ ! -f "$SOURCE_MOTD" ] || [ ! -f "$SOURCE_CONFIG" ]; then
    echo "ERRORE: file sorgenti mancanti nella cartella del pacchetto." >&2
    exit 1
fi

bash -n "$SOURCE_MOTD"

mkdir -p "$BACKUP_DIR"

# Registra lo stato precedente per consentire un rollback fedele.
[ -e /etc/motd ] && touch "$BACKUP_DIR/motd.existed"
[ -d /etc/update-motd.d ] && touch "$BACKUP_DIR/update-motd.d.existed"
[ -e "$TARGET_CONFIG" ] && touch "$BACKUP_DIR/config.existed"

[ -e /etc/motd ] && cp -a /etc/motd "$BACKUP_DIR/motd"
[ -d /etc/update-motd.d ] && cp -a /etc/update-motd.d "$BACKUP_DIR/update-motd.d"
[ -e "$TARGET_CONFIG" ] && cp -a "$TARGET_CONFIG" "$BACKUP_DIR/server-motd"

mkdir -p /etc/update-motd.d /etc/default

echo "Aggiornamento indici APT..."
apt-get update

echo "Installazione dipendenze..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    figlet \
    debsecan \
    iputils-arping

install -o root -g root -m 0755 "$SOURCE_MOTD" "$TARGET_MOTD"

# Non sovrascrive una configurazione già personalizzata.
if [ ! -e "$TARGET_CONFIG" ]; then
    install -o root -g root -m 0644 "$SOURCE_CONFIG" "$TARGET_CONFIG"
fi

# Disattiva gli altri generatori per mostrare un unico banner uniforme.
find /etc/update-motd.d \
    -maxdepth 1 \
    -type f \
    ! -name '00-server-motd' \
    -exec chmod -x {} +

: > /etc/motd

cat > "$BACKUP_DIR/rollback.sh" <<ROLLBACK
#!/bin/bash
set -euo pipefail

BACKUP_DIR="$BACKUP_DIR"
TARGET_CONFIG="$TARGET_CONFIG"

rm -rf /etc/update-motd.d

if [ -f "\$BACKUP_DIR/update-motd.d.existed" ]; then
    cp -a "\$BACKUP_DIR/update-motd.d" /etc/update-motd.d
else
    mkdir -p /etc/update-motd.d
fi

rm -f /etc/motd

if [ -f "\$BACKUP_DIR/motd.existed" ]; then
    cp -a "\$BACKUP_DIR/motd" /etc/motd
fi

rm -f "\$TARGET_CONFIG"

if [ -f "\$BACKUP_DIR/config.existed" ]; then
    cp -a "\$BACKUP_DIR/server-motd" "\$TARGET_CONFIG"
fi

echo "Rollback completato."
ROLLBACK

chmod 700 "$BACKUP_DIR/rollback.sh"

echo
echo "Installazione completata."
echo "Configurazione: $TARGET_CONFIG"
echo "Backup e rollback: $BACKUP_DIR"
echo
echo "Anteprima:"
run-parts /etc/update-motd.d
