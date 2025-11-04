
%{
#include "nodes.h"
int yyerror(const char *s);
int yylex (void);
%}

%define parse.error verbose

%token TOK_PRINT
%token<integer> TOK_INT
%token<flt> TOK_FLT
%token<name> TOK_IDENT

%type<node> factor term expr

%start program

%union {
   int integer;
   float flt;
   char *name;
   Node *node;
}

%%

program : stmts ;

stmts : stmts stmt
      | stmt
      ;

stmt : TOK_IDENT '=' expr ';'
     | TOK_PRINT expr ';'
     ;

expr : expr[e1] '+' term {
    $$ = new BinaryOp($e1, '+', $term);
}

expr : expr[e1] '-' term {
    $$ = new BinaryOp($e1, '-', $term);
}

expr : term {
    $$ = $term;
}

term : term[t1] '*' factor {
    $$ = new BinaryOp($t1, '*', $factor);
}

term : term[t1] '/' factor {
    $$ = new BinaryOp($t1, '/', $factor);
}

term : factor {
    $$ = $factor;
}

factor : '(' expr ')' {
    $$ = $expr;
}

factor : TOK_INT[integer] {
    $$ = new ConstInteger($integer);
}

factor : TOK_FLT[flt] {
    $$ = new ConstDouble($flt);
}

factor : TOK_IDENT[id] {
    $$ = new Load($id);
}

%%

