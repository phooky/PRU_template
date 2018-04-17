# Specify which PRU this code will run on
PRU_NUM=0

ifndef PRU_CGT
define ERROR_BODY

*******************************************************************************
PRU_CGT environment variable is not set. Examples given:
(Desktop Linux) export PRU_CGT=/path/to/pru/code/gen/tools/ti-cgt-pru_2.1.2
(Windows) set PRU_CGT=C:/path/to/pru/code/gen/tools/ti-cgt-pru_2.1.2
(ARM Linux*) export PRU_CGT=/usr/share/ti/cgt-pru

*ARM Linux also needs to create a symbolic link to the /usr/bin/ directory in
order to use the same Makefile
(ARM Linux) ln -s /usr/bin/ /usr/share/ti/cgt-pru/bin
*******************************************************************************

endef
$(error $(ERROR_BODY))
endif

TARGET=am335x-pru$(PRU_NUM)-fw
OBJ_DIR=obj
SRC_DIR=src
INC_DIR=include

LINKER_COMMAND_FILE=./AM335x_PRU.cmd
INCLUDE=--include_path=./$(INC_DIR)
STACK_SIZE=0x100
HEAP_SIZE=0x100

#Common compiler and linker flags (Defined in 'PRU Optimizing C/C++ Compiler User's Guide)
CFLAGS=-k -v3 -O2 --display_error_number --endian=little --hardware_mac=on --obj_directory=$(OBJ_DIR) --pp_directory=$(OBJ_DIR) -ppd -ppa
#Linker flags (Defined in 'PRU Optimizing C/C++ Compiler User's Guide)
LFLAGS=--reread_libs --warn_sections --stack_size=$(STACK_SIZE) --heap_size=$(HEAP_SIZE)
MAP=$(OBJ_DIR)/$(PROJ_NAME).map
C_SOURCES=$(wildcard $(SRC_DIR)/*.c)
ASM_SOURCES=$(wildcard $(SRC_DIR)/*.asm)
SOURCES=$(ASM_SOURCES) $(C_SOURCES)

C_OBJECTS=$(C_SOURCES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
ASM_OBJECTS=$(ASM_SOURCES:$(SRC_DIR)/%.asm=$(OBJ_DIR)/%.o)
OBJECTS=$(C_OBJECTS) $(ASM_OBJECTS)

all: $(TARGET) 

# Invokes the linker (-z flag) to make the .out file
$(TARGET): $(OBJECTS) $(LINKER_COMMAND_FILE)
	@echo "TARGET"
	$(PRU_CGT)/bin/clpru $(CFLAGS) -z -i$(PRU_CGT)/lib -i$(PRU_CGT)/include $(LFLAGS) -o $(TARGET) $(OBJECTS) -m$(MAP) $(LINKER_COMMAND_FILE) --library=libc.a $(LIBS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "C target"
	@mkdir -p $(OBJ_DIR)
	$(PRU_CGT)/bin/clpru --include_path=$(PRU_CGT)/include $(INCLUDE) $(CFLAGS) -fe $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	@echo "asm target"
	@mkdir -p $(OBJ_DIR)
	$(PRU_CGT)/bin/clpru --include_path=$(PRU_CGT)/include $(INCLUDE) $(CFLAGS) -fe $@ $<

.PHONY: all clean

clean:
	@echo "CLEAN"
	@rm -rf $(OBJ_DIR)
	@rm $(TARGET)

# Includes the dependencies that the compiler creates (-ppd and -ppa flags)
-include $(OBJECTS:%.o=%.pp)

