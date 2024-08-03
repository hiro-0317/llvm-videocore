__attribute__((noinline)) extern "C" int gcd(int a, int b) {
    while (a != b) {
        if (b < a)
            a = a - b;
        else
            b = b - a;
    }

    return a;
}

int src0 __attribute__((section(".data"))) = 1071;
int src1 __attribute__((section(".data"))) = 1029;
int dst __attribute__((section(".data"))) = 0;

int main(void) {
    dst = gcd(src0, src1);
    return dst;
}
