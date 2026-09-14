#!/bin/bash

cat >> ./feeds.conf.default <<EOF


# Extra Packages

src-git 5gmodem https://github.com/fildunsky/luci-app-5gmodem
EOF

exit 0
