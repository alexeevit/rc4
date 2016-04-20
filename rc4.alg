__in bit key[32];

__out bit state[256];

int x = 0;
int y = 0;

void init() {
  bit temp;

  for(int i = 0; i < 256; i++)
    state[i] = i;

  int j = 0;
  for(int i = 0; i < 256; i++) {
    int index = key[ i % 32 ] + state[i];
    j = ( j + index ) % 256;

    temp = state[i];
    state[i] = state[j];
    state[j] = temp;
  }
}

bit tact() {
  x = (x + 1) % 256;
  int index = state[x];
  y = (y + index) % 256;

  temp = state[i];
  state[i] = state[j];
  state[j] = temp;

  index = (state[x] + state[y]);
  return state[(index % 256)];
}

void main() {
	init();
	tact();
}
