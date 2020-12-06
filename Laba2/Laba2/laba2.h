/*Lab2.h*/
#include <stdbool.h>
typedef enum { typeCon, typeId, typeOpr } nodeEnum;
/* constants */
typedef struct {
	int value; /* value of constant */
} conNodeType;
/* identifiers */
typedef struct {
	int i; /* subscript to sym array */
	char c[10];
	int cons;
} idNodeType;
/* operators */
typedef struct {
	int oper; /* operator */
	int nops; /* number of operands */
	struct nodeTypeTag *op[1]; /* operands (expandable) */
} oprNodeType;
typedef struct nodeTypeTag {
	nodeEnum type; /* type of node */
	int label;
/* union must be last entry in nodeType */
/* because operNodeType may dynamically increase */
	union {
	conNodeType con; /* constants */
	idNodeType id; /* identifiers */
	oprNodeType opr; /* operators */
	};
} nodeType;
extern int sym[26];
extern nodeType* addr[26];
int exec(nodeType *p);