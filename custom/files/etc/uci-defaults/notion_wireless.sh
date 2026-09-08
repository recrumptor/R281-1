#!/bin/sh
#
# Copyright (c) 2023 LENAR
#

C2G="$(( 1 + (RANDOM % 3) * 5 ))"
C5G="$(( 36 + (RANDOM % 4) * 4 ))"
MD5="$(md5sum /dev/mtd2 | head -c 6)"
ODR="$(sed -n "/DISTRIB_RELEASE/s/.*='\([0-9]*\).*/\1/p" /etc/openwrt_release)"

for RADIO in "radio0" "radio1"; do
  uci -q get wireless."$RADIO" || continue

  SSID=$(uci -q get wireless.default_$RADIO.ssid)
  BAND=$(uci -q get wireless.$RADIO.band)

  [ "$SSID" != "OpenWrt" ] && continue

  if [ "$ODR" -lt 25 ]; then
    uci set wireless."$RADIO".disabled="0"
  else
    uci set wireless.default_"$RADIO".disabled="0"
  fi

  uci set wireless."$RADIO".cell_density="0"

  if [ "$BAND" = "2g" ]; then
    uci set wireless.default_"$RADIO".ssid="Notion-${MD5}"
    uci set wireless.default_"$RADIO".ifname="wifi-2g"
    uci set wireless."$RADIO".channel="${C2G}"
  else
    uci set wireless.default_"$RADIO".ssid="Notion-${MD5}-5G"
    uci set wireless.default_"$RADIO".ifname="wifi-5g"
    uci set wireless."$RADIO".channel="${C5G}"
  fi

  uci set wireless.default_"$RADIO".encryption="psk2"
  uci set wireless.default_"$RADIO".key="OP${MD5}"
  uci set wireless.default_"$RADIO".skip_inactivity_poll="1"
  uci set wireless.default_"$RADIO".disassoc_low_ack="0"

  uci -q commit wireless
done

exit 0
