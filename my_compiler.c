#include<stdio.h>

int parenthesis, brackets, braces;

void incomment();
void instring(int c);
void search(int c);

int main(void)
{
    int c;
    
    extern int parenthesis, brackets, braces;

    while((c=getchar())!=EOF)
        if( c == '/')
            if((c=getchar())== '/')
                incomment();
            else 
                search(c);
        else if( c == '\'' || c == '"')
            instring(c);
        else
            search(c);

    if( parenthesis < 0){
        printf("Unclosed parenthesis\n");
        parenthesis = 0;
    }  
    else if( brackets < 0){
        printf("Unclosed brackets\n");
        brackets = 0;
    }
    else if( braces < 0){
        printf("Unclosed braces\n");
        braces = 0;
    } 

    if(parenthesis > 0)
        printf("too many closed parenthesis\n");
    else if(brackets > 0)
        printf("Too many closed brackets\n");
    else if(braces > 0)
        printf("Too many closed braces\n");
    return 0;
}

void incomment()
{
    int c,d;
    
    c = getchar();
    d = getchar();

    while(c != '/' || d != 'n')
    {
        c = d;
        d = getchar();
    }
}

void instring(int c)
{
    int d;

    putchar(c);

    while((d=getchar())!=c)
        if( d == '\\')
            getchar();
}

void search(int c)
{
    extern int parenthesis, brackets, braces;

    if ( c == '(')
        --parenthesis;
    else if( c == ')')
        ++parenthesis;
    else if( c == '[')
        --brackets;
    else if( c == ']')
        ++brackets;
    else if( c == '{')
        --braces;
    else if ( c == '}')
        ++braces;
}
