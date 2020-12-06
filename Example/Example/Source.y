%{#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include "yFunctions.h"
	int yylex(void);
 extern FILE * yyin;	using namespace std;

	#pragma warning(disable : 4065)
	#pragma warning(disable : 4244)
	#pragma warning(disable : 4702)
%}

%token FUNC ENDFUNC CALL PARAM
%token <name> NAME /* token - name of variable or function */
%token <name> STRING
%token <number> NUMBER /* token - number */
%token VARIABLE TRUE FALSE
%token WHILE UNTIL ENDW ENDU
%token IFLESS IFNLESS IFZERO IFNZERO IFHIGH IFNHIGH

%union { 
	char* name;
	int number;
}

%%

global: /*empty*/
	| global_item global
	;

global_item: statement
	| function
	| '\n'
	;

function: FUNC NAME '\n' statements ENDFUNC '\n' { printf("define function: %s\n", $2); }
	;
	
statement: define_statement /* statement with variable definition */
	| assign_statement /* statement with variable assignment */
	| loop_statement /* statement with loop */
	| decision_statement /* statement with decision */
	;

define_statement: VARIABLE NAME dimension '=' initializer '\n' { printf("define var with demension: %s\n", $2); }
	| VARIABLE NAME '=' initializer '\n' { printf("define var without dimansion: %s\n", $2); }
	;

dimension: '[' constant_expression ',' constant_expression ']'
	;

initializer: '{' inner_initializers '}'
	;

inner_initializers: '{' expression_set '}'
	| '{' expression_set '}' ',' inner_initializers
	;

expression_set: expression
	| expression_set ',' expression
	;

constant_expression: NUMBER /* constant expression - expression with only numbers */
	| constant_expression '+' constant_expression
	| '-' constant_expression
	;

assign_statement: NAME '[' expression ',' expression ']' '=' expression { printf("assign to %s\n", $1); }
	;

expression: NUMBER
	| NAME '[' expression ',' expression ']'
	| '-' expression
	| expression '+' expression
	| TRUE
	| FALSE
	| STRING
	| CALL NAME expression
	| PARAM
	;

loop_statement: WHILE expression '\n' statements ENDW '\n' { printf("while statement\n"); }
	| UNTIL expression '\n' statements ENDU '\n' { printf("until statement\n"); }
	;

statements: '\n'
	| statement
	| statement statements
	;

decision_statement: decision_operator expression '\n' statement { printf("decision statement"); }
	;

decision_operator: IFLESS
	| IFNLESS
	| IFZERO
	| IFNZERO
	| IFHIGH
	| IFNHIGH
	;

%%
int main(void) {
	yyin = fopen ("./test1.txt", "r");
	yyparse();
	fclose (yyin);
	return 0;
}