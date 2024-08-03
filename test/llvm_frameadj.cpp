#define NUM 100

int main() {
    volatile int _a[NUM];
    volatile int _b[NUM];
    volatile int _c[NUM];
    volatile int _d[NUM];

    for (int i = 0; i < NUM; i++) {
        _a[i] = _b[i] + _c[i];
    }
}
