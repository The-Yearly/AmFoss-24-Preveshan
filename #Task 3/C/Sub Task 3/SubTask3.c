#include <stdio.h>

int main() {
    int n;
    int g;

    printf("Enter a number: ");
    scanf("%d", &n);

    for(g = 0; g < n; g++) {
        printf("%d\n", g);
    }

    return 0;
}
