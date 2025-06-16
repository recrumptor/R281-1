#!/bin/sh
#
# Copyright (c) 2023 LENAR
#

uci -q batch <<-EOF >/dev/null
  # Set system properties
  set system.@system[0].hostname="R281"
  set system.@system[0].conloglevel="8"
  set system.@system[0].cronloglevel="9"

  # Configure NTP servers
  del system.ntp.server
  add_list system.ntp.server='africa.pool.ntp.org'
  add_list system.ntp.server='asia.pool.ntp.org'
  add_list system.ntp.server='europe.pool.ntp.org'
  add_list system.ntp.server='north-america.pool.ntp.org'
  add_list system.ntp.server='oceania.pool.ntp.org'
  add_list system.ntp.server='south-america.pool.ntp.org'

  # Luci language
  set luci.main.lang="auto"

  # Apply changes
  commit system
  commit ntp
  commit luci
EOF

exit 0
