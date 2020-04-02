#!/bin/sh

[ -z "$1" ] && echo "usage: setup-dev-systemd-service.sh <project-rootfs-dir-path>" && exit 1

LEGACY=""
[ ! -z "$2" ] && LEGACY="$2"-

set -e

SYSREPO_DIR="$1"

FILE=/etc/systemd/system/sysrepo-${LEGACY}ubusd.service
echo "Crating file: ${FILE}"
sudo sh -c "cat > ${FILE}" << EOF
[Unit]
Description=ubusd service
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=$SYSREPO_DIR/sbin/ubusd

[Install]
WantedBy=multi-user.target
EOF

FILE=/etc/systemd/system/sysrepo-${LEGACY}rpcd.service
echo "Creating file: ${FILE}"
sudo sh -c "cat > ${FILE}" << EOF
[Unit]
Description=rpcd service
After=ubusd.service
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=$SYSREPO_DIR/sbin/rpcd

[Install]
WantedBy=multi-user.target
EOF
