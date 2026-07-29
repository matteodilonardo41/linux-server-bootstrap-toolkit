# Sicurezza

## Dati esclusi dal repository

Il progetto pubblico non deve contenere:

- indirizzi IP reali;
- hostname aziendali;
- domini interni;
- credenziali;
- token o chiavi API;
- file di configurazione reali;
- log operativi;
- archivi ZIP originali;
- copie temporanee di lavoro.

Questi elementi sono esclusi tramite `.gitignore` e controllati prima di ogni commit.

## Privilegi

Gli installer richiedono privilegi amministrativi perché modificano file sotto `/etc`, `/usr/local` e `/root`.

Gli script verificano che l'esecuzione avvenga come root e terminano in caso contrario.

## Backup e rollback

Prima di modificare il sistema, ogni installer:

1. crea una directory di backup con data e ora;
2. registra quali elementi esistevano prima;
3. copia i file precedenti preservando permessi e collegamenti;
4. genera uno script `rollback.sh` con permessi `700`.

## Aggiornamenti APT

Il comando `aggiorna` esegue soltanto `apt upgrade` dopo conferma esplicita.

Non vengono eseguiti automaticamente:

- `apt full-upgrade`;
- `apt autoremove`;
- riavvii del sistema.

## Controllo vulnerabilità

Il MOTD non considera automaticamente tutte le vulnerabilità note.

Un pacchetto viene conteggiato soltanto quando:

1. è installato;
2. `debsecan` indica una correzione;
3. APT espone una versione candidata;
4. la versione candidata è superiore a quella installata.

## Raccomandazioni

- eseguire prima i test su una VM non critica;
- verificare manualmente il contenuto del backup;
- mantenere disponibile un accesso amministrativo alternativo;
- controllare sempre il diff Git prima della pubblicazione.
