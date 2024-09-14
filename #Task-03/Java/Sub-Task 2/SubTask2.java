import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;
public class SubTask2 {
    public static void main(String[] args) {
        try{
        File inp=new File("input.txt");
        Scanner myReader=new Scanner(inp);
        while (myReader.hasNextLine()) {
            String data = myReader.nextLine();
            try{
                FileWriter ou = new FileWriter("output.txt");
                ou.write(data);
                System.out.println("Output is Written");
                ou.close();
            }catch(IOException e){
                System.out.println("Error Occured");    
            }
        }}catch (FileNotFoundException e){
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
        
}
}
