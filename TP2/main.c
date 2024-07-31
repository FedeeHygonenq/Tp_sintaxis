#include "./tokens.h"
#include "scanner.h"
extern char* yytext;
int main(void){
Token tokenEncontrado;
do{
tokenEncontrado=yylex();

switch (tokenEncontrado){
    case  ID:
     printf("Token: IDENTIFICADOR lexema:%s \n", yytext);
    break;
 case  INT:
     printf("Token : ENTERO lexema:%s \n", yytext);
    break;
   case REAL:
     printf("Token REAL lexema:%s \n", yytext);
    break;

    case  '+':
     printf("Token  :%s \n", yytext);
    break;

    case  '-':
     printf("token :%s \n", yytext);
    break;

      case  '*':
     printf("Token:%s \n", yytext);
    break;
    case  '/':
     printf("Token:%s \n", yytext);
    break;
     case  '^':
     printf("Token:%s \n", yytext);
    break;
     case  '(':
     printf("Token:%s \n", yytext);
    break;
     case  ')':
     printf("Token:%s \n", yytext);
    break;
    break;
case  SUMIGUAL:
     printf("Token:SUMAIGUAL %s \n", yytext);
    break;
case RESTAIGUAL:
     printf("Token:RESTIGUAL %s \n", yytext);
 case MULTIGUAL:
    printf("Token:RESTIGUAL %s \n", yytext);
 case DIVIGUAL:
    printf("Token:RESTIGUAL %s \n", yytext);
case ERROR_LITERAL_INVALIDO:
    printf("Error lexico:Literal invalido %s \n", yytext);
case ERROR_IDENTIFICADOR_INVALIDO:
    printf("Error lexico:Literal invalido %s \n", yytext);
 case SALIR:
    printf("Token:salir  \n");
 case VAR:
    printf("Token:VAR \n");
case NL:
printf("Token:NL \n");
default: 
    break;
}


}while(tokenEncontrado!=FDT);
}