%{
#include "parser.h" 
#include <stdio.h> 
%}
%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput

letra [A-Za-z]
digito [0-9]
suma "+"
resta "-"
multiplicar "*"
punto "."
dividir "/"
exponenciar "^"
parentesiscierre ")"
parentesisapertura "("
sumarigual "+="
restarigual "-="
dividirigual "/="
multiplicarigual "*="
var "var"
salir "salir"
igual "="
numeropi "pi"
constanteE "e"
nuevaLinea \n

%%
[ \t]+ 
("sin"|"cos"|"tan"|"acos"|"asin"|"atan"|"log"|"sqrt") {yylval.carac=strdup(yytext);return FUNCION;} 
{var} {return VAR;} 
{salir} {return SALIR;}
{numeropi} { yylval.carac=strdup(yytext);return NUMPI; }
{constanteE} { yylval.carac=strdup(yytext);return CONSTE; }
{letra}+{digito}* {yylval.carac=strdup(yytext);return ID;}
{digito}+  { yylval.numero=atof(yytext);return NUM; }
{nuevaLinea} {return NL;}
{digito}{punto}{digito}+    {  yylval.numero=atof(yytext);return NUM; }
{digito}*{punto}{digito}+    { yylval.numero=atof(yytext);return NUM; }
{resta}     return '-';
{suma}     return '+';
{multiplicar}     return '*';
{dividir}     return '/';
{exponenciar} return '^';
{parentesisapertura} return '(';
{parentesiscierre} return ')';
{igual} return '=';
{sumarigual} return SUMIGUAL;
{restarigual} return RESTAIGUAL;
{dividirigual} return DIVIGUAL;
{multiplicarigual} return MULTIGUAL;
{digito}+{letra}+.*  {  yylval.carac=strdup(yytext);return ERROR_LITERAL_INVALIDO; }
{digito}*{punto}.*({punto}|{letra})+.* {  yylval.carac=strdup(yytext);return ERROR_LITERAL_INVALIDO; }
{letra}+.*([!-':-<>?@])+.*|([!-':-<>?@])+  {  yylval.carac=strdup(yytext); return ERROR_IDENTIFICADOR_INVALIDO;}
 

%%

