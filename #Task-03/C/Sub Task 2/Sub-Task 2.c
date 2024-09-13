#include <stdio.h>

void main()
{
   FILE *pf= fopen("input.txt","r");
   char buffer[255];
   fgets(buffer,255,pf);
   printf(buffer);
   fclose(pf);  
   FILE *f=fopen("output.txt","w");
   int r=fputs(buffer,f);
   if(r==EOF){
    printf("Err");
    fclose(f);
   }
   fclose(f);
}