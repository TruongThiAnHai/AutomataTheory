%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "laba2.h"
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
%token <sIndex> VAR
%token <bValue> TRUE FALSE 
%token VARIABLE WHILE UNTIL IF CONVERT TO BOOL DIGIT ENDU ENDW PRINT
%token IFLESS IFNLESS IFZERO IFNZERO IFHIGH IFNHIGH 
%type <nPtr> stmt expr stmt_list function 


%%
program:
	function {exec($1); freeNode($1); exit(0);}
	;
function:
	function stmt { $$ = opr(';', 2, $1, $2);}
	| /* NULL */ { init(); $$ = 0;}
	;
stmt:
	';' { $$ = opr(';', 2, NULL, NULL); }
	| expr ';' { $$ = $1; }
	| PRINT expr ';' { $$ = opr(PRINT, 1, $2); }
	| VARIABLE VAR '=' expr ';' { $$ = opr('=', 2, id(1,$2), $4); }
	| VAR '=' expr ';' { $$ = opr('=', 2, id(1,$1), $3 ); }
	| '(' stmt_list ')' { $$ = $2; }
	| WHILE expr stmt ENDW { $$ = opr(WHILE, 2, $2, $3); }
	| UNTIL expr stmt ENDU { $$ = opr(UNTIL, 2, $2, $3); }
	;
stmt_list:
	stmt { $$ = $1; }
	| stmt_list stmt { $$ = opr(';', 2, $1, $2); }
	;
expr:
	 INTEGER { $$ = con($1); }
	| VAR { $$ = id(1,$1); }
	| expr '+' expr { $$ = opr('+', 2, $1, $3); }
	| expr '-' expr { $$ = opr('-', 2, $1, $3); } 
	| '(' expr ')' { $$ = $2; }
	| IFLESS expr expr { $$ = opr(IFLESS, 2, $2, $3); }
	| IFNLESS expr expr { $$ = opr(IFNLESS, 2, $2, $3); }
    | IFHIGH expr expr { $$ = opr(IFHIGH, 2, $2, $3); }
	| IFNHIGH expr expr { $$ = opr(IFNHIGH, 2, $2, $3); }
	| IFZERO expr { $$ = opr(IFZERO, 1, $2); }
	| IFNZERO expr  { $$ = opr(IFNZERO, 1, $2); }
	| TRUE {$$ = con($1);}
	| FALSE {$$ = con($1);}
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
    p->id.cons = 0;
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
	yyin = fopen ("./test.txt", "r");
	yyparse();
	fclose (yyin);
	return 0;
}