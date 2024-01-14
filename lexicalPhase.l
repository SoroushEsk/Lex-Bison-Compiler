%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "syntaxAna.tab.h"

struct Val {
    int num;
    char* str;
};

#define NUM_TOKEN   258 

struct Val* createVal(int num, const char* str) {
    struct Val* val = (struct Val*)malloc(sizeof(struct Val));
    val->num = num;
    val->str = strdup(str);
    return val;
}

void showError() {
    printf("The input you gave is invalid\n");
}

struct Val* getNumber() {
    int result;
    sscanf(yytext, "%d", &result);
    char strNum[20];
    sprintf(strNum, "%d", result);
    return createVal(result, strNum);
}
%}

/* ------Regular Definition------ */

delim   [ \t\n]
ws      {delim}+
digit   [0-9]
number  {digit}+
 
/* ------Translation Rules------ */
%%
{ws}        {}
{number}    {yylval = getNumber(); return NUM_TOKEN;}
\+         {return '+';}
\-         {return '-';}
\*         {return '*';}
\/         {return '/';}
\)         {return ')';}
\(         {return '(';}
\=         {return '=';}
%%

int yywrap(void) {
    return 1;
}
