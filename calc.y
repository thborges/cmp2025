
%{
#include "nodes.h"
int yyerror(const char *s);
int yylex (void);
%}

%define parse.error verbose

%token TOK_PRINT TOK_INT TOK_FLT TOK_IDENT

%start program

%union {
   int integer;
   float flt;
   char *name;
}

%%

program : stmts ;

stmts : stmts stmt
      | stmt
      ;

stmt : TOK_IDENT '=' expr ';'
     | TOK_PRINT expr ';'
     ;

expr : expr '+' term
     | expr '-' term
     | term
     ;

term : term '*' factor
     | term '/' factor
     | factor
     ;

factor : '(' expr ')'
       | TOK_INT
       | TOK_FLT
       ;

%%

