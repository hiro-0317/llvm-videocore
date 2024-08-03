__attribute__((noinline)) extern "C" int test_movx_1() {
    volatile int a = 1;
    int c = 0;

    c = !a ? 1 : 3;

    return c;
}

__attribute__((noinline)) extern "C" int test_movx_2() {
    volatile int a = 1;
    int c = 0;

    c = a ? 1 : 3;

    return c;
}

volatile int a = 1;
volatile int b = 2;

__attribute__((noinline)) extern "C" int test_movx_3() {
    if (a < b)
        return 1;
    else
        return 2;
}

__attribute__((noinline)) extern "C" int test_movx_4() {
    int c = 0;

    if (a)
        c = 1;
    else
        c = 3;

    return c;
}

int dst[4] __attribute__((section(".data"))) = {0};
int main(void) {
    dst[0] = test_movx_1();
    dst[1] = test_movx_2();
    dst[2] = test_movx_3();
    dst[3] = test_movx_4();

    return 0;
}
