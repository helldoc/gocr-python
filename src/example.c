#include <stdio.h>

int example_main(int argc, char **argv) {
	for(int i =0; i < argc; ++i) {
		fprintf(stdout, "%s", argv[1]);
	}
	return 0;
}

void echo(void) {
    printf("\"Hello World\"\n");
}

void echo_string(char *string) {
	fprintf(stdout, "%s", string);
}

void echo_argv(char **strings) {
    int i = 0;
    while (strings[i]) {
         printf("strings[%d] = %s\n", i,strings[i]);
         i++;
    }
    return i;
}

void echo_argv_2param(char **strings, int argc){
    int i = 0;
    while (strings[i]) {
         printf("strings[%d] = %s\n", i,strings[i]);
         i++;
    }
    return argc;
}
