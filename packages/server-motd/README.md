# Server MOTD

Banner dinamico e configurabile per server Debian e Ubuntu.

## Funzionalità

- nome macchina, descrizione e versione configurabili;
- hostname, sistema operativo, IP, data e ora;
- aggiornamenti APT disponibili;
- correzioni di sicurezza realmente installabili;
- stato riavvio, uptime, load average e utenti attivi;
- utilizzo disco, memoria, swap e numero processi;
- controllo Machine-ID e IP duplicato best-effort;
- backup e rollback automatici.

## Installazione

```bash
chmod +x install.sh
sudo ./install.sh
```

## Configurazione

Modificare `/etc/default/server-motd`.

```bash
DISPLAY_NAME="APP-SRV-01"
DESCRIPTION="Application server"
APP_VERSION="1.0.0"
NETWORK_INTERFACE=""
TEMPLATE_MACHINE_ID=""
```

## Anteprima

```bash
sudo run-parts /etc/update-motd.d
```

## Vulnerabilità

Il controllo conta solo i pacchetti installati per cui debsecan indica una correzione e APT propone una versione candidata realmente superiore a quella installata.

## Rollback

Usare lo script `rollback.sh` presente nella directory di backup mostrata al termine dell'installazione.
