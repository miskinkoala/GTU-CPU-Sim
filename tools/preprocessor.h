#ifndef PREPROCESSOR_H
#define PREPROCESSOR_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdint.h>

#define MAX_LINE_LENGTH 1024
#define MAX_MACRO_NAME 64
#define MAX_MACRO_BODY 2048
#define MAX_DEFINES 1000
#define MAX_INCLUDE_DEPTH 10
#define MAX_CONDITIONAL_DEPTH 50

// Macro definition structure
typedef struct
{
    char name[MAX_MACRO_NAME];
    char body[MAX_MACRO_BODY];
    int param_count;
    char params[10][MAX_MACRO_NAME];
} Macro;

// Define structure for simple symbol definitions
typedef struct
{
    char name[MAX_MACRO_NAME];
    char value[MAX_MACRO_BODY];
} Define;

// Preprocessor context
typedef struct
{
    Define defines[MAX_DEFINES];
    int define_count;
    Macro macros[MAX_DEFINES];
    int macro_count;

    // Conditional compilation stack
    int conditional_stack[MAX_CONDITIONAL_DEPTH];
    int conditional_depth;
    int current_condition;

    // Include handling
    char include_paths[10][256];
    int include_path_count;
    int include_depth;

    // Debug mode
    int debug_mode;
} PreprocessorContext;

// Function prototypes
void init_preprocessor(PreprocessorContext *ctx);
void add_builtin_defines(PreprocessorContext *ctx);
int preprocess_file(PreprocessorContext *ctx, const char *input_file, const char *output_file);
char *process_line(PreprocessorContext *ctx, const char *line, const char *filename, int line_num);
int handle_directive(PreprocessorContext *ctx, const char *line, const char *filename, int line_num);
char *expand_defines(PreprocessorContext *ctx, const char *line);
char *expand_macros(PreprocessorContext *ctx, const char *line);
void add_define(PreprocessorContext *ctx, const char *name, const char *value);
void add_macro(PreprocessorContext *ctx, const char *name, const char *params[], int param_count, const char *body);
int find_define(PreprocessorContext *ctx, const char *name);
int find_macro(PreprocessorContext *ctx, const char *name);
char *trim_whitespace(char *str);
void print_usage(void);

#endif
