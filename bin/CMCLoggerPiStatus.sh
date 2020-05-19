#!/bin/sh

jsonResponse=$(ssh pi /home/pi/.local/bin/CMCLogger -js 2> /dev/null)

if [[ "$jsonResponse" == '' ]]; then
	echo ''
	exit
fi

health=$(echo "$jsonResponse" | jq -r '.health')
lastCall=$(echo "$jsonResponse" | jq -r '.last_call')

if (( $lastCall < 5 )); then
	logStatus="Ok";
else
	logStatus="Error";
fi

echo "PI: $logStatus | $health%"

