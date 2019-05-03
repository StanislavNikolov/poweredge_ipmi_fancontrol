#!/bin/bash

export PATH="$PATH:/usr/local/bin/"

# params for remote management
# -I lanplus -H 192.168.8.102 -U root -P root

enable_manual_control() {
	ipmitool raw 0x30 0x30 0x01 0x00
}

disable_manual_control() {
	ipmitool raw 0x30 0x30 0x01 0x01
}

print_data() {
	ipmitool sensor | grep FAN
}

# todo argument instead of 20% (0x14)
set_fan_speed() {
	if [[ "$1" == "insane" ]]; then
		ipmitool raw 0x30 0x30 0x02 0xff 0x64
	elif [[ "$1" == "gaming" ]]; then
		ipmitool raw 0x30 0x30 0x02 0xff 0x35
	elif [[ "$1" == "high" ]]; then
		ipmitool raw 0x30 0x30 0x02 0xff 0x25
	elif [[ "$1" == "normal" ]]; then
		ipmitool raw 0x30 0x30 0x02 0xff 0x15
	elif [[ "$1" == "silent" ]]; then
		ipmitool raw 0x30 0x30 0x02 0xff 0x00
	else
		echo "unrecognized option"
	fi
}

enable_manual_control
set_fan_speed "$1"

echo "done"

if [[ "$2" != "noprint" ]]; then
	echo "printing data..."
	sleep 5
	print_data
fi
