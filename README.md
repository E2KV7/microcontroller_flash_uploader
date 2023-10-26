This repository contains a  makefile describing the functions of openocd & st-utils. 
Using these files you can upload and erase the microcontroller firmware, and use GDB.

st-utils is used only for stm32. openocd can be used for various microcontrollers, for example: WCH, Novoton, Geehy, GigaDevice.
You can include flash_uploader.mk in you Makefile and use.

Target:

	make flash     : upload flash use OpenOCD
	make erase     : erase flash use OpenOCD
	make flash-st  : upload flash use st-flash
	make erase-st  : erase flash use st-flash
	make gdb       : open GNU debugger
