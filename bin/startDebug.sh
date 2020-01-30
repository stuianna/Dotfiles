#!/bin/bash

GDB=arm-none-eabi-gdb
DIR="$(pwd)"
BINARY=$(find ${DIR}/bin/ -name *.elf)

OPENOCD_INTERFACE=$(sed  -n 's/OPENOCD_INTERFACE=\(\)/\1/p' ${DIR}/.debugConf)
OPENOCD_TARGET=$(sed  -n 's/OPENOCD_TARGET=\(\)/\1/p' ${DIR}/.debugConf)
OPENOCD_TRANSPORT=$(sed  -n 's/OPENOCD_TRANSPORT=\(\)/\1/p' ${DIR}/.debugConf)
OPENOCD_SCRIPT=$(sed  -n 's/OPENOCD_SCRIPT=\(\)/\1/p' ${DIR}/.debugConf)

if [[ "$OPENOCD_INTERFACE" != "" ]]; then OPENOCD_INTERFACE="-f interface/${OPENOCD_INTERFACE}";fi
if [[ "$OPENOCD_TARGET" != "" ]]; then OPENOCD_TARGET="-f target/${OPENOCD_TARGET}";fi
if [[ "$OPENOCD_TRANSPORT" != "" ]]; then OPENOCD_TRANSPORT="-c ${OPENOCD_TRANSPORT}";fi
if [[ "$OPENOCD_SCRIPT" != "" ]]; then OPENOCD_SCRIPT="-f ${OPENOCD_SCRIPT}";fi

${GDB} ${BINARY} -ex "target remote | openocd ${OPENOCD_SCRIPT} ${OPENOCD_INTERFACE} ${OPENOCD_TRANSPORT} ${OPENOCD_TARGET} -c 'gdb_port pipe' -c 'init' -c 'reset halt' " -ex "monitor reset halt"

exit
