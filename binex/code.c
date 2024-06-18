#include <stdio.h>

void main()
{
    int key[16] = {0x00,0x0e,0x05,0x03,0x1c,0x06,0x12,0x71,0x1e,0x1b,0x14,0x12,0x16,0x13,0x0c,0x7b};
    char secret[17] = "aRa2lPT6A6gIqm4RE";
    char pass[17] = "";
    for (int i = 0; i < 17; i = i + 1) {
	//printf("%d\n", i & 7);
	pass[i] = i%3 ^  secret[i];
        printf("%c", pass[i]);
    }

}
