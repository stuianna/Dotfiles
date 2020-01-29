#!/bin/bash

GDB=arm-none-eabi-gdb
BINARY=$(find bin/ -name *.elf)

OPENOCD_INTERFACE=$(sed  -n 's/OPENOCD_INTERFACE=\(\)/\1/p' .debugConf)
OPENOCD_TARGET=$(sed  -n 's/OPENOCD_TARGET=\(\)/\1/p' .debugConf)
OPENOCD_TRANSPORT=$(sed  -n 's/OPENOCD_TRANSPORT=\(\)/\1/p' .debugConf)
OPENOCD_SCRIPT=$(sed  -n 's/OPENOCD_SCRIPT=\(\)/\1/p' .debugConf)

if [[ "$OPENOCD_INTERFACE" != "" ]]; then OPENOCD_INTERFACE="-f interface/${OPENOCD_INTERFACE}";fi
if [[ "$OPENOCD_TARGET" != "" ]]; then OPENOCD_TARGET="-f target/${OPENOCD_TARGET}";fi
if [[ "$OPENOCD_TRANSPORT" != "" ]]; then OPENOCD_TRANSPORT="-c ${OPENOCD_TRANSPORT}";fi
if [[ "$OPENOCD_SCRIPT" != "" ]]; then OPENOCD_SCRIPT="-f ${OPENOCD_SCRIPT}";fi

echo ${BINARY}

${GDB} ${BINARY} -ex "target remote | openocd ${OPENOCD_INTERFACE} ${OPENOCD_INTERFACE} ${OPENOCD_TARGET} -c 'gdb_port pipe'" -ex "monitor reset halt"

exit
