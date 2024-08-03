__attribute__((noinline)) extern "C" int llvm_phinode(int a, int b, int c) {
    int d = 2;

    if (a == 0) {
        a++; // a = 1
    } else if (b != 0) {
        a--; // b = 2
    } else if (c == 0) {
        a += 2;
    }
    d = a + b;

    return d;
}

int a[8] __attribute__((section(".data"))) = {0};
int b[8] __attribute__((section(".data"))) = {0};
int c[8] __attribute__((section(".data"))) = {0};

int dst[8] __attribute__((section(".data"))) = {0};

int main(void) {
    for (int i = 0; i < 8; i++) {
        dst[i] = llvm_phinode(a[i], b[i], c[i]);
    }
    return 0;
}

