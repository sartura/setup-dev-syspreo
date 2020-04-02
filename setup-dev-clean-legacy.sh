#!/bin/sh

[ -z "$1" ] && echo "usage: setup-dev-clean.sh <project-rootfs-dir-path>" && exit 1

set -e

START_DIR="$(pwd)"

SYSREPO_DIR="$1"

echo "Cleaning ${SYSREPO_DIR}/repositories/sysrepo"
cd $SYSREPO_DIR/repositories/sysrepo/build
sudo make uninstall
sudo rm -rf /tmp/sysrepo* || true

echo

echo "Cleaning ${SYSREPO_DIR}/repositories/libyang"
cd $SYSREPO_DIR/repositories/libyang/build
sudo make uninstall

echo

echo "Cleaning ${SYSREPO_DIR}/repositories/libnetconf2"
cd $SYSREPO_DIR/repositories/libnetconf2/build
sudo make uninstall

echo

echo "Cleaning ${SYSREPO_DIR}/repositories/Netopeer2"
cd $SYSREPO_DIR/repositories/Netopeer2/cli/build
sudo make uninstall

echo

cd $SYSREPO_DIR/repositories/Netopeer2/keystored/build
sudo make uninstall

echo

cd $SYSREPO_DIR/repositories/Netopeer2/server/build
sudo make uninstall
sudo rm /var/run/netopeer2-server.pid || true

echo

echo "Removing services /etc/systemd/system/sysrepo-legacy*"
sudo rm /etc/systemd/system/sysrepo-legacy* || true

echo

cd $START_DIR

echo "Removing ${SYSREPO_DIR}"
sudo rm -rf $SYSREPO_DIR || true

echo