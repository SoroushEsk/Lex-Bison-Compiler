%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define YYSTYPE_IS_DECLARED 1
#define True -1
#define False 0

long temp_number = 1;
extern int  yyparse(void);
extern int yylex(void);
int yyerror(char *s);
void getIntermediate(char *first, char op, char *second, char *ret);
long calResult(long ,char, long);
long addition(long, long);
long subtraction(long, long);
long multiply(long, long);
long division(long, long);
long sumOfDigit(long);

struct Val{
    long num;
    char *str;
};

typedef struct Val* YYSTYPE;

%}


%token NUM_TOKEN
%start program
%%
program:
    expr '='                 {  $$ = $1;exit(0);}
    ;

expr:
    term                   { $$ = $1; }
    |expr '+' term           { 
        getIntermediate($1->str, '+', $3->str, $$->str );
        $$->num = calResult($1->num, '+', $3->num);

    }
    |expr '-' term          { 
        getIntermediate($1->str, '-', $3->str, $$->str );
        $$->num = calResult($1->num, '-', $3->num);
        }

    ;

term:
    fact                    { $$ = $1; }
    |term  '*' fact         { 
        getIntermediate($1->str, '*', $3->str, $$->str ); 
        $$->num = calResult($1->num, '*', $3->num);

        }
    | term '/'  fact        { 
        getIntermediate($1->str, '/', $3->str, $$->str ); 
        $$->num = calResult($1->num, '/', $3->num);
    
        }
    ;

fact:

    NUM_TOKEN               { $$ = $1; }
    | '(' expr ')'          { $$ = $2; }


%%

long sumOfDigit(long number){
    long result = 0;
    long singleYet = False ;
    while( singleYet == False ){
        result += number % 10;
        number /= 10;
        if (number == 0) {
            number = result;
            result = 0;
            if ( number <  10 ) singleYet = True;
        }
        
    }
    return number;
}

long reverse(long number){
    long result = 0 ;
    while(number != 0){
        result = result * 10 + (number % 10);
        number /= 10;
    }
    return result;
}

long addition(long first, long second){
    long result = 0;

    long tempSec = second;
    long tempFir = first;

    long singleDigit;
    short isExist;

    while(tempSec != 0){

        isExist = False;
        singleDigit = tempSec % 10;
        tempFir = first;

        while(tempFir != 0){
            if(( tempFir  % 10 ) == singleDigit){
                isExist = True;
                break;
            }
            tempFir /= 10;
        }

        if( isExist  == False ) {
            result = result * 10 + singleDigit;
        }

        tempSec /= 10;
    }

    tempFir = first;
    while(tempFir != 0){

        result = result * 10 + (tempFir % 10);
        tempFir /= 10;

    }

    return reverse(result);
}

long subtraction(long first, long second ){

    long result = 0;

    long tempSec = second;
    long tempFir = first;

    long isExist = False;
    long singleDigit;


    while(tempFir != 0){

        singleDigit = tempFir % 10 ;
        isExist = False;
        tempSec = second;

        while( tempSec != 0 ){
            if((tempSec % 10) == singleDigit) {
                isExist = True;
                break;
            }
            tempSec /= 10;
        }

        if(isExist == False){
            result = result * 10 + singleDigit;
        }

    
        tempFir /= 10;
    }

    return reverse(result);
}

long multiply(long first, long second ){
    long sumDigit = sumOfDigit(second);
    return addition(first, sumDigit);
}

long division(long first, long second){
    long sumDigit = sumOfDigit(second);
    return subtraction(first, sumDigit);
}

long calResult(long first, char op, long second){
    long result = 0;
    switch(op){
        case '+':
            result = addition(first, second);
            break;
        case '-':
            result = subtraction(first, second);
            break;
        case '*':
            result = multiply(first, second);
            break;
        case '/':
            result = division(first, second);
            break;
    }
    printf("t%d = %d;\n", temp_number++, result);
    return result;
}


void getIntermediate(char * first, char op, char * second, char * ret){
    printf("t%d = %s %c %s;\n", temp_number, first, op, second);
    char str[11];
    sprintf(str, "%d", temp_number);
	strcpy(ret, "t");
	strcat(ret, str);
    return ;
}

int yyerror(char *s) {
     /*printf("Error: %s\n", s);*/
	fprintf(stderr, "Error: %s\n", s);
}

int main(){
    yyparse();
    return 0;
}