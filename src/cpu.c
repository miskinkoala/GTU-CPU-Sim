// TODO: CALL function does not work as intended
// cpu.c
// CUSTOM headers
#include "cpu.h" //ISA, CPU, Memory arctectures
// #include "common.h"

// Standart headers
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Global variable definitions
Instruction INST_MEMORY[INST_MEMORY_CAPACITY];
DATA DATA_MEMORY[DATA_MEMORY_CAPACITY];
CPU gtu_cpu;
int debug_mode = 0;

// Jump table for instruction handlers
typedef void (*instruction_handler_t)(WORD *, int);

void handle_set(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
        SET(operands[0], operands[1]);
}

void handle_cpy(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
        CPY(operands[0], operands[1]);
}

void handle_cpyi(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
        CPYI(operands[0], operands[1]);
}

void handle_cpyi2(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
    {
        CPYI2(operands[0], operands[1]);
    }
    else
    {
        printf("CPYI2 requires 2 operands\n");
    }
}

void handle_add(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
        ADD(operands[0], operands[1]);
}

void handle_addi(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
        ADDI(operands[0], operands[1]);
}

void handle_subi(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
        SUBI(operands[0], operands[1]);
}

void handle_jif(WORD *operands, int num_ops)
{
    if (num_ops >= 2)
        JIF(operands[0], operands[1]);
}

void handle_push(WORD *operands, int num_ops)
{
    if (num_ops >= 1)
        PUSH(operands[0]);
}

void handle_pop(WORD *operands, int num_ops)
{
    if (num_ops >= 1)
        POP(operands[0]);
}

void handle_call(WORD *operands, int num_ops)
{
    if (num_ops >= 1)
        CALL(operands[0]);
}

void handle_ret()
{
    RET();
}

void handle_hlt()
{
    HLT();
}

void handle_user(WORD *operands, int num_ops)
{
    if (num_ops >= 1)
        USER(operands[0]);
}

void handle_syscall_prn(WORD *operands, int num_ops)
{
    if (num_ops >= 1)
        SYSCALL_PRN(operands[0]);
}

void handle_syscall_hlt()
{
    SYSCALL_HLT();
}

void handle_syscall_yield()
{
    SYSCALL_YIELD();
}

// Jump table array
instruction_handler_t instruction_handlers[] = {
    handle_set,          // OP_SET
    handle_cpy,          // OP_CPY
    handle_cpyi,         // OP_CPYI
    handle_cpyi2,        // OP_CPYI2 - Updated this line
    handle_add,          // OP_ADD
    handle_addi,         // OP_ADDI
    handle_subi,         // OP_SUBI
    handle_jif,          // OP_JIF
    handle_push,         // OP_PUSH
    handle_pop,          // OP_POP
    handle_call,         // OP_CALL
    handle_ret,          // OP_RET
    handle_hlt,          // OP_HLT
    handle_user,         // OP_USER
    handle_syscall_prn,  // OP_SYSCALL_PRN
    handle_syscall_hlt,  // OP_SYSCALL_HLT
    handle_syscall_yield // OP_SYSCALL_YIELD
};

opcode_t string_to_opcode(const char *opcode_str)
{
    if (strcmp(opcode_str, "SET") == 0)
        return OP_SET;
    if (strcmp(opcode_str, "CPY") == 0)
        return OP_CPY;
    if (strcmp(opcode_str, "CPYI") == 0)
        return OP_CPYI;
    if (strcmp(opcode_str, "CPYI2") == 0)
        return OP_CPYI2;
    if (strcmp(opcode_str, "ADD") == 0)
        return OP_ADD;
    if (strcmp(opcode_str, "ADDI") == 0)
        return OP_ADDI;
    if (strcmp(opcode_str, "SUBI") == 0)
        return OP_SUBI;
    if (strcmp(opcode_str, "JIF") == 0)
        return OP_JIF;
    if (strcmp(opcode_str, "PUSH") == 0)
        return OP_PUSH;
    if (strcmp(opcode_str, "POP") == 0)
        return OP_POP;
    if (strcmp(opcode_str, "CALL") == 0)
        return OP_CALL;
    if (strcmp(opcode_str, "RET") == 0)
        return OP_RET;
    if (strcmp(opcode_str, "HLT") == 0)
        return OP_HLT;
    if (strcmp(opcode_str, "USER") == 0)
        return OP_USER;
    if (strcmp(opcode_str, "SYSCALL") == 0)
        return OP_SYSCALL_PRN;
    return OP_UNKNOWN;
}

// helper functions
int is_valid_memory_address(MEM_LOCATION addr);
void parse_program(FILE *file, int *instruction_count);
int can_access_memory(MEM_LOCATION addr);

/*
CPU FUNCTIONALITIES
*/
void init_cpu()
{
    // CPU cpu;
    gtu_cpu.mode.mode = 'K'; // Start in kernel mode
    gtu_cpu.halted = 0;

    // Initialize register pointers
    init_cpu_registers();

    // Set initial register values
    CPU_PC(&gtu_cpu) = 0;          // Program Counter starts at 0
    CPU_SP(&gtu_cpu) = 0;          // Stack Pointer starts at 1000
    CPU_SYSCALL_RES(&gtu_cpu) = 0; // System call result
    CPU_INSTR_COUNT(&gtu_cpu) = 0; // Instruction count
}

void init_cpu_registers()
{
    for (int i = 0; i < REGISTER_NUMBER; i++)
    {
        gtu_cpu.registers[i] = (WORD *)&DATA_MEMORY[i]._sli;
    }
}

void changeMode()
{
    if (gtu_cpu.mode.mode == 'K')
    {
        gtu_cpu.mode.mode = 'U';
        printf("CPU switched to USER mode\n");
    }
    else
    {
        gtu_cpu.mode.mode = 'K';
        printf("CPU switched to KERNEL mode\n");
    }
}

void execute_instruction()
{
    INSTR_ADDR current_pc = CPU_PC(&gtu_cpu);
    printf("PC: %ld -> ", current_pc);

    // Bounds check
    if (current_pc >= INST_MEMORY_CAPACITY)
    {
        printf("Error: PC out of bounds: %ld\n", current_pc);
        gtu_cpu.halted = 1;
        return;
    }

    // FIXED: Direct access by PC address
    Instruction *current_instr = &INST_MEMORY[current_pc];

    // Check if instruction exists at this address
    if (current_instr->opcode == OP_UNKNOWN)
    {
        printf("Error: No instruction at PC %ld\n", current_pc);
        CPU_PC(&gtu_cpu)
        ++;
        return;
        // gtu_cpu.halted = 1;
        // return;
    }

    // Store current PC to detect if instruction modified it
    WORD old_pc = current_pc;

    printf("Executing: %s", current_instr->opcode_str);
    for (int i = 0; i < current_instr->num_operands; i++)
    {
        printf(" %ld", current_instr->operands[i]);
    }
    printf("\n");

    // Execute the instruction
    if (current_instr->opcode < OP_UNKNOWN && instruction_handlers[current_instr->opcode] != NULL)
    {
        instruction_handlers[current_instr->opcode](current_instr->operands, current_instr->num_operands);
    }

    // Only increment PC if instruction didn't modify it
    if (CPU_PC(&gtu_cpu) == old_pc)
    {
        CPU_PC(&gtu_cpu)
        ++;
    }

    CPU_INSTR_COUNT(&gtu_cpu)
    ++;
}

/*
int main(int argc, char *argv[])
{
    init_cpu(DATA_MEMORY);
    FILE *fp = fopen("programs/partition_OS_only", "r");

    if (fp == NULL)
    {
        printf("file could not be opended\n");
        return -1;
    }
    // Instruction instructions[1024];
    int instruction_count = 0;
    parse_program(fp, &instruction_count);

    while (!gtu_cpu.halted)
    {
        execute_instruction();
    }

    fclose(fp);
}
*/
int is_valid_memory_address(MEM_LOCATION addr)
{
    return (addr < DATA_MEMORY_CAPACITY);
}

// Helper function to check user mode memory access
int can_access_memory(MEM_LOCATION addr)
{
    if (gtu_cpu.mode.mode == 'K')
    {
        return is_valid_memory_address(addr); // Kernel can access all valid memory
    }
    else
    {                                                           // User mode
        return (addr >= 1000 && is_valid_memory_address(addr)); // User can only access 1000+
    }
}

// loader

void parse_program(FILE *file, int *instruction_count)
{
    char line[256];
    int parsing_data = 0;
    int parsing_instructions = 0;
    *instruction_count = 0;

    // Initialize instruction memory - mark all as invalid
    for (int i = 0; i < INST_MEMORY_CAPACITY; i++)
    {
        INST_MEMORY[i].opcode = OP_UNKNOWN;
        INST_MEMORY[i].num_operands = 0;
        strcpy(INST_MEMORY[i].opcode_str, "INVALID");
    }

    while (fgets(line, sizeof(line), file))
    {
        // Skip empty lines and comments
        if (line[0] == '#' || line[0] == '\n' || strlen(line) == 0)
        {
            continue;
        }

        // Check for section markers
        if (strstr(line, "Begin Data Section"))
        {
            parsing_data = 1;
            parsing_instructions = 0;
            printf("Starting data section parsing...\n");
            continue;
        }
        else if (strstr(line, "End Data Section"))
        {
            parsing_data = 0;
            printf("Finished data section parsing.\n");
            continue;
        }
        else if (strstr(line, "Begin Instruction Section"))
        {
            parsing_instructions = 1;
            parsing_data = 0;
            printf("Starting instruction section parsing...\n");
            continue;
        }
        else if (strstr(line, "End Instruction Section"))
        {
            parsing_instructions = 0;
            printf("Finished instruction section parsing.\n");
            break;
        }

        // Parse data section
        if (parsing_data)
        {
            int address;
            long value;
            if (sscanf(line, "%d %ld", &address, &value) == 2)
            {
                if (address >= 0 && address < DATA_MEMORY_CAPACITY)
                {
                    DATA_MEMORY[address]._sli = value;
                    printf("Loaded data: DATA_MEMORY[%d] = %ld\n", address, value);
                }
                else
                {
                    printf("Warning: Data address %d out of bounds, skipping.\n", address);
                }
            }
            else
            {
                printf("Warning: Could not parse data line: %s", line);
            }
        }

        // Parse instruction section - FIXED: Parse first, then validate
        if (parsing_instructions)
        {
            int addr = -1; // Initialize to invalid value
            char op[16];
            long op1, op2;

            // Special handling for SYSCALL instructions
            if (strstr(line, "SYSCALL"))
            {
                if (strstr(line, "SYSCALL PRN"))
                {
                    long operand;
                    // PARSE FIRST, then validate
                    int parsed = sscanf(line, "%d SYSCALL PRN %ld", &addr, &operand);
                    if (parsed != 2)
                    {
                        printf("Warning: Could not parse SYSCALL PRN line: %s", line);
                        continue;
                    }

                    // NOW check bounds after successful parsing
                    if (addr < 0 || addr >= INST_MEMORY_CAPACITY)
                    {
                        printf("Error: Instruction address %d out of bounds, skipping.\n", addr);
                        continue;
                    }

                    INST_MEMORY[addr].opcode = OP_SYSCALL_PRN;
                    strncpy(INST_MEMORY[addr].opcode_str, "SYSCALL PRN",
                            sizeof(INST_MEMORY[addr].opcode_str) - 1);
                    INST_MEMORY[addr].opcode_str[sizeof(INST_MEMORY[addr].opcode_str) - 1] = '\0';
                    INST_MEMORY[addr].operands[0] = operand;
                    INST_MEMORY[addr].num_operands = 1;

                    printf("Parsed instruction %d: SYSCALL PRN (enum: %d) %ld\n",
                           addr, INST_MEMORY[addr].opcode, operand);
                    (*instruction_count)++;
                }
                else if (strstr(line, "SYSCALL HLT"))
                {
                    // PARSE FIRST, then validate
                    int parsed = sscanf(line, "%d SYSCALL HLT", &addr);
                    if (parsed != 1)
                    {
                        printf("Warning: Could not parse SYSCALL HLT line: %s", line);
                        continue;
                    }

                    if (addr < 0 || addr >= INST_MEMORY_CAPACITY)
                    {
                        printf("Error: Instruction address %d out of bounds, skipping.\n", addr);
                        continue;
                    }

                    INST_MEMORY[addr].opcode = OP_SYSCALL_HLT;
                    strncpy(INST_MEMORY[addr].opcode_str, "SYSCALL HLT",
                            sizeof(INST_MEMORY[addr].opcode_str) - 1);
                    INST_MEMORY[addr].opcode_str[sizeof(INST_MEMORY[addr].opcode_str) - 1] = '\0';
                    INST_MEMORY[addr].num_operands = 0;

                    printf("Parsed instruction %d: SYSCALL HLT (enum: %d)\n",
                           addr, INST_MEMORY[addr].opcode);
                    (*instruction_count)++;
                }
                else if (strstr(line, "SYSCALL YIELD"))
                {
                    // PARSE FIRST, then validate
                    int parsed = sscanf(line, "%d SYSCALL YIELD", &addr);
                    if (parsed != 1)
                    {
                        printf("Warning: Could not parse SYSCALL YIELD line: %s", line);
                        continue;
                    }

                    if (addr < 0 || addr >= INST_MEMORY_CAPACITY)
                    {
                        printf("Error: Instruction address %d out of bounds, skipping.\n", addr);
                        continue;
                    }

                    INST_MEMORY[addr].opcode = OP_SYSCALL_YIELD;
                    strncpy(INST_MEMORY[addr].opcode_str, "SYSCALL YIELD",
                            sizeof(INST_MEMORY[addr].opcode_str) - 1);
                    INST_MEMORY[addr].opcode_str[sizeof(INST_MEMORY[addr].opcode_str) - 1] = '\0';
                    INST_MEMORY[addr].num_operands = 0;

                    printf("Parsed instruction %d: SYSCALL YIELD (enum: %d)\n",
                           addr, INST_MEMORY[addr].opcode);
                    (*instruction_count)++;
                }
                else
                {
                    printf("Warning: Unknown SYSCALL format: %s", line);
                    continue;
                }
            }
            else
            {
                // Handle regular instructions (non-SYSCALL)
                // PARSE FIRST, then validate
                int parsed = sscanf(line, "%d %s %ld %ld", &addr, op, &op1, &op2);

                if (parsed < 2)
                {
                    printf("Warning: Could not parse instruction line: %s", line);
                    continue;
                }

                // NOW check bounds after successful parsing
                if (addr < 0 || addr >= INST_MEMORY_CAPACITY)
                {
                    printf("Error: Instruction address %d out of bounds, skipping.\n", addr);
                    continue;
                }

                INST_MEMORY[addr].opcode = string_to_opcode(op);
                strncpy(INST_MEMORY[addr].opcode_str, op,
                        sizeof(INST_MEMORY[addr].opcode_str) - 1);
                INST_MEMORY[addr].opcode_str[sizeof(INST_MEMORY[addr].opcode_str) - 1] = '\0';

                INST_MEMORY[addr].num_operands = parsed - 2;

                if (parsed >= 3)
                {
                    INST_MEMORY[addr].operands[0] = op1;
                }
                if (parsed >= 4)
                {
                    INST_MEMORY[addr].operands[1] = op2;
                }

                printf("Parsed instruction %d: %s (enum: %d)", addr, op, INST_MEMORY[addr].opcode);
                for (int i = 0; i < INST_MEMORY[addr].num_operands; i++)
                {
                    printf(" %ld", INST_MEMORY[addr].operands[i]);
                }
                printf("\n");

                (*instruction_count)++;
            }
        }
    }

    printf("Parsing complete. Loaded %d instructions.\n", *instruction_count);
}

void print_memory_state()
{
    fprintf(stderr, "=== Memory State ===\n");
    for (int i = 0; i < 100; i++)
    { // Print first 100 memory locations
        if (DATA_MEMORY[i]._sli != 0)
        {
            fprintf(stderr, "MEMORY[%d] = %ld\n", i, DATA_MEMORY[i]._sli);
        }
    }
    fprintf(stderr, "==================\n");
}

void print_thread_table()
{
    fprintf(stderr, "=== Thread Table ===\n");
    for (int i = 0; i < 4; i++)
    { // Print first 4 threads
        int base = 40 + i * 10;
        fprintf(stderr, "Thread %d: ID=%ld, State=%ld, PC=%ld, SP=%ld\n",
                i, DATA_MEMORY[base]._sli, DATA_MEMORY[base + 3]._sli,
                DATA_MEMORY[base + 4]._sli, DATA_MEMORY[base + 5]._sli);
    }
    fprintf(stderr, "===================\n");
}

// ISA function implementations

void SET(const CONSTANT B, MEM_LOCATION A)
{
    if (!can_access_memory(A))
    {
        printf("Memory access violation at address %lu\n", A);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    DATA_MEMORY[A]._sli = B;
    printf("SET: MEMORY[%lu] = %ld\n", A, B);
}

void CPY(const MEM_LOCATION A1, MEM_LOCATION A2)
{
    if (!can_access_memory(A1) || !can_access_memory(A2))
    {
        printf("Memory access violation\n");
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    DATA_MEMORY[A2]._sli = DATA_MEMORY[A1]._sli;
    printf("CPY: MEMORY[%lu] -> MEMORY[%lu] = %ld\n", A1, A2, DATA_MEMORY[A2]._sli);
}

void CPYI(const MEM_LOCATION A1, MEM_LOCATION A2)
{
    if (!can_access_memory(A1) || !can_access_memory(A2))
    {
        printf("Memory access violation\n");
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    MEM_LOCATION indirect_addr = DATA_MEMORY[A1]._sli;
    if (!can_access_memory(indirect_addr))
    {
        printf("Indirect memory access violation at address %lu\n", indirect_addr);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    DATA_MEMORY[A2]._sli = DATA_MEMORY[indirect_addr]._sli;
    printf("CPYI: MEMORY[MEMORY[%lu]] -> MEMORY[%lu] = %ld\n", A1, A2, DATA_MEMORY[A2]._sli);
}

void CPYI2(MEM_LOCATION A1, MEM_LOCATION A2)
{
    // Check if we can access the initial memory locations A1 and A2
    if (!can_access_memory(A1) || !can_access_memory(A2))
    {
        printf("Memory access violation at initial addresses A1=%lu or A2=%lu\n", A1, A2);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1; // Shutdown thread in user mode
        }
        return;
    }

    // Get the indirect addresses from both A1 and A2
    MEM_LOCATION source_addr = DATA_MEMORY[A1]._sli; // Address stored in A1
    MEM_LOCATION dest_addr = DATA_MEMORY[A2]._sli;   // Address stored in A2

    // Check if we can access both indirect addresses
    if (!can_access_memory(source_addr))
    {
        printf("Indirect source memory access violation at address %lu (from A1=%lu)\n", source_addr, A1);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    if (!can_access_memory(dest_addr))
    {
        printf("Indirect destination memory access violation at address %lu (from A2=%lu)\n", dest_addr, A2);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    // Perform the double indirect copy: MEMORY[MEMORY[A1]] -> MEMORY[MEMORY[A2]]
    DATA_MEMORY[dest_addr]._sli = DATA_MEMORY[source_addr]._sli;

    printf("CPYI2: MEMORY[MEMORY[%lu]] -> MEMORY[MEMORY[%lu]] = %ld\n",
           A1, A2, DATA_MEMORY[dest_addr]._sli);
    printf("       (source: MEMORY[%lu] -> dest: MEMORY[%lu])\n",
           source_addr, dest_addr);
}

void ADD(MEM_LOCATION A, CONSTANT B)
{
    if (!can_access_memory(A))
    {
        printf("Memory access violation at address %lu\n", A);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    DATA_MEMORY[A]._sli += B;
    printf("ADD: MEMORY[%lu] += %ld = %ld\n", A, B, DATA_MEMORY[A]._sli);
}

void ADDI(MEM_LOCATION A1, MEM_LOCATION A2)
{
    if (!can_access_memory(A1) || !can_access_memory(A2))
    {
        printf("Memory access violation\n");
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    DATA_MEMORY[A1]._sli += DATA_MEMORY[A2]._sli;
    printf("ADDI: MEMORY[%lu] += MEMORY[%lu] = %ld\n", A1, A2, DATA_MEMORY[A1]._sli);
}

void SUBI(const MEM_LOCATION A1, MEM_LOCATION A2)
{
    if (!can_access_memory(A1) || !can_access_memory(A2))
    {
        printf("Memory access violation\n");
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    DATA_MEMORY[A2]._sli = DATA_MEMORY[A2]._sli - DATA_MEMORY[A1]._sli;
    printf("SUBI: MEMORY[%lu] - MEMORY[%lu] = %ld (stored in MEMORY[%lu])\n",
           A2, A1, DATA_MEMORY[A2]._sli, A2);
}

void JIF(MEM_LOCATION A, INSTR_ADDR C)
{
    if (!can_access_memory(A))
    {
        printf("Memory access violation at address %lu\n", A);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    if (DATA_MEMORY[A]._sli <= 0)
    {
        CPU_PC(&gtu_cpu) = C;
        // printf("CPU_PC: %ld\n", CPU_PC(&gtu_cpu));
        // printf("C: %ld\n", C);

        printf("JIF: Jump to %lu (condition met: MEMORY[%lu] = %ld <= 0)\n",
               C, A, DATA_MEMORY[A]._sli);
    }
    else
    {
        printf("JIF: No jump (condition not met: MEMORY[%lu] = %ld > 0)\n",
               A, DATA_MEMORY[A]._sli);
        // PC will be incremented normally by execute_instruction
    }
}

void PUSH(const MEM_LOCATION A)
{
    if (!can_access_memory(A))
    {
        printf("Memory access violation at address %lu\n", A);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    CPU_SP(&gtu_cpu)
    --;

    if (!can_access_memory(CPU_SP(&gtu_cpu)))
    {
        printf("Stack overflow\n");
        gtu_cpu.halted = 1;
        return;
    }

    DATA_MEMORY[CPU_SP(&gtu_cpu)]._sli = DATA_MEMORY[A]._sli;
    printf("PUSH: MEMORY[%lu] pushed to stack at SP=%ld\n", A, CPU_SP(&gtu_cpu));
}

void POP(MEM_LOCATION A)
{
    if (!can_access_memory(A))
    {
        printf("Memory access violation at address %lu\n", A);
        if (gtu_cpu.mode.mode == 'U')
        {
            gtu_cpu.halted = 1;
        }
        return;
    }

    if (!can_access_memory(CPU_SP(&gtu_cpu)))
    {
        printf("Stack underflow\n");
        gtu_cpu.halted = 1;
        return;
    }

    DATA_MEMORY[A]._sli = DATA_MEMORY[CPU_SP(&gtu_cpu)]._sli;
    printf("POP: Value %ld popped from stack to MEMORY[%lu]\n", DATA_MEMORY[A]._sli, A);

    CPU_SP(&gtu_cpu)
    ++;
}

void CALL(INSTR_ADDR C)
{
    WORD return_addr = CPU_PC(&gtu_cpu) + 1;
    CPU_SP(&gtu_cpu)
    --;

    if (!can_access_memory(CPU_SP(&gtu_cpu)))
    {
        printf("Stack overflow during CALL\n");
        gtu_cpu.halted = 1;
        return;
    }

    DATA_MEMORY[CPU_SP(&gtu_cpu)]._sli = return_addr;
    CPU_PC(&gtu_cpu) = C;
    // printf("CPU_PC: %ld\n", CPU_PC(&gtu_cpu));
    // printf("C: %ld\n", C);

    printf("CALL: Subroutine at %lu called, return address %ld pushed\n", C, return_addr);
}

void RET()
{
    if (!can_access_memory(CPU_SP(&gtu_cpu)))
    {
        printf("Stack underflow during RET\n");
        gtu_cpu.halted = 1;
        return;
    }

    WORD return_addr = DATA_MEMORY[CPU_SP(&gtu_cpu)]._sli;
    CPU_PC(&gtu_cpu) = return_addr;
    CPU_SP(&gtu_cpu)
    ++;

    printf("RET: Returned to address %ld\n", return_addr);
}

void HLT()
{
    gtu_cpu.halted = 1;
    printf("HLT: CPU halted\n");
}

void USER(MEM_LOCATION A)
{
    if (!can_access_memory(A))
    {
        printf("Memory access violation at address %lu\n", A);
        return;
    }

    gtu_cpu.mode.mode = 'U';
    CPU_PC(&gtu_cpu) = DATA_MEMORY[A]._sli;

    printf("USER: Switched to user mode, jumped to address %ld\n", DATA_MEMORY[A]._sli);
}

void SYSCALL_PRN(MEM_LOCATION A)
{
    // Automatically switch to kernel mode
    gtu_cpu.mode.mode = 'K';

    if (!is_valid_memory_address(A))
    {
        printf("Invalid memory address for SYSCALL PRN: %lu\n", A);
        CPU_SYSCALL_RES(&gtu_cpu) = -1; // Error
        return;
    }

    // Print the value
    printf("%ld\n", DATA_MEMORY[A]._sli);

    // Block for 100 instruction executions (simulate I/O delay)
    // CPU_INSTR_COUNT(&gtu_cpu) += 100;

    // Set success result
    CPU_SYSCALL_RES(&gtu_cpu) = 0;

    printf("SYSCALL PRN: Printed %ld, blocked for 100 instructions\n", DATA_MEMORY[A]._sli);
}

void SYSCALL_HLT()
{
    // Set syscall result to indicate HLT was called
    CPU_SYSCALL_RES(&gtu_cpu) = 3;

    printf("SYSCALL HLT: Thread terminating\n");

    // In a real implementation, this would mark thread as inactive
    // For simulation, we just mark that a halt occurred
}

void SYSCALL_YIELD()
{
    // Set syscall result to indicate YIELD was called
    CPU_SYSCALL_RES(&gtu_cpu) = 2;

    printf("SYSCALL YIELD: Thread yielding CPU\n");

    // In a real implementation, this would trigger context switching
    // For simulation, we just mark that a yield occurred
}
