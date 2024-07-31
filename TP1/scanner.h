#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED

typedef enum token 
{
    IDENTIF=1,
    ENTERO,
    HEXA,
    ERRORENTMAL,
    ERRORGNRAL,
    FDT
}Token;

enum estados
{
    INICIAL,
    RECONOC_ID,
    RECONOC_CONST_NUM,
    POSIBLE_HEXA,
    RECONOC_HEXA,
    ID_ENCONTR=201,
    CONSTNUM_ENCONTR=202,
    HEXA_ENCONTR=203,
    FDT_ENCONTR=204,
    RECONOC_ERRORGNRAL=5,
    ERRORGNRAL_ENCONTR=405,
    RECONOC_ERROR_INTMALFORM=6,
    ERROR_INTMALFORM_EENCONTR=406
};
            
int scanner(void);
extern char lexema[200]; // el extern habia dicho que sirve para que lo reconozca al incluir el H creo

#endif // SCANNER_H_INCLUDED