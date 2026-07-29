# Server Update Command

Comando interattivo per aggiornare in sicurezza server Debian e Ubuntu tramite APT.

## Installazione

```bash
chmod +x install.sh
sudo ./install.sh
```

## Utilizzo

```bash
aggiorna
```

## Comportamento

- esegue `apt update`;
- mostra i pacchetti aggiornabili;
- chiede conferma prima di `apt upgrade`;
- non esegue automaticamente `full-upgrade`;
- non esegue automaticamente `autoremove`;
- segnala se è richiesto un riavvio;
- salva i log in `/var/log/server-update/`;
- crea un backup con rollback automatico durante l'installazione.

## Rollback

Usare lo script `rollback.sh` presente nella directory di backup mostrata al termine dell'installazione.
