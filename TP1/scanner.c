#include <stdio.h>
#include "scanner.h"
#include <ctype.h>
#include <string.h>

int estadoSegunCaracter(int estado, int carac);
int tokenEncontrado(int estado);
int seguirIdentificando(int estado);
int calcularColumna(int carac);

enum tipoCaracter
{
    LETRA,
    DIGIT,
    CERO,
    EQUIS,
    DIGIT_HEX,
    FIN_DE_TEXTO,
    ESPACIO,
    OTRO,

};

static int tabla_transicion[7][8] = 
{
    {  1,  2,  3,   1,  1, 204 ,  0  ,   5},   /* 0 INICIAL */

    {  1,  1,  1,   1,  1, 201 , 201 , 405},   /* 1 RECONOCIENDO ID */

    {  6,  2,  2,   6,  6, 202 , 202 , 202},   /* 2 RECONOCIENDO CONSTANTE */
                          
    {  6,  2,  2,   4,  6, 202 , 202 , 202},   /* 3 RECONOCIENDO POSIBLE HEXA */

    {203,  4,  4, 203,  4, 203 , 203 , 203},   /* 4 RECONOCIENDO HEXA */ 

    {  5,  5,  5,   5,  5, 405 , 405 ,   5},  /* 5 RECONOCIENDO ERROR GENERAL  -> nuevo */ 

    {  6,  6,  6,   6,  6, 406 , 406 , 406},   /* 6 RECONOCIENDO ENTERO MAL FORMADO */
    
};

int seguirIdentificando(int estado){
    return estado<=6;
}


char lexema[200];
int carac;
int scanner()
{
    int indiceLexema = 0;
    int estado = 0; 
    while ((seguirIdentificando(estado))) 
    {   int col;
        carac = getchar();
        col=calcularColumna(carac);
        estado=tabla_transicion[estado][col];
        if(!isspace(carac) && seguirIdentificando(estado)){
        lexema[indiceLexema++] = (char)carac;
        };
      
    }
    if(estado != FDT_ENCONTR){
        ungetc(carac,stdin);
    }
        lexema[indiceLexema] = '\0';
    return tokenEncontrado(estado);
}


int tokenEncontrado(int estado){

    switch (estado){
    case ID_ENCONTR:
        return IDENTIF;

    case CONSTNUM_ENCONTR:
        return ENTERO;

    case HEXA_ENCONTR:
        return HEXA;

    case FDT_ENCONTR:
        return FDT;

    case ERRORGNRAL_ENCONTR:
        return ERRORGNRAL;
        
    case ERROR_INTMALFORM_EENCONTR:
        return ERRORENTMAL;
    }
}

int calcularColumna(int carac){
     if(carac==EOF){
          return FIN_DE_TEXTO;  
           }
  if(isdigit(carac)){
    if(carac=='0'){return CERO;};
     return DIGIT;
  };
  if(carac=='x'||carac=='X'){
    return EQUIS;
  }
  if(isxdigit(carac)){
    return DIGIT_HEX;
  }
  if(isalpha(carac)){
    return LETRA;

  }
  if(isspace(carac)){
    return ESPACIO;
  }
 
  if(ispunct(carac)){
    return OTRO;
  }
}
