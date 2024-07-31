#include <stdio.h>
#include "scanner.h"

int main(void)
{
    Token tokenEncontrado;
    do{ // EOF o el token "FDT"
        tokenEncontrado = scanner();
        switch (tokenEncontrado)
       { 
        case IDENTIF:

            printf("IDENTIFICADOR :%s \n", lexema);
           
            break;

        case ENTERO:

            printf("ENTERO :%s \n", lexema);
           
            break;

        case HEXA:

            printf("HEXADECIMAL :%s \n", lexema);
            
            break;

        case ERRORGNRAL:

            printf("ERROR GENERAL :%s \n", lexema);
           
            break;

        case ERRORENTMAL:

            printf("ENTERO MAL FORMADO :%s \n", lexema);
           
            break;
        
        case FDT:
        }
    }while((int)tokenEncontrado!=FDT);
}