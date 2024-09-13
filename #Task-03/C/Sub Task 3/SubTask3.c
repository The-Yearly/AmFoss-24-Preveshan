#include <stdio.h>
#include <math.h>
void main() {
    int n;
    printf("Enter Number: ");
    scanf("%d",&n);
    if(n%2!=0){
        int x=floor(n/2);
        int c=n-x-1;
        int m=1;
        int s1=-1;
        int s2=1;
        for (int g=0;g<n;g++){
            if(c!=0){
                for(int j=0;j<c;j++){
                   printf(" ");
                }
            }
            for (int j=0;j<m;j++){
                printf("*");
            }
            printf("\n");
            m+=s2*2;
            c+=s1;
            if(c==0){
                s1=1;
            }
            if (m>n){
                s2=-1;
                m=n-2;
            }
        }
    } else {
        printf("Enter Odd Number");
    }
}
