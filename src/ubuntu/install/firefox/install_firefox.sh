#!/usr/bin/env bash
set -xe

echo "Install Firefox"
apt-mark unhold firefox
apt-get remove firefox
apt-get update
apt-get install -y firefox

# Plugin to support running flash videos for sites like vimeo
apt-get install -y browser-plugin-freshplayer-pepperflash
apt-mark hold firefox
apt-get clean -y

# Create Default Profile
firefox -headless -CreateProfile "kasm $HOME/.mozilla/firefox/kasm"
echo "pref(\"datareporting.policy.firstRunURL\", \"\");" >> /usr/lib/firefox/browser/defaults/preferences/firefox.js

chown -R 1000:1000 $HOME/.mozilla