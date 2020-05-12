#!/bin/sh

[ -z "$1" ] && echo "usage: setup-dev-clean.sh <project-rootfs-dir-path>" && exit 1

set -e

START_DIR="$(pwd)"

SYSREPO_DIR="$1"

echo "Cleaning ${SYSREPO_DIR}/repositories/sysrepo"
cd $SYSREPO_DIR/repositories/sysrepo/build
sudo make shm_clean
sudo make sr_clean
sudo make uninstall

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
cd $SYSREPO_DIR/repositories/Netopeer2/build
sudo make uninstall

echo

echo "Removing services /etc/systemd/system/sysrepo-*"
sudo rm /etc/systemd/system/sysrepo-* || true

echo

cd $START_DIR

echo "Removing ${SYSREPO_DIR}"
sudo rm -rf $SYSREPO_DIR || true

echo