%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "lab2.h"
#include <stdbool.h>
#include <string.h>
extern FILE * yyin;
/* prototypes */
nodeType *opr(int oper, int nops, ...);
nodeType *id(int i, char c[10]);
nodeType *con(int value);
void freeNode(nodeType *p);
int exec(nodeType *p);
int yylex(void);
void init (void);
void yyerror(char *s);
int sym[26]; /* symbol table (variable)  */ 
%}
%union {
	int iValue; /* integer value */ 
	bool bValue;
	char* sIndex; /* symbol table index */
	nodeType *nPtr; /* node pointer */
};
%token <iValue> INTEGER 
%token <sIndex> VARIABLE
%token <bValue> T F 
%token INT CINT OR NOT INC DEC GT LT EQUAL WHILE DO IF PRINT BOOLEAN CBOOLEAN
%token STEP BACK RIGHT LEFT LOOK 
%token BAR EMP SET CLR PROC MAP
%type <nPtr> stmt expr stmt_list function var_list
%nonassoc IFX
%nonassoc ELSE
%%
program:
	function {exec($1); freeNode($1); exit(0);}
	;
function:
	function stmt { $$ = opr(';', 2, $1, $2);/*ex($2); freeNode($2);*/ }
	| /* NULL */ { init(); $$ = 0;}
	;
stmt:
	';' { $$ = opr(';', 2, NULL, NULL); }
	| expr ';' { $$ = $1; }
	| PRINT expr ';' { $$ = opr(PRINT, 1, $2); }
	| VARIABLE EQUAL expr ';' { $$ = opr('=', 2, id(1,$1), $3 ); }
	//| VARIABLE EQUAL error ';' { printf("Error in %d", yylineno);$$ = opr(';', 2, NULL, NULL);yyerrok; }
	| INT VARIABLE '=' expr ';' { $$ = opr('=', 2, id(1,$2), $4); }
	//| INT VARIABLE EQUAL error ';' { printf("Error in %d", yylineno);$$ = opr(';', 2, NULL, NULL);yyerrok; }
	| CINT VARIABLE '=' expr ';' { $$ = opr('=', 2, id(2,$2), $4); }
	| BOOLEAN VARIABLE '=' expr ';' {$$ = opr('=', 2, id(3,$2), $4);} 
	| CBOOLEAN VARIABLE '=' expr ';' {$$ = opr('=', 2, id(4,$2), $4) ;}
	| '(' stmt_list ')' { $$ = $2; }
	| WHILE expr DO stmt { $$ = opr(WHILE, 2, $2, $4); }
	| IF expr stmt %prec IFX { $$ = opr(IF, 2, $2, $3); }
	| IF expr stmt ELSE stmt { $$ = opr(IF, 3, $2, $3, $5); }
	| MAP VARIABLE ';' { $$ = opr('m',1, id(5,$2)); }
	| PROC VARIABLE '[' var_list ']' stmt  { $$ = opr('p', 3, id(6,$2), $4, $6); }
	| VARIABLE '[' var_list ']' stmt  { $$ = opr('c', 3, id(6,$1), $3, $5);}
	;
var_list:
	VARIABLE ' ' { $$ = id(7,$1); };
	| var_list VARIABLE { $$ = id(7,$2); }
stmt_list:
	stmt { $$ = $1; }
	| stmt_list stmt { $$ = opr(';', 2, $1, $2); }
	;
expr:
	 INTEGER { $$ = con($1); }
	| VARIABLE { $$ = id(1,$1); }
	| INC expr expr { $$ = opr('+', 2, $2, $3); }
	| DEC expr expr { $$ = opr('-', 2, $2, $3); } 
	| GT expr expr { $$ = opr(GT, 2, $2, $3); }
	| LT expr expr { $$ = opr(LT, 2, $2, $3); }
	| NOT expr {$$ = opr(NOT, 1, $2);}
	| OR expr expr {$$ = opr(OR, 1, $2, $3);}
	| '(' expr ')' { $$ = $2; }
	| T {$$ = con($1);}
	| F {$$ = con($1);}
	| STEP {$$ = opr('s',0);}
	| LOOK {$$ = opr('n',0);}
	| BACK {$$ = opr('b',0);}
	| RIGHT {$$ = opr('r',0);}
	| LEFT {$$ = opr('l',0);}
	;

%%
#define SIZEOF_NODETYPE ((char *)&p->con - (char *)p)
nodeType *con(int value) {
	nodeType *p;
	size_t nodeSize;
	/* allocate node */
	nodeSize = SIZEOF_NODETYPE + sizeof(conNodeType);
	if ((p = (nodeType*) malloc(nodeSize)) == NULL)
	yyerror("out of memory");
	/* copy information */
	p->type = typeCon;
	p->con.value = value;
	return p;
}
nodeType *id(int i, char c[10]) {
	nodeType *p;
	size_t nodeSize;
	/* allocate node */
	nodeSize = SIZEOF_NODETYPE + sizeof(idNodeType);
	if ((p = (nodeType*) malloc(nodeSize)) == NULL)
	yyerror("out of memory");
	/* copy information */
	p->type = typeId;
	p->id.i = i;
	if(i == 2 || i == 4)
		p->id.cons = 1;
	else p->id.cons = 0;
	strcpy(p->id.c,c);
	return p;
}
nodeType *opr(int oper, int nops, ...) {
	va_list ap;
	nodeType *p;
	size_t nodeSize;
	int i;
	/* allocate node */
	nodeSize = SIZEOF_NODETYPE + sizeof(oprNodeType) + (nops - 1) * sizeof(nodeType*);
	if ((p = (nodeType*) malloc(nodeSize)) == NULL)
	yyerror("out of memory");
	/* copy information */
	p->type = typeOpr;
	p->opr.oper = oper;
	p->opr.nops = nops;
	va_start(ap, nops);
	for (i = 0; i < nops; i++)
		p->opr.op[i] = va_arg(ap, nodeType*);
	va_end(ap);
	return p;
}
void freeNode(nodeType *p) {
	int i;
	if (!p) return;
	if (p->type == typeOpr) {
	for (i = 0; i < p->opr.nops; i++)
		freeNode(p->opr.op[i]);
	}
	free (p);
}

void init (void)
	{
	int i;
	for (i = 0;i<26;++i){
		sym[i] = 0;
		}
	}
	
void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyin = fopen ("./test1.txt", "r");
	yyparse();
	fclose (yyin);
	return 0;
}