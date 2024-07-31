%{
#include "tokens.h" 
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
igual  "="

%%

{letra}+{digito}* return ID
{digito} return ENTERO
"/n" return NL
{digito}{punto}{digito}* return  REAL
{digito}*{punto}{digito} return REAL
{var} return VAR 
{resta} return '-'
{suma} return '+'
{multiplicar} return '*'
{dividir} return '/'
{exponenciar} return '^'
{parentesisapertura} return '('
{parentesiscierre} return ')'
{igual} return '='
{sumarigual} return SUMIGUAL
{restarigual} return RESTAIGUAL 
{dividirigual} return DIVIGUAL 
{multiplicarigual} return MULTIGUAL 
{digito}+{letra}+ return ERROR_LITERAL_INVALIDO
{digito}*{punto}{punto}+ return ERROR_LITERAL_INVALIDO
.{resta}({letra}|{digito}|["-""+""*""/""^""("")""="]) return ERROR_IDENTIFICADOR_INVALIDO
{salir} return SALIR




