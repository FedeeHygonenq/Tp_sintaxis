#include "parser.h"
#include "scanner.h"
#include "calc.h"
#include <stdio.h>
extern char* yytext;
int main(void){

iniciarCalculadora();

yyparse();

}