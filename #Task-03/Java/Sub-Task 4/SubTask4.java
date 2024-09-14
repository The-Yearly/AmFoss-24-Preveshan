import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;
public class SubTask4{
    public static void main(String[] args) {
        int n=3;
        try{
            File inp=new File("input.txt");
            Scanner myReader=new Scanner(inp);
            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                n=Integer.parseInt(data);
            }}catch (FileNotFoundException e){
                System.out.println("An error occurred.");
                e.printStackTrace();
            }
        if (n%2!=0){
            String outputTxt="";
            int c=n-(n/2)-1;
            int m=1;
            int s1=-1;
            int s2=1;
            for (int g=0;g<n;g++){
                if (c!= 0){
                    for (int j=0;j<c;j++){
                        outputTxt+=(" ");
                    }
                }
                for (int j=0;j<m;j++){
                    outputTxt+=("*");
                }
                outputTxt+=("\n");
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
            try{
                FileWriter ou = new FileWriter("output.txt");
                ou.write(outputTxt);
                System.out.println("Output is Written");
                ou.close();
            }catch(IOException e){
                System.out.println("Error Occured");    
            }
        
        }else{
            System.out.println("Enter odd");
        }
    }
}
