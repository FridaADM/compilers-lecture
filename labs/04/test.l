%{
//https://regex101.com/r/hlv3Q4/1
//egrep '^0\.0$|^[1-9][0-9]*\.[0-9]*[1-9]$|^[1-9][0-9]*\.0$' test.txt
#include <stdio.h>
%}

%%
^0\.0$|^[1-9][0-9]*\.[0-9]*[1-9]$|^[1-9][0-9]*\.0$ printf("VALID\n");
%%
