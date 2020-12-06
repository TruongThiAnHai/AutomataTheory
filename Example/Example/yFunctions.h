#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

//функция вызываемая при ошибках (пока ничего не делает)
void yyerror(const char *str, ...)
{
	va_list(ap);
	va_start(ap, str);
	//fprintf(stderr, "%s\n", str);
	vfprintf(stderr, str, ap);
	va_end(ap);
	fprintf(stderr, "\n");
}

