__in bit key[32];

__out bit state[256];

void init() {
  bit temp;

  for(int i = 0; i < 256; i++)
    state[i] = i;

  int j = 0;
  for(int i = 0; i < 256; i++) {
    j = ( j + key[ i % 32 ] + state[i] ) % 256;

    temp = state[i];
    state[i] = state[j];
    state[j] = temp;
  }
}

bit tact() {
  int x = 0, y = 0;

  x = (x + 1) % 256;
  y = (y + state[x]) % 256;

  temp = state[i];
  state[i] = state[j];
  state[j] = temp;

  return state[(state[x] + state[y]) % 256)
}

void main() {
  init();
	for(int i = 0; i < 21; i++) {
    tact();
	}
}
