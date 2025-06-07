#include "cpu.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void print_usage() {
    printf("Usage: ./simulator <filename> -D <debug_mode>\n");
    printf("Debug modes:\n");
    printf("  0: Run program, print memory to stderr after CPU halts\n");
    printf("  1: Print memory to stderr after each CPU instruction execution\n");
    printf("  2: Print memory to stderr after each instruction, wait for keypress\n");
    printf("  3: Print thread table to stderr after context switches and system calls\n");
}

void print_memory_to_stderr() {
    fprintf(stderr, "\n=== MEMORY CONTENTS ===\n");
    for (int i = 0; i < DATA_MEMORY_CAPACITY; i++) {
        if (DATA_MEMORY[i]._sli != 0) {  // Only print non-zero locations
            fprintf(stderr, "Memory[%d] = %ld\n", i, DATA_MEMORY[i]._sli);
        }
    }
    fprintf(stderr, "========================\n\n");
}

void print_thread_table_to_stderr() {
    fprintf(stderr, "\n=== THREAD TABLE CONTENTS ===\n");
    fprintf(stderr, "Current Thread: %ld\n", DATA_MEMORY[19]._sli);  // @CURRENT_THREAD
    fprintf(stderr, "Active Threads: %ld\n", DATA_MEMORY[22]._sli);  // @ACTIVE_THREAD_COUNT
    fprintf(stderr, "Completed: %ld\n", DATA_MEMORY[23]._sli);       // @COMPLETED_THREAD_COUNT
    
    // Print thread table entries (starting at address 40)
    int thread_table_base = 40;
    for (int thread_id = 0; thread_id <= 4; thread_id++) {
        int base_addr = thread_table_base + (thread_id * 10);
        fprintf(stderr, "\nThread %d (Base: %d):\n", thread_id, base_addr);
        fprintf(stderr, "  ID: %ld\n", DATA_MEMORY[base_addr + 0]._sli);
        fprintf(stderr, "  Start Time: %ld\n", DATA_MEMORY[base_addr + 1]._sli);
        fprintf(stderr, "  Instructions Used: %ld\n", DATA_MEMORY[base_addr + 2]._sli);
        fprintf(stderr, "  State: %ld", DATA_MEMORY[base_addr + 3]._sli);
        
        // Decode state
        long state = DATA_MEMORY[base_addr + 3]._sli;
        if (state == 0) fprintf(stderr, " (INACTIVE)");
        else if (state == 1) fprintf(stderr, " (READY)");
        else if (state == 2) fprintf(stderr, " (RUNNING)");
        else if (state == 3) fprintf(stderr, " (BLOCKED)");
        fprintf(stderr, "\n");
        
        fprintf(stderr, "  PC: %ld\n", DATA_MEMORY[base_addr + 4]._sli);
        fprintf(stderr, "  SP: %ld\n", DATA_MEMORY[base_addr + 5]._sli);
        fprintf(stderr, "  FP: %ld\n", DATA_MEMORY[base_addr + 6]._sli);
        fprintf(stderr, "  Unblock Time: %ld\n", DATA_MEMORY[base_addr + 9]._sli);
    }
    fprintf(stderr, "==============================\n\n");
}

int main(int argc, char *argv[]) {
    if (argc != 4 || strcmp(argv[2], "-D") != 0) {
        print_usage();
        return 1;
    }

    char *filename = argv[1];
    debug_mode = atoi(argv[3]);

    if (debug_mode < 0 || debug_mode > 3) {
        fprintf(stderr, "Error: Debug mode must be 0, 1, 2, or 3\n");
        return 1;
    }

    // Initialize CPU
    init_cpu();

    // Open and parse program file
    FILE *fp = fopen(filename, "r");
    if (!fp) {
        fprintf(stderr, "Error: Cannot open file '%s'\n", filename);
        return 1;
    }

    int instruction_count;
    parse_program(fp, &instruction_count);
    fclose(fp);

    printf("Starting GTU-C312 CPU simulation...\n");
    printf("Debug mode: %d\n", debug_mode);
    printf("Instructions loaded: %d\n", instruction_count);

    // Set initial PC from memory location 0
    CPU_PC(&gtu_cpu) = DATA_MEMORY[0]._sli;

    // Variables for tracking system calls and context switches
    long prev_current_thread = DATA_MEMORY[19]._sli;  // @CURRENT_THREAD
    long prev_syscall_res = DATA_MEMORY[2]._sli;      // SYSCALL_RES
    
    // Main execution loop with debug support
    while (!gtu_cpu.halted) {
        // Store previous values for debug mode 3 detection
        long old_current_thread = DATA_MEMORY[19]._sli;
        long old_syscall_res = DATA_MEMORY[2]._sli;
        
        // Execute one instruction
        execute_instruction();
        
        // Debug mode handling
        switch(debug_mode) {
            case 1:
                // Print memory after each instruction
                print_memory_to_stderr();
                break;
                
            case 2:
                // Print memory after each instruction and wait for keypress
                print_memory_to_stderr();
                fprintf(stderr, "Press Enter to continue...");
                getchar();
                break;
                
            case 3:
                // Print thread table after context switches or system calls
                {
                    long new_current_thread = DATA_MEMORY[19]._sli;
                    long new_syscall_res = DATA_MEMORY[2]._sli;
                    
                    // Detect context switch (current thread changed)
                    if (new_current_thread != old_current_thread) {
                        fprintf(stderr, "CONTEXT SWITCH DETECTED: Thread %ld -> Thread %ld\n", 
                               old_current_thread, new_current_thread);
                        print_thread_table_to_stderr();
                    }
                    
                    // Detect system call (syscall result changed)
                    if (new_syscall_res != old_syscall_res) {
                        fprintf(stderr, "SYSTEM CALL DETECTED: Result changed to %ld\n", 
                               new_syscall_res);
                        print_thread_table_to_stderr();
                    }
                }
                break;
                
            case 0:
            default:
                // No debug output during execution
                break;
        }
    }

    printf("CPU halted after %ld instructions\n", CPU_INSTR_COUNT(&gtu_cpu));

    // Debug mode 0: Print memory after halt
    if (debug_mode == 0) {
        print_memory_to_stderr();
    }

    return 0;
}
