%{
	
	#include <stdlib.h>
	#include <string.h>
	#include "laba2.h"
	#include "y.tab.h"
	
	void yyerror(char *);
%}

%%

"VARIABLE" return VARIABLE;
"TRUE" return TRUE;
"FALSE" return FALSE;
"WHILE" return WHILE;
"UNTIL" return UNTIL;
"ENDW" return ENDW;
"ENDU" return ENDU;
"IFLESS" return IFLESS;
"IFNLESS" return IFNLESS;
"IFZERO" return IFZERO;
"IFNZERO" return IFNZERO;
"IFHIGH" return IFHIGH;
"IFNHIGH" return IFNHIGH;
"CONVERT" return CONVERT;
"TO" return TO;
"BOOL" return BOOL;
"DIGIT" return DIGIT;
"PRINT" return PRINT;
"IF" return IF;
"ELSE" return ELSE;

[0-9]+ { yylval.iValue = atoi(yytext); return INTEGER; }
[a-zA-Z][a-zA-Z0-9]* {yylval.sIndex = yytext; return VAR;}
[-()<>=+*/;:{}.] return *yytext;
[ \t\n]+ ; /* ignore whitespace */
. yyerror ("Unknown charater");
%%
int yywrap(void){ 
return 1;
}