#!/bin/bash

MYIP=$(curl 'https://ipinfo.io/ip' 2> /dev/null)
LOC=$(echo $(geoiplookup "$MYIP") | sed -n 's/^.*: //p' 2> /dev/null)
echo $LOC
