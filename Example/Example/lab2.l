%{
#include <stdlib.h>
#include <string.h>
#include "lab2.h"
#include "y.tab.h"

void yyerror(char *);
%}
%%
[0-9]+ {
yylval.iValue = atoi(yytext);
return INTEGER;
}
[();=]  return *yytext;

"TRUE" return T;
"FALSE" return F;
"INT" return INT;
"BOOLEAN" return BOOLEAN;
"CINT" return CINT;
"CBOOLEAN" return CBOOLEAN;
"MAP" return MAP;
"NOT" return NOT;
"OR" return OR;
"DEC" return DEC;
"INC" return INC;
"GT" return GT;
"LT" return LT;
":=" return EQUAL;
"WHILE" return WHILE;
"DO" return DO;
"IF" return IF;
"ELSE" return ELSE;
"print" return PRINT;
"STEP" return STEP;
"BACK" return BACK;
"LEFT" return LEFT;
"LOOK" return LOOK;
"PROC" return PROC;
"BAR"  return BAR;
"EMP"  return EMP;
"SET"  return SET;
"CLR"  return CLR;
[a-z]+ {
	yylval.sIndex = yytext;
	return VARIABLE;
}
[ \t\n]+ ; /* ignore whitespace */
. yyerror("Unknown character");
%%
int yywrap(void) {
return 1;
}