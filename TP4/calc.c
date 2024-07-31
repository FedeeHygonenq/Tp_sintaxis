#include "calc.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

char *funciones[] = {"sin", "cos", "tan", "acos", "asin", "atan", "log", "sqrt"};

struct dicentry dictionary[100] = {{"pi",M_PI},{"e",M_E}};
int dictionary_size;
int esLectura = 1;

int esFuncion(char *variable)
{
    for (int i = 0; i < 8; i++)
    {
        if (strcmp(funciones[i], variable) == 0)
        {
            return 1;
        }
    }
    return 0;
}

void iniciarCalculadora()
{
    dictionary_size = 2;

    for (int i = 2; i < 100; ++i)
    {
        strcpy(dictionary[i].lexem,"");
        dictionary[i].valor = 0.0;
    }
}

void guardarVariable(char *variable, double val)
{
    if (esFuncion(variable))
    {
        printf("Error:la variable es palabra reservada \n");
    }
    else
    {
        strcpy(dictionary[dictionary_size].lexem,variable);
        dictionary[dictionary_size].valor = val;
        dictionary_size++;
    };
}

void guardarValor(char *variable, double valor)
{
    int indice = 0;

    while (indice < dictionary_size) {
        if (strcmp(dictionary[indice].lexem, variable) == 0)
        {
           
            dictionary[indice].valor = valor;
            break;
        }
        else
        {
            indice++;
        }
    }

}

int estaDeclaradaVariable(char *var)
{
    int indice = 0;
     while (indice < dictionary_size)
    {
        if (strcmp(dictionary[indice].lexem, var) == 0)
        {
            
            return 1;
        }
        else
        {
            indice++;
        }
    }
    return 0;
}

double buscarVariable(char *var)
{
    int indice = 0;
    do
    {
        if (strcmp(dictionary[indice].lexem, var) == 0)
        {
            return dictionary[indice].valor;
        }
        else
        {
            indice++;
        }
    } while (indice < dictionary_size);
    return NAN;
}

double ejecutarFuncion(char *func, double parametro)
{
    if (strcmp(func, "sin") == 0)
    {   
        return sin(parametro);
    }
    else if (strcmp(func, "cos") == 0)
    {
        return cos(parametro);
    }
    else if (strcmp(func, "tan") == 0)
    {
        return tan(parametro);
    }
    else if (strcmp(func, "asin") == 0)
    {
        return asin(parametro);
    }
    else if (strcmp(func, "acos") == 0)
    {
        return acos(parametro);
    }
    else if (strcmp(func, "atan") == 0)
    {
        return atan(parametro);
    }
    else if (strcmp(func, "log") == 0)
    {
        return log(parametro);
    }
    else if (strcmp(func, "sqrt") == 0)
    {
        return sqrt(parametro);
    }
}

void manejarErrorSemantico(const char *mensaje)
{
    fprintf(stderr, "Error semantico: %s\n", mensaje);
    
}

double realizarOperacionDivision(double operand1, double operand2)
{
    if (operand2 != 0)
    {
        return operand1 / operand2;
    }
    else
    {
        return NAN;
    }
}

