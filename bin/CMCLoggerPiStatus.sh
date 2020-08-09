#!/bin/sh

jsonResponse_cmc=$(ssh crypto /home/stuart/.local/bin/CMCLogger -js 2> /dev/null)
jsonResponse_whale=$(ssh crypto /home/stuart/.local/bin/whaleAlertLogger -js 2> /dev/null)

if [[ "$jsonResponse_cmc" == ''  || "$jsonResponse_whale" == '' ]]; then
	echo ''
	exit
fi

health_cmc=$(echo "$jsonResponse_cmc" | jq -r '.health')
lastCall_cmc=$(echo "$jsonResponse_cmc" | jq -r '.last_call')
health_whale=$(echo "$jsonResponse_whale" | jq -r '.health')
lastCall_whale=$(echo "$jsonResponse_whale" | jq -r '.last_call')

if (( $lastCall_cmc < 15 && $lastCall_whale < 5 )); then
	logStatus="Ok";
else
	logStatus="Error";
fi

averageHealth=$(echo "(($health_cmc + $health_whale) / 2)" | bc)

echo "Log: $logStatus | $averageHealth%"

