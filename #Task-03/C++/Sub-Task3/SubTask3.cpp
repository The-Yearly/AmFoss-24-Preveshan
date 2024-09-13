#include <iostream>
using namespace std;
int main(){
        int n;
        cout<<"n: ";
        cin>>n;
        if(n%2!=0){
            int c=n-(n/2)-1;
            int m=1;
            int s1=-1;
            int s2=1;
            for(int g=0;g<n;g++){
                if(c!=0){
                    for(int j=0;j<c;j++){
                        cout<<" ";
                    }
                }
                for (int j=0;j<m;j++) {
                    cout<<"*";
                }
                cout<<endl;
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
    return 0;
}
