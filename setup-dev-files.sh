#!/bin/sh

[ -z "$1" ] && echo "usage: setup-dev-file.sh <project-rootfs-dir-path>" && exit 1

set -e

SYSREPO_DIR="$1"

echo "Creating direcories: ${SYSREPO_DIR}/usr, ${SYSREPO_DIR}/usr/libexec, ${SYSREPO_DIR}/usr/libexec/rpcd"
mkdir -p $SYSREPO_DIR/usr/libexec/rpcd

echo "Creating directories: ${SYSREPO_DIR}/etc/config, ${SYSREPO_DIR}/etc/init.d"
mkdir -p $SYSREPO_DIR/etc/{config,init.d}

echo "Creating directories: ${SYSREPO_DIR}/proc, ${SYSREPO_DIR}/net"
mkdir -p $SYSREPO_DIR/proc/net

echo

# dhcp plugin

echo "Setting files for dhcp plugin"

echo "  copying ./uci/dhcp -> ${SYSREPO_DIR}/etc/config/dhcp"
cp uci/dhcp $SYSREPO_DIR/etc/config/dhcp

echo "  copying ./uci/network -> ${SYSREPO_DIR}/etc/config/network"
cp uci/network $SYSREPO_DIR/etc/config/network

echo "  copying ./ubus/ubus.dhcp -> ${SYSREPO_DIR}/usr/libexec/rpcd/dhcp"
cp ubus/ubus.dhcp $SYSREPO_DIR/usr/libexec/rpcd/dhcp
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/dhcp

echo "  copying ./ubus/ubus.router.netowrk -> ${SYSREPO_DIR}/usr/libexec/rpcd/router.netowrk"
cp ubus/ubus.router.network $SYSREPO_DIR/usr/libexec/rpcd/router.network
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/router.network

echo "  creating ${SYSREPO_DIR}/etc/init.d/network"
echo '#!/bin/sh' > $SYSREPO_DIR/etc/init.d/network && chmod +x $SYSREPO_DIR/etc/init.d/network

echo "  creating ${SYSREPO_DIR}/etc/init.d/odhcp"
echo '#!/bin/sh' > $SYSREPO_DIR/etc/init.d/odhcpd && chmod +x $SYSREPO_DIR/etc/init.d/odhcpd


echo

# network plugin

echo "Setting files for network plugin"

echo "  copying ./uci/network -> ${SYSREPO_DIR}/etc/config/network"
cp uci/network $SYSREPO_DIR/etc/config/network

echo "  creating ${SYSREPO_DIR}/etc/init.d/network"
echo '#!/bin/sh' > $SYSREPO_DIR/etc/init.d/network
chmod +x $SYSREPO_DIR/etc/init.d/network

echo "  copying ./ubus/network.device -> ${SYSREPO_DIR}/usr/libexec/rpcd/network.device"
cp ubus/network.device $SYSREPO_DIR/usr/libexec/rpcd/network.device
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/network.device

echo "  copying ./ubus/network.interface -> ${SYSREPO_DIR}/usr/libexec/rpcd/network.interface"
cp ubus/network.interface $SYSREPO_DIR/usr/libexec/rpcd/network.interface
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/network.interface

echo "  copying ./ubus/router.net -> ${SYSREPO_DIR}/usr/libexec/rpcd/router.net"
cp ubus/router.net $SYSREPO_DIR/usr/libexec/rpcd/router.net
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/router.net

## OpenWrt replacement for router.net
echo "  copying ./command/ip -> ${SYSREPO_DIR}/bin/ip"
cp command/ip $SYSREPO_DIR/bin/ip
chmod +x $SYSREPO_DIR/bin/ip

echo "  copying ./file/arp -> ${SYSREPO_DIR}/proc/net/arp"
cp file/arp $SYSREPO_DIR/proc/net/arp

echo "  copying ./ubus/sfp.ddm -> ${SYSREPO_DIR}/usr/libexec/rpcd/sfp.ddm "
cp ubus/sfp.ddm $SYSREPO_DIR/usr/libexec/rpcd/sfp.ddm
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/sfp.ddm

echo

# firmware plugin

echo "Setting files for firmware plugin"

echo "  copying ./ubus/juci.system -> ${SYSREPO_DIR}/usr/libexec/rpcd/juci.system"
cp ubus/juci.system $SYSREPO_DIR/usr/libexec/rpcd/juci.system
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/juci.system

echo "  copying ./ubus/juci.sysupgrade -> ${SYSREPO_DIR}/usr/libexec/rpcd/juci.sysupgrade"
cp ubus/juci.sysupgrade $SYSREPO_DIR/usr/libexec/rpcd/juci.sysupgrade
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/juci.sysupgrade

echo "  copying ./ubus/juci.system -> ${SYSREPO_DIR}/usr/libexec/rpcd/juci.system"
cp ubus/router.system $SYSREPO_DIR/usr/libexec/rpcd/router.system
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/router.system

echo

# sip plugin

echo "Setting files for sip plugin"

echo "  copying ./uci/voice_client -> ${SYSREPO_DIR}/etc/config/voice_client"
cp uci/voice_client $SYSREPO_DIR/etc/config/voice_client

echo "  copying ./ubus/asterisk.sip -> ${SYSREPO_DIR}/usr/libexec/rpcd/asterisk.sip"
cp ubus/asterisk.sip $SYSREPO_DIR/usr/libexec/rpcd/asterisk.sip
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/asterisk.sip

echo "  creating ${SYSREPO_DIR}/etc/init.d/voice_client"
echo '#!/bin/sh' > $SYSREPO_DIR/etc/init.d/voice_client && chmod +x $SYSREPO_DIR/etc/init.d/voice_client

echo "  creating ${SYSREPO_DIR}/etc/init.d/asterisk"
echo '#!/bin/sh' > $SYSREPO_DIR/etc/init.d/asterisk && chmod +x $SYSREPO_DIR/etc/init.d/asterisk

echo

# provisioning plugin

echo "Setting files for provisioning plugin"

echo "  copying ./ubus/router.system -> ${SYSREPO_DIR}/usr/libexec/rpcd/router.system"
cp ubus/router.system $SYSREPO_DIR/usr/libexec/rpcd/router.system
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/router.system

echo "  copying ./ubus/system -> ${SYSREPO_DIR}/usr/libexec/rpcd/system"
cp ubus/system $SYSREPO_DIR/usr/libexec/rpcd/system
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/system

echo

# wireless plugin

echo "Setting files for wireless plugin"

echo "  copying ./uci/wireless -> ${SYSREPO_DIR}/etc/config/wireless"
cp uci/wireless $SYSREPO_DIR/etc/config/wireless

echo "  creating ${SYSREPO_DIR}/etc/init.d/network"
echo '#!/bin/sh' > $SYSREPO_DIR/etc/init.d/network && chmod +x $SYSREPO_DIR/etc/init.d/network

echo "  copying ./ubus/router.wireless -> ${SYSREPO_DIR}/usr/libexec/rpcd/router.wireless"
cp ubus/router.wireless $SYSREPO_DIR/usr/libexec/rpcd/router.wireless
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/router.wireless

echo "  copying ./ubus/network.device -> ${SYSREPO_DIR}/usr/libexec/rpcd/network.device"
cp ubus/network.device $SYSREPO_DIR/usr/libexec/rpcd/network.device
chmod +x $SYSREPO_DIR/usr/libexec/rpcd/network.device

echo

## Create file for debuging in privilaged sace

echo "Cretating ${SYSREPO_DIR}/gdb"

cat > ${SYSREPO_DIR}/gdbp << 'eof'
#!/bin/sh
sudo gdb "$@"
eof

sudo chmod +x ${SYSREPO_DIR}/gdbp

echo
