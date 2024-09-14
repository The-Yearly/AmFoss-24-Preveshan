#include <iostream>
#include <fstream>
#include <string>
using namespace std;
int main(){
        int n;
        ifstream input("input.txt");
        string message;
        while (getline (input,message)) {
            n=stoi(message);
        }
        input.close();
        ofstream output("output.txt");
        if(n%2!=0){
            int c=n-(n/2)-1;
            int m=1;
            int s1=-1;
            int s2=1;
            for(int g=0;g<n;g++){
                if(c!=0){
                    for(int j=0;j<c;j++){
                        output<<" ";
                    }
                }
                for (int j=0;j<m;j++) {
                    output<<"*";
                }
                output<<endl;
                m+=s2*2;
                c+= s1;
                if(c==0){
                    s1=1;
                }if(m>n){
                    s2=-1;
                    m=n-2;
                }
            }
        }else{
            cout<<"Enter odd number" << endl;
        }
        output.close();
    return 0;
}
