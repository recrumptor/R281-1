#!/bin/bash

cat >> ./feeds.conf.default <<EOF
# Extra Feeds
# src-git small_package https://github.com/kenzok8/small-package
# src-git kenzo https://github.com/kenzok8/openwrt-packages
# src-git small https://github.com/kenzok8/small

# Extra Packages
src-git 3ginfo_lite https://github.com/4IceG/luci-app-3ginfo-lite
# src-git lite_watchdog https://github.com/4IceG/luci-app-lite-watchdog
src-git modemband https://github.com/4IceG/luci-app-modemband
# src-git modemdefine https://github.com/4IceG/luci-app-modemdefine
src-git sms_tool https://github.com/4IceG/luci-app-sms-tool-js
# src-git xray https://github.com/yichya/luci-app-xray
# src-git v2raya https://github.com/v2rayA/v2raya-openwrt
# src-git zapret https://github.com/remittor/zapret-openwrt
src-git amneziawg https://github.com/amnezia-vpn/amneziawg-openwrt
EOF

exit 0
