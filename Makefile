# GTU-C312 Project Makefile
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g

# Directories
SRC_DIR = src
TOOLS_DIR = tools
PROGRAMS_DIR = programs
OUTPUT = output

# Targets
SIMULATOR = $(SRC_DIR)/simulator
PREPROCESSOR = $(TOOLS_DIR)/preprocessor

.PHONY: all clean test help

# Default target
all: $(SIMULATOR) $(PREPROCESSOR)

# Build simulator
$(SIMULATOR):
	$(MAKE) -C $(SRC_DIR)

# Build preprocessor  
$(PREPROCESSOR):
	$(MAKE) -C $(TOOLS_DIR)

# Clean all
clean:
	$(MAKE) -C $(SRC_DIR) clean
	$(MAKE) -C $(TOOLS_DIR) clean
	rm -f $(PROGRAMS_DIR)/*.preprocessed

# Run OS simulation
run-os: all
	./$(PREPROCESSOR) $(PROGRAMS_DIR)/gtu_os.asm $(OUTPUT)/gtu_os_preprocessed.asm -v
	./$(SIMULATOR) $(OUTPUT)/gtu_os_preprocessed.asm -D 3

# Debug modes
debug-0: all
	./$(SIMULATOR) $(OUTPUT)/gtu_os_preprocessed.asm -D 0

debug-1: all  
	./$(SIMULATOR) $(OUTPUT)/gtu_os_preprocessed.asm -D 1

debug-2: all
	./$(SIMULATOR) $(OUTPUT)/gtu_os_preprocessed.asm -D 2

debug-3: all
	./$(SIMULATOR) $(OUTPUT)/gtu_os_preprocessed.asm -D 3

help:
	@echo "GTU-C312 Project Build System"
	@echo "Available targets:"
	@echo "  all        - Build simulator and preprocessor"
	@echo "  clean      - Clean all build files"
	@echo "  run-os     - Run OS simulation with debug mode 3"
	@echo "  debug-0    - Run with debug mode 0 (print memory after halt)"
	@echo "  debug-1    - Run with debug mode 1 (print memory after each instruction)"
	@echo "  debug-2    - Run with debug mode 2 (interactive mode)"
	@echo "  debug-3    - Run with debug mode 3 (print thread table)"
