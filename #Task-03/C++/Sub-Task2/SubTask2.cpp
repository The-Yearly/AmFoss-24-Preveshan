#include <iostream>
#include <fstream>
#include <string>
using namespace std;
int main () {
  ifstream input("input.txt");
  string message;
  while (getline (input,message)) {
    cout << message;
  }
  input.close();
  ofstream output("output.txt");
  output<<message;
  output.close();
}
