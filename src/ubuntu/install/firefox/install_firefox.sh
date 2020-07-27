#!/usr/bin/env bash
set -xe

echo "Install Firefox"
apt-mark unhold firefox
apt-get remove firefox
apt-get update
apt-get install -y firefox p11-kit-modules

# Plugin to support running flash videos for sites like vimeo
apt-get install -y browser-plugin-freshplayer-pepperflash
apt-mark hold firefox
apt-get clean -y

# Update firefox to utilize the system certificate store instead of the one that ships with firefox
rm /usr/lib/firefox/libnssckbi.so
ln /usr/lib/x86_64-linux-gnu/pkcs11/p11-kit-trust.so /usr/lib/firefox/libnssckbi.so

# Disabling default first run URL
echo "pref(\"datareporting.policy.firstRunURL\", \"\");" >> /usr/lib/firefox/browser/defaults/preferences/firefox.js

# Creating Default Profile
firefox -headless -CreateProfile "kasm $HOME/.mozilla/firefox/kasm"

# Starting with version 67, Firefox creates a unique profile mapping per installation which is hash generated
#   based off the installation path. Because that path will be static for our deployments we can assume the hash
#   and thus assign our profile to the default for the installation

cat >>$HOME/.mozilla/firefox/profiles.ini <<EOL
[Install4F96D1932A9F858E]
Default=kasm
Locked=1
EOL

chown -R 1000:1000 $HOME/.mozilla
