%{
#define YYERROR_VERBOSE
#include "scanner.h"
#include <stdio.h>
#include <math.h>
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}

%union {
   
    double exp;
    double entero ;
    double real;
    int fdt;
    char *str;
    int carac;
    int error;
    char *declaracion;
    
    char* funcion;
    char* id;
}


%type <exp> exp <declaracion> declaracion
%token <fdt>FDT 0
%token <funcion>FUNCION 
%token <id> ID 
<real>REAL
<entero>ENTERO

SUMA '+'
RESTA '-'
MULTIPLICAR '*'
DIVIDIR '/'
PARENTESISABRE '(' 
PARENTESISCIERRE ')' 
IGUAL '='
EXP '^'
<str>SUMIGUAL "+="
RESTAIGUAL "-="
MULTIGUAL "*="
DIVIGUAL "/*"
VAR
<carac> NL
<str>SALIR 
<error> ERROR_LITERAL_INVALIDO 
<error>ERROR_IDENTIFICADOR_INVALIDO

%right '=' "-=" "+="
%left '+' '-'
%left '*' '/'
%precedence NEG 
%right '^' 

%defines "parser.h"
%output "parser.c"
%start programa

%% //gramatica

programa: %empty
|  lsentencias FDT
;

lsentencias:
sentencia 
|lsentencias sentencia
;

sentencia:
exp  {printf ("expresion\n"); }
|declaracion 
|error {yyerror(yytext);}
|errorLexico
|SALIR {printf("salir");}
;

errorLexico:
ERROR_LITERAL_INVALIDO {printf ("Error literal invalido %s \n",yytext);}
|ERROR_IDENTIFICADOR_INVALIDO {printf ("Error identificador invalido %s \n",yytext);}


exp:
FUNCION '(' exp ')'   { printf("Funcion\n");}
|ID     {printf("Identificador\n");}
| exp '+' exp        {printf("Suma \n");}
| exp '-' exp        {printf("Resta\n") ;}
| '-' exp  %prec NEG {printf("Cambio Signo\n");}
| exp '*' exp        {printf("Multiplicacion\n") ;}
| exp '/' exp        {printf("Division\n");}
| exp '^' exp        {printf("Potenciacion\n");}
| exp '=' exp        {printf("Asignacion \n");}
| exp "+=" exp        {printf("Asignacion con suma \n");}
| exp "-=" exp        {printf("Asignacion con resta \n");}
| '(' exp ')'        {printf("Parentesis\n");}
|REAL                {printf("NumeroReal\n");}
|ENTERO              {printf("Numero\n");}
;

declaracion:
VAR ID {printf("Declaracion\n");}
| VAR ID '=' exp {printf("Declaracion con valor inicial\n");}  


%%