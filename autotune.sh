#!/bin/bash

getHighest() {
	sensors | grep Core | cut -f 2 -d'+' | cut -f1 -d'°' | sort -hr | head -n 1
}

while true; do
	t=$(getHighest)
	echo "$(date -Iseconds) Temp: $t"
	if (( $(echo "$t > 80.0" | bc -l) )); then
		./fan.sh insane noprint > /dev/null
	elif (( $(echo "$t > 65.0" | bc -l) )); then
		./fan.sh gaming noprint > /dev/null
	elif (( $(echo "$t > 60.0" | bc -l) )); then
		./fan.sh high noprint > /dev/null
	elif (( $(echo "$t > 50.0" | bc -l) )); then
		./fan.sh normal noprint > /dev/null
	else
		./fan.sh silent noprint > /dev/null
	fi
	sleep 10
done
