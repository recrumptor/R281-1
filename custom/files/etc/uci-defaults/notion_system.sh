#!/bin/sh
#
# Copyright (c) 2023 LENAR
#

uci -q batch <<-EOF >/dev/null
  # Set system properties
  set system.@system[0].hostname="R281"
  set system.@system[0].conloglevel="8"
  set system.@system[0].cronloglevel="9"

  # Configure timezone for Yekaterinburg, Russia
  set system.@system[0].zonename='Asia/Yekaterinburg'
  set system.@system[0].timezone='UTC-5'
  
  # Configure NTP servers
  del system.ntp.server
  add_list system.ntp.server='ru.pool.ntp.org'      # Российский NTP-пул
  add_list system.ntp.server='0.pool.ntp.org'       # Глобальные NTP-пулы
  add_list system.ntp.server='1.pool.ntp.org'
  add_list system.ntp.server='2.pool.ntp.org'
  add_list system.ntp.server='3.pool.ntp.org'

  # Luci language
  set luci.main.lang="auto"

  # Apply changes
  commit system
  commit ntp
  commit luci
EOF

exit 0
