
%{

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"
#include "TurtleYacc.tab.h"
#include "symtable.h"

%}

%option noyywrap

%%

\/\/.*							{}
\/\*([^*]|(\*+[^*/]))*\*+\/		{}

[0-9]+		{ yylval.value = atoi(yytext); return NUMBER; }

"+"			{ return yytext[0]; }
"-"			{ return yytext[0]; }
"*"			{ return yytext[0]; }
"/"			{ return yytext[0]; }
"="			{ return yytext[0]; }
"<"			{ return yytext[0]; }
">"			{ return yytext[0]; }

if			{ return IF; }
ifelse		{ return IFELSE; }
repeat		{ return REPEAT; }
home		{ return HOME; }
pd			{ return PD; }
pu			{ return PU; }
fd			{ return FD; }
bk			{ return BK; }
rt			{ return RT; }
lt			{ return LT; }
setc		{ return SETC; }
xcor		{ return XCOR; }
ycor		{ return YCOR; }


color		{ return COLOR; }
black		{ yylval.colortype = BLACK; return COLOR_NAME; }
white		{ yylval.colortype = WHITE; return COLOR_NAME; }
cyan		{ yylval.colortype = CYAN; return COLOR_NAME; }
orange		{ yylval.colortype = ORANGE; return COLOR_NAME; }
yellow		{ yylval.colortype = YELLOW; return COLOR_NAME; }
lime		{ yylval.colortype = LIME; return COLOR_NAME; }
blue		{ yylval.colortype = BLUE; return COLOR_NAME; }
magenta		{ yylval.colortype = MAGENTA; return COLOR_NAME; }
red			{ yylval.colortype = RED; return COLOR_NAME; }
brown		{ yylval.colortype = BROWN; return COLOR_NAME; }
green		{ yylval.colortype = GREEN; return COLOR_NAME; }
turqoise	{ yylval.colortype = TURQOISE; return COLOR_NAME; }
sky			{ yylval.colortype = SKY; return COLOR_NAME; }
violet		{ yylval.colortype = VIOLET; return COLOR_NAME; }
pink		{ yylval.colortype = PINK; return COLOR_NAME; }

.			{ }
\n			{ yylineno++; }

%%

void yyerror(const char * msg)
{
	fprintf(stderr, "ERROR! Line #%d: %s at %s\n", yylineno, msg, yytext);
}

