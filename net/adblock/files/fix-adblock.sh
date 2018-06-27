#!/bin/ash

# Copyright 2018 InvizBox Ltd
#
# Licensed under the InvizBox Shared License;
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#        https://www.invizbox.com/lic/license.txt

if [ -z $(uci get adblock.extra) ]; then
	echo "old adblock config"
	if [ $(uci -c /rom/etc/config get adblock.extra) == "adblock" ]; then
		echo "available replacement in rom"
		cp /rom/etc/config/adblock /tmp
		uci -c /tmp set adblock.global.adb_enabled=$(uci get adblock.global.adb_enabled)
		mv /tmp/adblock /etc/config
	elif [ -f /etc/config/adblock-opkg ]; then
		echo "available replacement after opkg upgrade"
		uci set adblock-opkg.global.adb_enabled=$(uci get adblock.global.adb_enabled)
		mv /etc/config/adblock-opkg /etc/config/adblock
	fi
fi
