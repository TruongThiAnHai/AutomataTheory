
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INTEGER = 258,
     VAR = 259,
     TRUE = 260,
     FALSE = 261,
     VARIABLE = 262,
     WHILE = 263,
     UNTIL = 264,
     IF = 265,
     CONVERT = 266,
     TO = 267,
     BOOL = 268,
     DIGIT = 269,
     ENDU = 270,
     ENDW = 271,
     PRINT = 272,
     IFLESS = 273,
     IFNLESS = 274,
     IFZERO = 275,
     IFNZERO = 276,
     IFHIGH = 277,
     IFNHIGH = 278,
     IFX = 279,
     ELSE = 280
   };
#endif
/* Tokens.  */
#define INTEGER 258
#define VAR 259
#define TRUE 260
#define FALSE 261
#define VARIABLE 262
#define WHILE 263
#define UNTIL 264
#define IF 265
#define CONVERT 266
#define TO 267
#define BOOL 268
#define DIGIT 269
#define ENDU 270
#define ENDW 271
#define PRINT 272
#define IFLESS 273
#define IFNLESS 274
#define IFZERO 275
#define IFNZERO 276
#define IFHIGH 277
#define IFNHIGH 278
#define IFX 279
#define ELSE 280




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 20 "laba2.y"

	int iValue; /* integer value */ 
	bool bValue;
	char* sIndex; /* symbol table index */
	nodeType *nPtr; /* node pointer */



/* Line 1676 of yacc.c  */
#line 111 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


