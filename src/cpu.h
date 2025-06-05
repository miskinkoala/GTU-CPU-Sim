// TODO: change Mode struct to enum
#include <stdio.h>

// cpu.h starts
#ifndef CPU_H
#define CPU_H

// #include "common.h"
#define REGISTER_NUMBER 21
#define PROGRAM_COUNTER_SLOT 0
#define STACK_POINTER_SLOT 1
#define SYSTEM_CALL_RESULT_SLOT 2
#define NUM_OF_EXEC_SO_FAR_SLOT 3
#define DATA_MEMORY_CAPACITY 11000
#define INST_MEMORY_CAPACITY 11000
// #define WORD_SIZE sizeof(signed long int)
#define CPU_PC(pCpu) (*((pCpu)->registers[PROGRAM_COUNTER_SLOT]))
#define CPU_SP(pCpu) (*((pCpu)->registers[STACK_POINTER_SLOT]))
#define CPU_SYSCALL_RES(pCpu) (*((pCpu)->registers[SYSTEM_CALL_RESULT_SLOT]))
#define CPU_INSTR_COUNT(pCpu) (*((pCpu)->registers[NUM_OF_EXEC_SO_FAR_SLOT]))

typedef signed long int WORD;
typedef const signed long int CONSTANT;
typedef unsigned long int PROGRAM_COUNTER;
typedef unsigned long int MEM_LOCATION;
typedef PROGRAM_COUNTER INSTR_ADDR;

typedef enum
{
    OP_SET = 0,
    OP_CPY,
    OP_CPYI,
    OP_CPYI2,
    OP_ADD,
    OP_ADDI,
    OP_SUBI,
    OP_JIF,
    OP_PUSH,
    OP_POP,
    OP_CALL,
    OP_RET,
    OP_HLT,
    OP_USER,
    OP_SYSCALL_PRN,
    OP_SYSCALL_HLT,
    OP_SYSCALL_YIELD,
    OP_UNKNOWN
} opcode_t;

typedef union
{
    signed long int _sli;
    double _f;
    char _c;
    char _str[64]; // String option - adjust size as needed
} DATA;

typedef struct
{
    char mode; // kernel mode or user mode U: USER, K:KERNEL
} Mode;

typedef struct
{
    WORD *registers[REGISTER_NUMBER];
    Mode mode;
    int halted;
} CPU;

typedef struct
{
    opcode_t opcode; // e.g., "SET", "JIF"
    char opcode_str[16];
    int num_operands;
    WORD operands[2]; // Supports up to 2 operands //unsigned or signed in case of mem loc
} Instruction;

/*
Assembler
*/
void parse_program(FILE *file, int *instruction_count);

/*
Debug Funcs
*/
void print_memory_state(void);

void print_thread_table(void);

extern int debug_mode; // Declare debug_mode as extern

/*
CPU FUNTIONALTTIES
*/
void init_cpu();
/*
inilize gtu cpu with its starting values
*/
void init_cpu_registers();
/*
assiign gtu cpu register to corresponding memory addresses 0-20
*/

void changeMode();
/*
change cpu's mode
*/
void execute_instruction();
/*
execute given instruciton
*/

/*
ISA
*/
void SET(const CONSTANT B, MEM_LOCATION A);
/*
Direct Set : Set the Ath memory location with number B. Example:
SET -20, 100 writes the value of -20 to memory location 100.
*/

void CPY(const MEM_LOCATION A1, MEM_LOCATION A2);
/*
Direct Copy: Copy the content of memory location A1 to memory A2.
Example: CPY 100, 120 copies the memory value of address 100 to the
memory address 120
*/

void CPYI(const MEM_LOCATION A1, MEM_LOCATION A2);
/*
Indirect Copy: Copy the memory address indexed by A1 to memory
address A2. Example: CPYI 100, 120: if memory address 100 contains
200, then this instruction copies the contents of memory address 200 to
memory location 120.
*/

void CPYI2(MEM_LOCATION A1, MEM_LOCATION A2);
/*
Indirect Copy 2: Copy the memory address indexed by A1 to memory
address indexed by A2. Example: CPYI2 100, 120: if memory address 100
contains 200, and 120 contains 300 then this instruction copies the contents
of memory address 200 to memory location 300.
*/

void ADD(MEM_LOCATION A, CONSTANT B);
/*
Add number B to memory location A
*/

void ADDI(MEM_LOCATION A1, MEM_LOCATION A2);
/*
Indirect Add: Add the contents of memory address A2 to address A1.
*/

void SUBI(const MEM_LOCATION A1, MEM_LOCATION A2);
/*
Indirect Subtraction: Subtract the contents of memory address A2 from
address A1, put the result in A2
*/
void JIF(MEM_LOCATION A, INSTR_ADDR C);
/*
Set the CPU program counter with C if memory location A content is less
than or equal to 0
*/
void PUSH(const MEM_LOCATION A);
/*
Push memory A onto the stack. Stack grows downwards.
*/
void POP(MEM_LOCATION A);
/*
Pop value from stack into memory A
*/
void CALL(INSTR_ADDR C);
/*
Call subroutine at instruction C, push return address.
*/
void RET();
/*
Return from subroutine by popping return address.
*/
void HLT();
/*
Halts the CPU
*/
void USER(MEM_LOCATION A);
/*
Switch to user mode and jump to address contained at location Ard
*/
void SYSCALL_PRN(MEM_LOCATION A);
/*
Calls the operting system service. This system call prints the contents of
memory address A to the console followed by a new line character. This
system call will block the calling thread for 100 instruction executions
*/
void SYSCALL_HLT();
/*
Calls the operting system service. Shuts down the thread
*/

void SYSCALL_YIELD();
/*
Calls the operting system service. Yields the CPU so OS can schedule
other threads.
*/

// variable definitions
extern Instruction INST_MEMORY[INST_MEMORY_CAPACITY];
extern DATA DATA_MEMORY[DATA_MEMORY_CAPACITY];
extern CPU gtu_cpu;

#endif
////cpu.h ends
