JZINTV_PATH=/home/shalmezad/Programs/jzintv
INTYBASIC_PATH=/home/shalmezad/Programs/IntyBasic1_1_0

INTYBASIC_PARSER=$(INTYBASIC_PATH)/intybasic_linux
AS1600_ASSEMBLER=$(JZINTV_PATH)/bin/as1600
JZINTV_EMULATOR=$(JZINTV_PATH)/bin/jzintv

GAME_NAME=intellibullet

EXPORT_DIRECTORY=export
SOURCE_NAME=main.bas
LST_NAME=$(GAME_NAME).lst
BIN_NAME=$(GAME_NAME).bin
ROM_NAME=$(GAME_NAME).rom

build:
	mkdir -p intermediate
	mkdir -p $(EXPORT_DIRECTORY) 
	#Copy in prologue/epilogue temporarily
	cp $(INTYBASIC_PATH)/intybasic_*.asm ./
	#Run intybasic:
	$(INTYBASIC_PARSER) $(SOURCE_NAME) intermediate/intermediate.asm
	#Run AS1600
	$(AS1600_ASSEMBLER) -o $(EXPORT_DIRECTORY)/$(BIN_NAME) -l $(EXPORT_DIRECTORY)/$(LST_NAME) intermediate/intermediate.asm
	#Generate a rom as well:
	$(JZINTV_PATH)/bin/bin2rom $(EXPORT_DIRECTORY)/$(BIN_NAME)
	#Clean up
	rm intybasic_*.asm

run:
	$(JZINTV_EMULATOR) $(EXPORT_DIRECTORY)/$(BIN_NAME)

clean:
	rm -rf $(EXPORT_DIRECTORY)
	rm -rf intermediate
	rm -rf dump.*
