#!/usr/bin/env bash
set -ex
apt-get update
apt-get install -y libnss3-tools

CERT_FILE="${INST_SCRIPTS}/certificates/ca.crt"
CERT_NAME="Custom Root CA"

# Install the cert into the system cert store
cp ${CERT_FILE} /usr/local/share/ca-certificates/
update-ca-certificates


# Create an empty cert9.db. This will be used by applications like Chrome
mkdir -p $HOME/.pki/nssdb/
certutil -N -d sql:$HOME/.pki/nssdb/ --empty-password
chown 1000:1000 $HOME/.pki/nssdb/


if [ -f /usr/bin/firefox ]; then

    # Firefox uses it's own certificate store. The store is baked into the executable which must be invoked to create the
    #   store (cert9.db)
    #  We launch firefox to generate the db, but then remove the rest of the generated profile items so they are created
    #  fresh when the Kasm launches

    which firefox
    firefox -headless >/dev/null 2>&1 &
    sleep 5
    pkill firefox


    mkdir /tmp/cert_db_backup/
    mv $HOME/.mozilla/firefox/kasm/cert9.db /tmp/cert_db_backup/
    mv $HOME/.mozilla/firefox/kasm/key4.db /tmp/cert_db_backup/
    rm -rf $HOME/.mozilla/firefox/kasm/*
    mv /tmp/cert_db_backup/* $HOME/.mozilla/firefox/kasm/
    rm -rf /tmp/cert_db_backup/
    chown -R 1000:1000 $HOME/.mozilla

fi

# Update all cert9.db instances with the CA
for certDB in $(find / -name "cert9.db")
do
    certdir=$(dirname ${certDB});
    echo "Updating $certdir"
    certutil -A -n "${CERT_NAME}" -t "TCu,," -i ${CERT_FILE} -d sql:${certdir}
done

