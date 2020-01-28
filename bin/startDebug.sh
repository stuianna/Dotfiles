#!/bin/bash

GDB=arm-none-eabi-gdb
OPENOCD_INTERFACE=interface/stlink-v2-1.cfg
OPENOCD_TARGET=target/stm32f7x.cfg
BINARY="bin/project.elf"

${GDB} ${BINARY} -ex "target remote | openocd -f ${OPENOCD_INTERFACE} -f ${OPENOCD_TARGET} -c 'gdb_port pipe'" -ex "monitor reset halt" 

