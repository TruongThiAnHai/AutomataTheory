%option noyywrap

%{
	#include "y.tab.h"
	#pragma warning(disable : 4005)
	#pragma warning(disable : 4505)
%}

%%
[0-9]+ { yylval.number = atoi(yytext); return NUMBER; }
FUNC return FUNC;
ENDFUNC return ENDFUNC;
VARIABLE return VARIABLE;
TRUE return TRUE;
FALSE return FALSE;
WHILE return WHILE;
UNTIL return UNTIL;
ENDW return ENDW;
ENDU return ENDU;
IFLESS return IFLESS;
IFNLESS return IFNLESS;
IFZERO return IFZERO;
IFNZERO return IFNZERO;
IFHIGH return IFHIGH;
IFNHIGH return IFNHIGH;
CALL return CALL;
PARAM return PARAM;
[a-zA-Z_][a-zA-Z0-9_]* yylval.name = _strdup(yytext); return NAME;
\"[^\"]*\" yylval.name = _strdup(yytext); return STRING;
[\n=\[\]\,\{\}\+\-] return yytext[0];
[ \t]+    { }
%%