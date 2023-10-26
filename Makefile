SHELL=/bin/bash

BIN = $(wildcard ./*.bin)
OFFSET = 0x08000000
OPEN_OCD_PROGRAMMER_CFG = /usr/local/share/openocd/scripts/interface/stlink.cfg
OPEN_OCD_MK_CFG = /usr/local/share/openocd/scripts/target/stm32g0x.cfg

.PHONY: help 

help:
	@echo "Flash uploader to stm32.		                     "
	@echo "                                                      "
	@echo "Before using, perform: install OpenOCD or stlink-tools"
	@echo "                       "
	@echo  -e $(HELP_FLASH_UPLOADER)

include ./flash_uploader.mk