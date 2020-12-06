
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
     FUNC = 258,
     ENDFUNC = 259,
     CALL = 260,
     PARAM = 261,
     NAME = 262,
     STRING = 263,
     NUMBER = 264,
     VARIABLE = 265,
     TRUE = 266,
     FALSE = 267,
     WHILE = 268,
     UNTIL = 269,
     ENDW = 270,
     ENDU = 271,
     IFLESS = 272,
     IFNLESS = 273,
     IFZERO = 274,
     IFNZERO = 275,
     IFHIGH = 276,
     IFNHIGH = 277
   };
#endif
/* Tokens.  */
#define FUNC 258
#define ENDFUNC 259
#define CALL 260
#define PARAM 261
#define NAME 262
#define STRING 263
#define NUMBER 264
#define VARIABLE 265
#define TRUE 266
#define FALSE 267
#define WHILE 268
#define UNTIL 269
#define ENDW 270
#define ENDU 271
#define IFLESS 272
#define IFNLESS 273
#define IFZERO 274
#define IFNZERO 275
#define IFHIGH 276
#define IFNHIGH 277




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 21 "Source.y"
 
	char* name;
	int number;



/* Line 1676 of yacc.c  */
#line 103 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


