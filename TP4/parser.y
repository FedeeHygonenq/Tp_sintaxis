%code top{
#include "calc.h"
#define YYERROR_VERBOSE
#include "scanner.h"
#include <stdio.h>
#include <math.h>

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
}
%code provides {

    void yyerror(const char *s);
}

%union {
    double numero;
    double *num;
    char *carac;
}



%token <numero>  NUM

%token <carac> CONSTE NUMPI
%token <carac> VAR FUNCION ID
%type  <numero>  exp asignacion operacion

%token 
FDT 
SUMA '+'
RESTA '-'
MULTIPLICAR '*'
DIVIDIR '/'
PARENTESISABRE '(' 
PARENTESISCIERRE ')' 
IGUAL '='
EXP '^'
SUMIGUAL "+="
RESTAIGUAL "-="
MULTIGUAL "*="
DIVIGUAL "/*"
NL
SALIR 
ERROR_LITERAL_INVALIDO 
ERROR_IDENTIFICADOR_INVALIDO

%right "-=" "+="
%precedence '='
%left '-' '+'
%left '*' '/'
%precedence NEG 
%right '^' 

%defines "parser.h"
%output "parser.c"
%start programa

%%
programa : %empty
|  lsentencias  YYEOF   

lsentencias: sentencia 
| lsentencias sentencia 

sentencia:
SALIR NL {printf("|>>salir<<| \n");exit(0);}
|asignacion NL
|operacion NL
|declaracion NL
|error NL  {yyerror(yytext);} 
|errorLexico NL


operacion:exp{printf(">> %f \n",$1);}

asignacion:
ID '=' exp '=' exp {printf("Los operadores de asignación solo admiten una variable como operando izquierdo\n");YYERROR;}
|ID '=' exp "+=" exp {printf("Los operadores de asignación solo admiten una variable como operando izquierdo\n");YYERROR;}
|ID '=' exp "-=" exp {printf("Los operadores de asignación solo admiten una variable como operando izquierdo\n");YYERROR;}
| ID "+=" exp      {if(estaDeclaradaVariable($1)){guardarValor($1,buscarVariable($1)+$3);printf("%f \n",buscarVariable($1)+$3);}else{printf("Error: %s ID no declarada \n",$1);YYERROR;};}
| ID "-=" exp       {if(estaDeclaradaVariable($1)){guardarValor($1,buscarVariable($1)-$3);printf("%f \n",buscarVariable($1)-$3);}else{printf("Error: %s ID no declarada \n",$1);YYERROR;};}
| ID '=' exp      {if(estaDeclaradaVariable($1)){guardarValor($1,$3);printf(">>%f \n",buscarVariable($1));}else{printf("Error: %s ID no declarada \n",$1);YYERROR;};}

exp:
ID {if(!estaDeclaradaVariable($1)){printf("Error: %s ID no declarada \n",$1);YYERROR;}else{$$=buscarVariable($1);};}
|FUNCION '(' exp ')'   {if(esFuncion($1)){$$=ejecutarFuncion($1,$3);}else{printf("No existe la funcion:  %s \n",$1);};}
| exp '+' exp        {  $$ = $1 + $3;  }
| exp '+''+' exp     {yyerror("Error: + duplicado \n");YYERROR;}
| exp '-' exp        { $$ = $1 - $3;   }
| exp '*' exp        {   $$ = $1 * $3;                  }
|exp '*''*' exp      {printf("Error: * duplicado \n");YYERROR;} 
| exp '/' exp        {  if(!isnan( realizarOperacionDivision($1, $3)) ){$$=realizarOperacionDivision($1, $3);}else{  manejarErrorSemantico("Division por cero");YYERROR;} }                
| exp '/' '/' exp   {printf("Error: // duplicado \n");YYERROR;}
| '-'exp  %prec NEG {  $$=-$2;                     }
| exp '^' exp        { $$=pow($1,$3);              }
| '(' exp ')'        { $$ = $2;                    }
|NUM                 {$$=$1;};
|CONSTE             {$$=(buscarVariable($1));}
|NUMPI              {$$=(buscarVariable($1));}
declaracion:
VAR ID          {if(estaDeclaradaVariable($2)){printf("Error: ID ya declarada \n");YYERROR;} else if(esFuncion($2)){printf("Error:la variable es palabra reservada \n");YYERROR;} else{guardarVariable($2,0);printf("%s: %f \n",$2,0.0);};}
|VAR ID '=' exp {if(estaDeclaradaVariable($2)){printf("Error: ID ya declarada \n");YYERROR;} else if(esFuncion($2)){printf("Error:la variable es palabra reservada \n");YYERROR;} else{guardarVariable($2,$4);printf("%s: %f \n",$2,$4);};} 
|VAR FUNCION    {printf("Error:la variable %s es palabra reservada \n",$2);}

errorLexico:
ERROR_LITERAL_INVALIDO {printf ("Error literal invalido %s \n",yytext);}
|ERROR_IDENTIFICADOR_INVALIDO {printf ("Error identificador invalido %s \n",yytext);}


%%
