#include <stdio.h>

void main()
{
   FILE *pf= fopen("input.txt","r");
   int n;
   fgets(n,255,pf);
   printf(n);
   fclose(pf);  
}