#!/bin/bash

echo "Move Custom Files"
mv -f ./custom/files ./

echo "Fix Executable Permissions"
chmod +x ./files/usr/bin/antenna-switch
chmod +x ./files/etc/init.d/antenna
chmod +x ./files/etc/uci-defaults/99-antenna-enable

echo "Patch For NCM"
mv -f ./custom/patch/ncm.* ./package/network/utils/comgt/files/

echo "Remove Config Folder"
rm -r ./files/etc/config

echo "Copy Build Config"
mkdir bin
cp .config ./bin/build.config

exit 0
