# Esempi di output

## Server MOTD

```text
APP-SRV-01

 Benvenuto su   : APP-SRV-01
 Hostname       : app-srv-01.example.net
 Versione       : 1.0.0
 Linux Version  : Debian GNU/Linux
 Aggiornamenti  : 3 pacchetti aggiornabili
 Vulnerabilità  : 1 pacchetto con correzione di sicurezza disponibile
 Riavvio        : Riavvio non necessario
 Uptime         : 5 days, 3 hours
 Prestazioni    : Last Minute: 0.12, Last 5 Minutes: 0.08, Last 15 Minutes: 0.04
 Utenti Attivi  : 1 (admin)
 IP Address     : 192.0.2.10 - IP OK
 Orario         : Wed Jul 29 12:45:00 CEST 2026
 Disco Usato    : 34%
 Memoria Usata  : 42%
 Swap Usata     : 0%
 Processi       : 118
 Clone_Macchina : OK - Macchina Clonata Correttamente
 Machine-ID     : 0123456789abcdef0123456789abcdef
```

## Comando aggiorna

```text
========================================
 Aggiornamento sistema: app-srv-01
 Avvio: Wed Jul 29 12:45:00 CEST 2026
 Log: /var/log/server-update/aggiorna-20260729_124500.log
========================================

[1/4] Aggiornamento indici APT

[2/4] Pacchetti aggiornabili
example-package/stable 1.2.3 amd64 [upgradable from: 1.2.2]

Procedere con apt upgrade? [s/N] s

[3/4] Installazione aggiornamenti

[4/4] Verifica finale
Aggiornamento completato: riavvio non richiesto.
```

Gli indirizzi, hostname, pacchetti e identificativi mostrati sono esclusivamente esempi fittizi.
