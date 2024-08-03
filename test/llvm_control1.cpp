__attribute__((noinline)) extern "C" int llvm_control1() {
#if 1 // prevent optimize
    volatile unsigned int _a = 0;
    unsigned int a = _a;
#else
    unsigned int a = 0;
#endif
    int b = 39;
    int i = 3;

    for (i = 0; i <= 3; i++) {
        a = a + i; // a = 6
    }
    if (b == 0) {
        b--;
    } else if (b > 0) {
        b++; // b = 40
        goto label_1;
    }

label_1:
    for (i = 3; i >= 2; i--) {
        a--; // a = 4
    }

    while (i < 100) {
        a++;
        i++;
        if (a < 10)
            continue;
        else
            break;
    }

    switch (a) {
    case 10:
        a++; // a = 11
        break;
    default:
        a = 0;
    }

    return (a + b); // 11+40 = 51
}

int dst __attribute__((section(".data"))) = 0;

int main(void) {
    dst = llvm_control1();
    return dst;
}
