#!/bin/sh

INTERFACE=$(iw dev | awk '$1=="Interface"{print $2}')
IPTABLE="# Empty iptables rule file
#*filter
#:INPUT ACCEPT [0:0]
#:FORWARD ACCEPT [0:0]
#:OUTPUT ACCEPT [0:0]
#COMMIT

*filter

# ORIGINAL FILE EXISTED ABOVE HERE

-P OUTPUT DROP
-P INPUT DROP
-A INPUT -j ACCEPT -i lo
-A OUTPUT -j ACCEPT -o lo
-A INPUT --src 192.168.0.0/24 -j ACCEPT -i ${INTERFACE}
-A OUTPUT -d 192.168.0.0/24 -j ACCEPT -o ${INTERFACE}
-A INPUT -j ACCEPT -i tun0
-A OUTPUT -j ACCEPT -o tun0
"

function updateVpnList {

	# Get current connection to restore later
	currentConnection=$(echo $(nmcli con show --active | grep -i vpn) | sed "s/ .*//")

	if [ $(ls 2>/dev/null -Ubad1 -- *ovpn | wc -l) == 0 ]; then
		echo "No VPN configuration files found in $(pwd)"
		exit
	fi

	for i in $(ls *.ovpn );
	do
		if [ $i != "" ]; then  
			profileName=$(echo "$(basename "$i")" | sed "s/.ovpn//g")
			nmcli connection delete id "$profileName" > /dev/null 2>&1 
			nmcli connection import type openvpn file "$i"
			IP=$(sed -nr '/remote /p ' "$i" | awk '{print $2}')
			IPTABLE+="-A OUTPUT -j ACCEPT -d "$IP" -o ${INTERFACE}
"
			IPTABLE+="-A INPUT -j ACCEPT -s "$IP" -i ${INTERFACE}
"
		fi
	done

	if [ "$currentConnection" != "" ]; then
		nmcli con up id "$currentConnection"
	fi
	IPTABLE+="COMMIT"
}

TARGETDIR=$1

if [ "$TARGETDIR" == "" ]; then
	echo Usage - updateVPN /path/to/VPN/config/files
	exit
fi
cd ${TARGETDIR}

echo "------Generating VPN network configuration------"
updateVpnList
echo ""
echo "------Generating IP table network locks------"
echo "$IPTABLE" | sudo tee /etc/iptables/iptables.rules > /dev/null
cat /etc/iptables/iptables.rules
echo ""
echo "------Restarting IP table service------"
sudo systemctl enable iptables
sudo systemctl start iptables
sudo systemctl restart iptables
