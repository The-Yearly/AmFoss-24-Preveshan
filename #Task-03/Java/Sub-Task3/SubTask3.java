import java.util.Scanner;
public class SubTask3{
    public static void main(String[] args) {
        Scanner input=new Scanner(System.in);
        System.out.print("n: ");
        int n=input.nextInt();
        if (n%2!=0){
            int c=n-(n/2)-1;
            int m=1;
            int s1=-1;
            int s2=1;
            for (int g=0;g<n;g++){
                if (c!= 0){
                    for (int j=0;j<c;j++){
                        System.out.print(" ");
                    }
                }
                for (int j=0;j<m;j++){
                    System.out.print("*");
                }
                System.out.println();
                m+=s2*2;
                c+=s1;
                if(c==0){
                    s1=1;
                }
                if(m>n){
                    s2=-1;
                    m=n-2;
                }
            }
        }else{
            System.out.println("Enter odd");
        }
    }
}
