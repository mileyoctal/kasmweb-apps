#!/usr/bin/env bash
# Replace the button-layout property to remove the minimize/maximize buttons etc
sed -i "s/O|SHMC/|/g" $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
xfwm4 --daemon