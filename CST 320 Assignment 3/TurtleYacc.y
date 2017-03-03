%{

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"
#include "symtable.h"

TreeNode * root;

extern TreeNodeFactory * factory;

extern FILE * yyin;
extern FILE * yyout;
extern int yylineno;
void yyerror(const char *);

int yylex(void);

%}

%union
{
	TreeNode * node;
	int value;
	SymbolTable::Entry * symentry;
}

%token HOME
%token FD
%token BK
%token LT
%token RT
%token SETC
%token PD
%token PU
%token <value> NUMBER
%token <value> COLOR_NAME
%token COLOR
%token XCOR
%token YCOR
%token IF
%token IFELSE
%token REPEAT

%type <node> statements
%type <node> statement
%type <node> expression
%type <node> condition
%type <node> function

%left '+' '-'
%left '*' '/'

%%

statements:	statement statements		{
											if ($1 != NULL)
											{
												// there is a statement node
												$$ = factory->CreateBlock();
												$$->AddChild($1);
												if ($2 != NULL)
												{
													$$->AdoptChildren($2);
												}
												root = $$;
											}
											else
											{
												// there is no statement node
												$$ = $2;
											}
										}
	|									{ $$ = NULL; }
	;

statement:	HOME								{ $$ = factory->CreateTurtleCmd(CMD_HOME); }
	|	PD										{ $$ = factory->CreateTurtleCmd(CMD_PD); }
	|	PU										{ $$ = factory->CreateTurtleCmd(CMD_PU); }
	|	FD expression							{ $$ = factory->CreateTurtleCmd(CMD_FD, $2); }
	|	BK expression							{ $$ = factory->CreateTurtleCmd(CMD_BK, $2); }
	|	RT expression							{ $$ = factory->CreateTurtleCmd(CMD_RT, $2); }
	|	LT expression							{ $$ = factory->CreateTurtleCmd(CMD_LT, $2); }
	|	SETC expression							{ $$ = factory->CreateTurtleCmd(CMD_SETC, $2); }
	|	IF '(' condition ')' '[' statements ']'	{ $$ = factory->CreateIf($3, (BlockTreeNode*)$6); }
	|	IFELSE '(' condition ')' '[' statements ']''[' statements ']'	{ $$ = factory->CreateIfElse ($3, (BlockTreeNode*)$6, (BlockTreeNode*)$9); }
	|	REPEAT	expression '[' statements ']'	{ $$ = factory->CreateRepeat($2, (BlockTreeNode*)$4); }
	;

condition: expression '<' expression			{ $$ = factory->CreateOperator(OT_LESSTHAN, $1, $3); }
	|	expression '>' expression				{ $$ = factory->CreateOperator(OT_GREATERTHAN, $1, $3); }
	|	expression '=' expression				{ $$ = factory->CreateOperator(OT_EQUALS, $1, $3); }
	;

expression:	expression '+' expression			{ $$ = factory->CreateOperator(OT_PLUS, $1, $3); }
	|	expression '-' expression				{ $$ = factory->CreateOperator(OT_MINUS, $1, $3); }
	|	expression '*' expression				{ $$ = factory->CreateOperator(OT_TIMES, $1, $3); }
	|	expression '/' expression				{ $$ = factory->CreateOperator(OT_DIVIDE, $1, $3); }
	|	NUMBER									{ $$ = factory->CreateNumber($1); }
	|	COLOR_NAME								{ $$ = factory->CreateColorName((COLOR_TYPE)$1); }
	|	'(' expression ')'						{ $$ = $2; }
	|	'[' expression ']'						{ $$ = $2; }
	|	function								{ $$ = $1;}
	;


function: COLOR									{ $$ = factory->CreateFunction(FT_COLOR); }
	|	XCOR									{ $$ = factory->CreateFunction(FT_XCOR); }
	|	YCOR									{ $$ = factory->CreateFunction(FT_YCOR); }
%%	
