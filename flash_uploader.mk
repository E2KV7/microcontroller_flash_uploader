SHELL=/bin/bash

# Before using, perform: init BIN, OFFSET, OPEN_OCD_PROGRAMMER_CFG, OPEN_OCD_MK_CFG. 
# 	example: 
# 	BIN = ./Project.bin
# 	OFFSET = 0x08000000
# 	OPEN_OCD_PROGRAMMER_CFG = /usr/local/share/openocd/scripts/interface/stlink.cfg
# 	OPEN_OCD_MK_CFG = /usr/local/share/openocd/scripts/target/stm32g0x.cfg

HELP_FLASH_UPLOADER = \
	" make flash     : upload flash use OpenOCD\n"\
	"make erase     : erase flash use OpenOCD\n"\
	"make flash-st  : upload flash use st-flash\n"\
	"make erase-st  : erase flash use st-flash\n"\
	"make gdb       : open GNU debugger\n"\


.PHONY:  flash erase flash-st erase-st gdb-server gdb

flash:
	openocd -f $(OPEN_OCD_PROGRAMMER_CFG) \
	-f $(OPEN_OCD_MK_CFG) \
	-c init \
	-c "reset halt; flash write_image erase $(BIN) $(OFFSET) ; reset" \
	-c shutdown

erase:
	openocd -f $(OPEN_OCD_PROGRAMMER_CFG) \
	-f $(OPEN_OCD_MK_CFG) \
	-c "flash init; init; reset halt; flash erase_sector 0 1 last " \
	-c shutdown \

flash-st:
	st-flash write $(BIN) $(OFFSET)

erase-st:
	st-flash erase

OPENOCD_PORT=3333
gdb: $(PROJECT)
	openocd -f $(OPEN_OCD_PROGRAMMER_CFG) \
	-f $(OPEN_OCD_MK_CFG) \
	-c 'transport select hla_swd; reset_config none' &
	arm-none-eabi-gdb $(PROJECT) \
	-ex 'target remote localhost:$(OPENOCD_PORT); monitor reset halt' \
	&& killall openocd
