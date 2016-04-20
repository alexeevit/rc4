__in bit key[4][8];
__out bit output[4][8];

bit state[256][8];

int x = 0;
int y = 0;

void init() {
	for(int i=0;i<256;i=i+1) {
		state[i] = i;
	}

	int j=0;
	for(int i=0;i<256;i=i+1){
		int k = key[i % 4];
		j = (j + k + state[i]) % 256;
		
		bit temp[8];
		temp = state[i];
		state[i] = state[j];
		state[j] = temp;
	}
}

void tact(int l) {
	x = (x + 1) % 256;
	//костыль
	int t = y + state[x];
	y = t % 256;

	bit temp[8];
	temp = state[x];
	state[x] = state[y];
	state[y] = temp;

	int t1 = state[x] + state[y];
	output[l] = state[t1 % 256]; 
}

void main() {
	init();
	for(int i=0; i<4; i = i + 1){
		tact(i);
	}
}
