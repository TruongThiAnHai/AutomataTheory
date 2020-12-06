#include <stdio.h>
#include "laba2.h"
#include "y.tab.h"
#include <stdbool.h>
char lbl = 0;
int error_flag = 0;
int ex(nodeType *p) {
	if (!p) return 0;
	if (lbl == p->label)
		lbl = 0;
	if (!lbl)
		switch(p->type) {
		case typeCon: 
			
			return p->con.value;
		case typeId: return sym[p->id.c[0]-'a'];
		case typeOpr:
		switch(p->opr.oper) {
			case WHILE: while(ex(p->opr.op[0])) ex(p->opr.op[1]); return 0;
			case UNTIL: while (!ex(p->opr.op[0])) ex(p->opr.op[1]); return 0;
			case IF: if (ex(p->opr.op[0]))
						ex(p->opr.op[1]);
					 else if (p->opr.nops > 2)
						ex(p->opr.op[2]);
					 return 0;
			case PRINT: if (p->opr.op[0]->type == typeId)
							printf ("%s = ",p->opr.op[0]->id.c);
						printf("%d\n", ex(p->opr.op[0])); return 0;
			case ';': ex(p->opr.op[0]); return ex(p->opr.op[1]);
			case '=':
					if(p->opr.op[0]->id.i == 0)
					{
						int k;
						for (k = 0; k < 26 && k != (p->opr.op[0]->id.c[0] -'a'); k++)
						{
							if(strcmp(sym[k], sym[p->opr.op[0]->id.c[0]]-'a') && p->opr.op[0]->id.cons == 0 )
							{
							error_flag = 1;
							yyerror("Variable is const");						
							}
						}
						return sym[p->opr.op[0]->id.c[0] - 'a'] = ex(p->opr.op[1]);
					}				
					else if(p->opr.op[0]->id.i < 3)	
						return sym[p->opr.op[0]->id.c[0] - 'a'] = ex(p->opr.op[1]);
					else if(p->opr.op[0]->id.i < 5)
						return sym[p->opr.op[0]->id.c[0] - 'a'] = (bool)(ex(p->opr.op[1]));
					else if(p->opr.op[0]->id.i == 5)
						return sym[p->opr.op[0]->id.c[0] - 'a'] = (ex(p->opr.op[1]));
					else if(p->opr.op[0]->id.i == 7)
						return sym[p->opr.op[0]->id.c[0] - 'a'] = (ex(p->opr.op[1]));
			case '+': return ex(p->opr.op[0]) + ex(p->opr.op[1]);
			case '-': return ex(p->opr.op[0]) - ex(p->opr.op[1]);
			case IFLESS: return ex(p->opr.op[0]) < ex(p->opr.op[1]);
			case IFNLESS: return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
			case IFHIGH: return ex(p->opr.op[0]) > ex(p->opr.op[1]);
			case IFNHIGH: return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
			case IFZERO: return ex(p->opr.op[0]) == 0;
			case IFNZERO: return ex(p->opr.op[0])!=0;
			
		return 0;
		}
	}
	else
	{
	switch(p->type) {
	case typeCon: return 0;
	case typeId: return 0;
		case typeOpr:
		switch(p->opr.oper) {
		case WHILE: do ex(p->opr.op[1]); while (ex(p->opr.op[0])); return 0;
		case IF: ex(p->opr.op[1]);
			if (lbl && p->opr.nops > 2)
				ex(p->opr.op[2]);
			return 0;
		case ';': ex(p->opr.op[0]); return ex(p->opr.op[1]);
		default: return 0;
		}
	}
	}
	return 0;
}
int exec(nodeType *p)
{
	do
	{
		ex(p);
	}
	while (lbl);
}