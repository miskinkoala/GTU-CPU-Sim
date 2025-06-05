#include "cpu.c"

void print_usage() {
    printf("Usage: ./simulator <filename> -D <debug_mode>\n");
    printf("Debug modes:\n");
    printf("  0: Run program, print memory after halt\n");
    printf("  1: Print memory after each instruction\n");
    printf("  2: Print memory after each instruction, wait for keypress\n");
    printf("  3: Print thread table after context switches and system calls\n");
}

int main(int argc, char *argv[]) {
    if (argc != 4 || strcmp(argv[2], "-D") != 0) {
        print_usage();
        return 1;
    }
    
    char *filename = argv[1];
    int debug_mode = atoi(argv[3]);
    
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
    CPU_PC(&gtu_cpu) = DATA_MEMORY[0];
    
    // Main execution loop
    while (!gtu_cpu.halted) {
        execute_instruction();
    }
    
    printf("CPU halted after %ld instructions\n", CPU_INSTR_COUNT(&gtu_cpu));
    
    // Print final memory state for debug mode 0
    if (debug_mode == 0) {
        print_memory_state();
    }
    
    return 0;
}
