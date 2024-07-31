
typedef enum token 
{
   FDT,
   ID,
   INT,
   REAL,
   SUMA='+',
   RESTA='-',
   MULTIPLICAR='*',
   DIVIDIR='/',
   PARENTESISABRE='(',
   PARENTESISCIERRE=')',
   IGUAL='=',
   EXP='^',
   SUMIGUAL,
   RESTAIGUAL,
   MULTIGUAL,
   DIVIGUAL,
   VAR,
   NL,
   SALIR ,
   ERROR_LITERAL_INVALIDO=400,
   ERROR_IDENTIFICADOR_INVALIDO,
   
 
   
}Token;