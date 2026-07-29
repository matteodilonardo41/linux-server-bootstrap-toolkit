# Architettura

Il toolkit è composto da due moduli indipendenti, installabili separatamente.

## Server MOTD

File principali:

- `00-server-motd`: genera il banner dinamico;
- `server-motd.conf.example`: configurazione di esempio;
- `install.sh`: installazione, backup e creazione del rollback.

Percorsi utilizzati sul server:

- `/etc/update-motd.d/00-server-motd`;
- `/etc/default/server-motd`;
- `/root/backup-server-motd-YYYYMMDD_HHMMSS/`.

## Server Update Command

File principali:

- `aggiorna`: comando interattivo per APT;
- `install.sh`: installazione, backup e creazione del rollback.

Percorsi utilizzati sul server:

- `/usr/local/sbin/aggiorna`;
- `/usr/local/bin/aggiorna`;
- `/var/log/server-update/`;
- `/root/backup-server-update-YYYYMMDD_HHMMSS/`.

## Principi di progetto

- componenti separati e riutilizzabili;
- configurazione esterna agli script;
- nessuna sovrascrittura della configurazione MOTD esistente;
- backup prima di ogni modifica;
- rollback dello stato precedente;
- nessun dato infrastrutturale reale incluso nel repository.
