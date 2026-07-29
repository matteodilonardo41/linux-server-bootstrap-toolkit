# Linux Server Bootstrap Toolkit

![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnu-bash&logoColor=white) ![Debian](https://img.shields.io/badge/Debian-Compatible-A81D33?logo=debian&logoColor=white) ![Ubuntu](https://img.shields.io/badge/Ubuntu-Compatible-E95420?logo=ubuntu&logoColor=white) ![APT](https://img.shields.io/badge/APT-Package%20Management-blue) ![License](https://img.shields.io/badge/License-MIT-green) ![Status](https://img.shields.io/badge/Status-Syntax%20Tested-brightgreen) ![Rollback](https://img.shields.io/badge/Rollback-Supported-success)


Toolkit riutilizzabile per applicare rapidamente uno standard comune alle nuove VM Linux Debian e Ubuntu.

Il progetto raccoglie due componenti indipendenti:

1. **Server MOTD** — banner dinamico con informazioni operative, aggiornamenti, sicurezza e stato della VM.
2. **Server Update Command** — comando interattivo `aggiorna` per eseguire aggiornamenti APT controllati e registrati.

## Obiettivi

- installazione semplice e ripetibile;
- configurazione centralizzata;
- compatibilità Debian e Ubuntu;
- backup automatico prima delle modifiche;
- rollback dello stato precedente;
- assenza di indirizzi IP, hostname, credenziali o riferimenti aziendali;
- utilizzo sicuro anche su infrastrutture differenti.

## Struttura del repository

```text
linux-server-bootstrap-toolkit/
├── packages/
│   ├── server-motd/
│   │   ├── 00-server-motd
│   │   ├── install.sh
│   │   ├── server-motd.conf.example
│   │   └── README.md
│   └── server-update-command/
│       ├── aggiorna
│       ├── install.sh
│       └── README.md
├── docs/
├── examples/
├── scripts/
├── .github/workflows/
├── .gitignore
└── README.md
```

## Requisiti

- Debian o Ubuntu;
- accesso amministrativo tramite `sudo`;
- gestore pacchetti APT;
- Bash;
- connessione ai repository configurati.

Le dipendenze specifiche del MOTD vengono installate automaticamente dal relativo installer.

## Installazione

Clonare il repository ed entrare nella directory:

```bash
git clone https://github.com/matteodilonardo41/linux-server-bootstrap-toolkit.git
cd linux-server-bootstrap-toolkit
```

### Installare il Server MOTD

```bash
cd packages/server-motd
chmod +x install.sh
sudo ./install.sh
```

### Installare il comando aggiorna

```bash
cd ../server-update-command
chmod +x install.sh
sudo ./install.sh
```

## Configurazione del MOTD

La configurazione centralizzata viene salvata in:

```text
/etc/default/server-motd
```

Parametri principali:

```bash
DISPLAY_NAME="APP-SRV-01"
DESCRIPTION="Application server"
APP_VERSION="1.0.0"
NETWORK_INTERFACE=""
TEMPLATE_MACHINE_ID=""
```

## Utilizzo del comando aggiorna

Dopo l'installazione è sufficiente eseguire:

```bash
aggiorna
```

Il comando esegue `apt update`, mostra i pacchetti aggiornabili e richiede conferma prima di procedere con `apt upgrade`.

Non vengono eseguiti automaticamente né `full-upgrade` né `autoremove`.

I log vengono salvati in:

```text
/var/log/server-update/
```

## Sicurezza

- nessuna credenziale è inclusa nel repository;
- nessun indirizzo IP o hostname reale è presente nei file pubblici;
- gli installer richiedono privilegi amministrativi;
- gli script vengono verificati con `bash -n` prima dell'installazione;
- la configurazione MOTD esistente non viene sovrascritta;
- ogni installer crea un backup prima delle modifiche;
- il rollback ripristina lo stato precedente dei file gestiti.

## Note operative

- testare sempre il toolkit in una VM non critica prima dell'uso in produzione;
- verificare che i repository APT siano configurati e raggiungibili;
- controllare la directory di backup mostrata al termine dell'installazione;
- conservare almeno un accesso amministrativo alternativo durante i test;
- il controllo IP duplicato tramite `arping` è best-effort e non sostituisce i controlli di rete centralizzati.
