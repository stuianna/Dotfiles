#!/bin/sh

jsonResponse=$(ssh pi python3 /home/pi/pythonlibs/CMCLogger/CMCLogger.py -js 2> /dev/null)

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

