int estaDeclaradaVariable(char* var);
int esFuncion(char *variable);
void guardarVariable(char* variable,double valor);
void guardarValor(char* variable,double valor);
double buscarVariable(char* var );
double ejecutarFuncion(char* func,double parametro);
double realizarOperacionDivision(double operand1, double operand2);
void iniciarCalculadora();
int contextoEsSoloLectura();
void restablecerContextoSoloLectura();
void restablecerContextoSoloEscritura();
void manejarErrorSemantico(const char *mensaje);
struct dicentry {
    char lexem[16];
    double valor;
};
extern int dictionary_size;
