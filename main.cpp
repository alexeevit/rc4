#include <iostream>
#include <string>
#include <stdio.h>
#include <iterator>

using namespace std;

unsigned char state[256];
int len;

void stateSwap(int i, int j) {
  unsigned char temp;
  
  temp = state[i];
  state[i] = state[j];
  state[j] = temp;
}

void init(unsigned char key[]) {

  for(int i=0; i<256; i++)
    state[i] = i;

  int j=0;
  unsigned char temp;

  for(int i=0; i<256; i++) {
    j = (j + state[i] + key[i % sizeof(*key)]) % 256;

    stateSwap(i, j);
  }

}

unsigned char prga() {
  int x=0, y=0;

  x = (x + 1) % 256;
  y = (y + state[x]) % 256;

  stateSwap(x, y);

  //printf("%02X ", state[(state[x] + state[y]) % 256]); 
  //printf("\n");

  return state[(state[x] + state[y]) % 256];
}

unsigned char* encode(unsigned char data[]) {
  unsigned char *cipher = new unsigned char[sizeof(*data)];

  for (int i = 0; i < len; i++) { 
    cipher[i] = data[i] ^ prga();
  }

  return cipher;
}

int main() {
  unsigned char key[4] = {"tes"};

  cout << "KEY: ";
  for (int idx=0; idx < sizeof(key); idx++) 
    printf("%02X ", key[idx]); 
  cout << endl;

  //get source
  char source[] = "Hello my dear friend";
  len = sizeof(source);
  
  //Initialize generator
  init(key);

  //Create data
  unsigned char *data = (unsigned char*) source;
  unsigned char *cipher = new unsigned char[len];

  //print source
  cout << "SOURCE: ";
  for (int idx=0; idx < len; idx++) 
    printf("%02X ", data[idx]); 
  cout << endl;

  cipher = encode(data);

  //print cipher
  cout << "CIPHER: ";
  for (int idx=0; idx < len; idx++) 
    printf("%02X ", cipher[idx]); 
  cout << endl;
 
  //Initialize generator
  init(key);

  unsigned char *resource = new unsigned char[len];

  resource = encode(cipher);
  //print cipher
  cout << "CIPHER: ";
  for (int idx=0; idx < len; idx++) 
    printf("%02X ", resource[idx]); 
  cout << endl;

  return 0;
}
