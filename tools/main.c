#include "preprocessor.h"

int main(int argc, char *argv[])
{
    if (argc < 3)
    {
        print_usage();
        return 1;
    }

    PreprocessorContext ctx;
    init_preprocessor(&ctx);

    char *input_file = argv[1];
    char *output_file = argv[2];

    // Parse command line options
    for (int i = 3; i < argc; i++)
    {
        if (strcmp(argv[i], "-v") == 0)
        {
            ctx.debug_mode = 1;
        }
        else if (strcmp(argv[i], "-h") == 0)
        {
            print_usage();
            return 0;
        }
        else if (strncmp(argv[i], "-D", 2) == 0)
        {
            char *define_str = argv[i] + 2;
            if (strlen(define_str) == 0 && i + 1 < argc)
            {
                define_str = argv[++i];
            }

            char *equals = strchr(define_str, '=');
            if (equals)
            {
                *equals = '\0';
                add_define(&ctx, define_str, equals + 1);
            }
            else
            {
                add_define(&ctx, define_str, "1");
            }
        }
        else if (strncmp(argv[i], "-I", 2) == 0)
        {
            char *path = argv[i] + 2;
            if (strlen(path) == 0 && i + 1 < argc)
            {
                path = argv[++i];
            }

            if (ctx.include_path_count < 10)
            {
                strcpy(ctx.include_paths[ctx.include_path_count], path);
                ctx.include_path_count++;
            }
        }
    }

    if (!preprocess_file(&ctx, input_file, output_file))
    {
        return 1;
    }

    printf("Preprocessing complete: %s -> %s\n", input_file, output_file);
    return 0;
}
