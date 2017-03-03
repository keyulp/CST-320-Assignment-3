
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
"("			{ return yytext[0]; }
")"			{ return yytext[0]; }
"["			{ return yytext[0]; }
"]"			{ return yytext[0]; }

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
black		{ yylval.value = BLACK; return COLOR_NAME; }
white		{ yylval.value = WHITE; return COLOR_NAME; }
cyan		{ yylval.value = CYAN; return COLOR_NAME; }
orange		{ yylval.value = ORANGE; return COLOR_NAME; }
yellow		{ yylval.value = YELLOW; return COLOR_NAME; }
lime		{ yylval.value = LIME; return COLOR_NAME; }
blue		{ yylval.value = BLUE; return COLOR_NAME; }
magenta		{ yylval.value = MAGENTA; return COLOR_NAME; }
red			{ yylval.value = RED; return COLOR_NAME; }
brown		{ yylval.value = BROWN; return COLOR_NAME; }
green		{ yylval.value = GREEN; return COLOR_NAME; }
turquoise	{ yylval.value = TURQUOISE; return COLOR_NAME; }
sky			{ yylval.value = SKY; return COLOR_NAME; }
violet		{ yylval.value = VIOLET; return COLOR_NAME; }
pink		{ yylval.value = PINK; return COLOR_NAME; }

.			{ }
\n			{ yylineno++; }

%%

void yyerror(const char * msg)
{
	fprintf(stderr, "ERROR! Line #%d: %s at %s\n", yylineno, msg, yytext);
}

