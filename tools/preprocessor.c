#include "preprocessor.h"

void init_preprocessor(PreprocessorContext *ctx)
{
    ctx->define_count = 0;
    ctx->macro_count = 0;
    ctx->conditional_depth = 0;
    ctx->current_condition = 1;
    ctx->include_path_count = 0;
    ctx->include_depth = 0;
    ctx->debug_mode = 0;

    // Add current directory to include paths
    strcpy(ctx->include_paths[0], ".");
    ctx->include_path_count = 1;

    // Add built-in defines
    add_builtin_defines(ctx);
}

void add_builtin_defines(PreprocessorContext *ctx)
{
    // GTU-C312 Register definitions
    add_define(ctx, "$PC", "0");
    add_define(ctx, "$SP", "1");
    add_define(ctx, "$SYSCALL_RES", "2");
    add_define(ctx, "$INSTR_COUNT", "3");
    add_define(ctx, "$TEMP1", "4");
    add_define(ctx, "$TEMP2", "5");
    add_define(ctx, "$TEMP3", "6");
    add_define(ctx, "$TEMP4", "7");
    add_define(ctx, "$TEMP5", "8");
    add_define(ctx, "$TEMP6", "9");
    add_define(ctx, "$PARAM1", "10");
    add_define(ctx, "$PARAM2", "11");
    add_define(ctx, "$PARAM3", "12");
    add_define(ctx, "$ZERO", "13");
    add_define(ctx, "$FP", "14");

    // Memory layout constants
    add_define(ctx, "@KERNEL_START", "21");
    add_define(ctx, "@KERNEL_END", "999");
    add_define(ctx, "@USER_START", "1000");
    add_define(ctx, "@THREAD1_START", "1000");
    add_define(ctx, "@THREAD2_START", "2000");
    add_define(ctx, "@THREAD3_START", "3000");
    add_define(ctx, "@THREAD4_START", "4000");
    add_define(ctx, "@THREAD5_START", "5000");
    add_define(ctx, "@THREAD_TABLE_BASE", "40");

    // Sentinel values
    add_define(ctx, "SENTINEL_DEAD", "57005");
    add_define(ctx, "SENTINEL_BEEF", "48879");
    add_define(ctx, "SENTINEL_CAFE", "51966");
    add_define(ctx, "SENTINEL_BABE", "47806");

    // Thread states
    add_define(ctx, "THREAD_INACTIVE", "0");
    add_define(ctx, "THREAD_READY", "1");
    add_define(ctx, "THREAD_RUNNING", "2");
    add_define(ctx, "THREAD_BLOCKED", "3");

    // Thread table structure
    add_define(ctx, "THREAD_ENTRY_SIZE", "10");
    add_define(ctx, "MAX_THREADS", "10");

    // OS data locations
    add_define(ctx, "@OS_STATE", "25");
    add_define(ctx, "@CURRENT_THREAD", "23");
    add_define(ctx, "@THREAD_COUNT", "22");
    add_define(ctx, "@SCHEDULER_COUNTER", "24");
}

int preprocess_file(PreprocessorContext *ctx, const char *input_file, const char *output_file)
{
    FILE *input = fopen(input_file, "r");
    if (!input)
    {
        fprintf(stderr, "Error: Cannot open input file '%s'\n", input_file);
        return 0;
    }

    FILE *output = fopen(output_file, "w");
    if (!output)
    {
        fprintf(stderr, "Error: Cannot create output file '%s'\n", output_file);
        fclose(input);
        return 0;
    }

    char line[MAX_LINE_LENGTH];
    int line_num = 0;

    if (ctx->debug_mode)
    {
        fprintf(stderr, "Preprocessing %s -> %s\n", input_file, output_file);
    }

    while (fgets(line, sizeof(line), input))
    {
        line_num++;

        // Remove newline if present
        size_t len = strlen(line);
        if (len > 0 && line[len - 1] == '\n')
        {
            line[len - 1] = '\0';
        }

        char *processed = process_line(ctx, line, input_file, line_num);
        if (processed)
        {
            fprintf(output, "%s\n", processed);
            if (processed != line)
            {
                free(processed);
            }
        }
    }

    fclose(input);
    fclose(output);

    if (ctx->debug_mode)
    {
        fprintf(stderr, "Preprocessing complete. Processed %d lines.\n", line_num);
    }

    return 1;
}

char *process_line(PreprocessorContext *ctx, const char *line, const char *filename, int line_num)
{
    // Skip empty lines
    if (strlen(line) == 0)
    {
        return strdup(line);
    }

    // Handle preprocessor directives
    if (line[0] == '.')
    {
        if (handle_directive(ctx, line, filename, line_num))
        {
            return NULL; // Directive consumed, don't output
        }
        return strdup(line); // Unknown directive, pass through
    }

    // Skip if we're in a false conditional block
    if (!ctx->current_condition)
    {
        return NULL;
    }

    // Expand defines and macros
    char *expanded = expand_defines(ctx, line);
    char *final = expand_macros(ctx, expanded);

    if (expanded != line)
    {
        free(expanded);
    }

    return final;
}

int handle_directive(PreprocessorContext *ctx, const char *line, const char *filename, int line_num)
{
    char directive[64];
    char args[MAX_LINE_LENGTH];

    // Parse directive
    if (sscanf(line, ".%s %[^\n]", directive, args) < 1)
    {
        return 0;
    }

    if (strcmp(directive, "define") == 0)
    {
        char name[MAX_MACRO_NAME];
        char value[MAX_MACRO_BODY];

        if (sscanf(args, "%s %[^\n]", name, value) == 2)
        {
            add_define(ctx, name, value);
            if (ctx->debug_mode)
            {
                fprintf(stderr, "Defined: %s = %s\n", name, value);
            }
        }
        return 1;
    }

    if (strcmp(directive, "eqv") == 0)
    {
        char name[MAX_MACRO_NAME];
        char value[MAX_MACRO_BODY];

        if (sscanf(args, "%s %s", name, value) == 2)
        {
            add_define(ctx, name, value);
            if (ctx->debug_mode)
            {
                fprintf(stderr, "Defined: %s = %s\n", name, value);
            }
        }
        return 1;
    }

    if (strcmp(directive, "ifdef") == 0)
    {
        char name[MAX_MACRO_NAME];
        if (sscanf(args, "%s", name) == 1)
        {
            ctx->conditional_stack[ctx->conditional_depth] = ctx->current_condition;
            ctx->conditional_depth++;

            int defined = find_define(ctx, name) >= 0;
            ctx->current_condition = ctx->current_condition && defined;

            if (ctx->debug_mode)
            {
                fprintf(stderr, "ifdef %s: %s\n", name, defined ? "true" : "false");
            }
        }
        return 1;
    }

    if (strcmp(directive, "ifndef") == 0)
    {
        char name[MAX_MACRO_NAME];
        if (sscanf(args, "%s", name) == 1)
        {
            ctx->conditional_stack[ctx->conditional_depth] = ctx->current_condition;
            ctx->conditional_depth++;

            int defined = find_define(ctx, name) >= 0;
            ctx->current_condition = ctx->current_condition && !defined;

            if (ctx->debug_mode)
            {
                fprintf(stderr, "ifndef %s: %s\n", name, !defined ? "true" : "false");
            }
        }
        return 1;
    }

    if (strcmp(directive, "else") == 0)
    {
        if (ctx->conditional_depth > 0)
        {
            int parent_condition = ctx->conditional_stack[ctx->conditional_depth - 1];
            ctx->current_condition = parent_condition && !ctx->current_condition;

            if (ctx->debug_mode)
            {
                fprintf(stderr, "else: %s\n", ctx->current_condition ? "true" : "false");
            }
        }
        return 1;
    }

    if (strcmp(directive, "endif") == 0)
    {
        if (ctx->conditional_depth > 0)
        {
            ctx->conditional_depth--;
            ctx->current_condition = ctx->conditional_stack[ctx->conditional_depth];

            if (ctx->debug_mode)
            {
                fprintf(stderr, "endif\n");
            }
        }
        return 1;
    }

    if (strcmp(directive, "include") == 0)
    {
        char filename_buf[256];
        if (sscanf(args, "\"%255[^\"]\"", filename_buf) == 1 ||
            sscanf(args, "%255s", filename_buf) == 1)
        {

            // Find include file
            char full_path[512];
            FILE *include_file = NULL;

            for (int i = 0; i < ctx->include_path_count; i++)
            {
                snprintf(full_path, sizeof(full_path), "%s/%s",
                         ctx->include_paths[i], filename_buf);
                include_file = fopen(full_path, "r");
                if (include_file)
                    break;
            }

            if (!include_file)
            {
                fprintf(stderr, "Error: Include file '%s' not found\n", filename_buf);
                return 1;
            }

            if (ctx->debug_mode)
            {
                fprintf(stderr, "Including: %s\n", full_path);
            }

            // Process include file recursively
            ctx->include_depth++;
            if (ctx->include_depth > MAX_INCLUDE_DEPTH)
            {
                fprintf(stderr, "Error: Include depth exceeded\n");
                fclose(include_file);
                return 1;
            }

            char line[MAX_LINE_LENGTH];
            int inc_line_num = 0;

            while (fgets(line, sizeof(line), include_file))
            {
                inc_line_num++;

                // Remove newline
                size_t len = strlen(line);
                if (len > 0 && line[len - 1] == '\n')
                {
                    line[len - 1] = '\0';
                }

                char *processed = process_line(ctx, line, full_path, inc_line_num);
                if (processed)
                {
                    printf("%s\n", processed);
                    if (processed != line)
                    {
                        free(processed);
                    }
                }
            }

            fclose(include_file);
            ctx->include_depth--;
        }
        return 1;
    }

    return 0; // Unknown directive
}

char *expand_defines(PreprocessorContext *ctx, const char *line)
{
    char *result = malloc(MAX_LINE_LENGTH * 2);
    strcpy(result, line);

    // Multiple passes to handle nested defines
    int changed = 1;
    int passes = 0;

    while (changed && passes < 10)
    {
        changed = 0;
        passes++;

        for (int i = 0; i < ctx->define_count; i++)
        {
            char *pos = result;
            while ((pos = strstr(pos, ctx->defines[i].name)) != NULL)
            {
                // Check if it's a whole word
                int start_ok = (pos == result || !isalnum(pos[-1]) && pos[-1] != '_');
                int end_ok = !isalnum(pos[strlen(ctx->defines[i].name)]) &&
                             pos[strlen(ctx->defines[i].name)] != '_';

                if (start_ok && end_ok)
                {
                    // Replace the define
                    char *new_result = malloc(MAX_LINE_LENGTH * 2);
                    size_t prefix_len = pos - result;

                    strncpy(new_result, result, prefix_len);
                    new_result[prefix_len] = '\0';

                    strcat(new_result, ctx->defines[i].value);
                    strcat(new_result, pos + strlen(ctx->defines[i].name));

                    free(result);
                    result = new_result;
                    changed = 1;
                    break;
                }
                else
                {
                    pos++;
                }
            }
        }
    }

    return result;
}

char *expand_macros(PreprocessorContext *ctx, const char *line)
{
    // For now, just return a copy since we don't have complex macros
    // This can be extended to handle parameterized macros
    return strdup(line);
}

void add_define(PreprocessorContext *ctx, const char *name, const char *value)
{
    if (ctx->define_count >= MAX_DEFINES)
    {
        fprintf(stderr, "Error: Too many defines\n");
        return;
    }

    // Check if already defined
    int index = find_define(ctx, name);
    if (index >= 0)
    {
        // Redefine
        strcpy(ctx->defines[index].value, value);
        return;
    }

    // Add new define
    strcpy(ctx->defines[ctx->define_count].name, name);
    strcpy(ctx->defines[ctx->define_count].value, value);
    ctx->define_count++;
}

int find_define(PreprocessorContext *ctx, const char *name)
{
    for (int i = 0; i < ctx->define_count; i++)
    {
        if (strcmp(ctx->defines[i].name, name) == 0)
        {
            return i;
        }
    }
    return -1;
}

int find_macro(PreprocessorContext *ctx, const char *name)
{
    for (int i = 0; i < ctx->macro_count; i++)
    {
        if (strcmp(ctx->macros[i].name, name) == 0)
        {
            return i;
        }
    }
    return -1;
}

char *trim_whitespace(char *str)
{
    // Trim leading whitespace
    while (isspace(*str))
        str++;

    // Trim trailing whitespace
    char *end = str + strlen(str) - 1;
    while (end > str && isspace(*end))
        end--;
    end[1] = '\0';

    return str;
}

void print_usage(void)
{
    printf("GTU-C312 Preprocessor\n");
    printf("Usage: preprocessor <input.asm> <output.asm> [options]\n");
    printf("Options:\n");
    printf("  -D <name>=<value>  Define a symbol\n");
    printf("  -I <path>          Add include path\n");
    printf("  -v                 Verbose mode\n");
    printf("  -h                 Show this help\n");
}
