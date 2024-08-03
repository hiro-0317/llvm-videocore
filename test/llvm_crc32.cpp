/*
CRC-32
x^32+x^26+x^23+x^22+x^16+x^12+x^11+x^10+x^8+x^7+x^5+x^4+x^2+x+1
0x04C11DB7 / (0xEDB88320 reverse)
*/

typedef unsigned int UINT32;
typedef unsigned char UINT8;

UINT32 crc_table[256] __attribute__((section(".data"))) = {0};

__attribute__((noinline)) extern "C" void make_crc_table(void) {
    for (UINT32 i = 0; i < 256; i++) {
        UINT32 c = i;
        for (int j = 0; j < 8; j++) {
            c = (c & 1) ? (0xEDB88320 ^ (c >> 1)) : (c >> 1);
        }
        crc_table[i] = c;
    }
}

__attribute__((noinline)) extern "C" UINT32 crc32(UINT32 *buf, UINT32 len) {
    UINT32 c = 0xFFFFFFFF;
    UINT32 tmp;
    for (UINT32 i = 0; i < len; i++) {
        if ((i % 4) == 0)
            tmp = buf[i / 4];
        UINT32 d = (tmp >> (8 * (i % 4))) & 0xff;
        c = crc_table[(c ^ d) & 0xFF] ^ (c >> 8);
    }
    return c ^ 0xFFFFFFFF;
}

UINT32 data[1024] __attribute__((section(".data"))) = {0};
UINT32 len __attribute__((section(".data"))) = 0;
UINT32 retval __attribute__((section(".data"))) = 0;

int main(void) {
    make_crc_table();
    retval = crc32(data, len);
    return 0;
}
