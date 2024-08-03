typedef struct {
    int value;
    int result;
} param_signed;

param_signed data_signed[] = {
    {-64, 0},    {63, 0},    // 7-bit
    {-128, 0},   {127, 0},   // 8-bit
    {-32768, 0}, {32767, 0}, // 16-bit
};

typedef struct {
    unsigned value;
    unsigned result;
} param_unsigned;

param_unsigned data_unsigned[] = {
    {0, 0},
    {127, 0},   // 7-bit
    {255, 0},   // 8-bit
    {65535, 0}, // 16-bit
};

__attribute__((noinline)) extern "C" void assignment() {
    // Signed integer assignment
    for (int i = 0; i < sizeof(data_signed) / sizeof(data_signed[0]); i++) {
        data_signed[i].result = data_signed[i].value;
    }

    // Unsigned integer assignment
    for (int i = 0; i < sizeof(data_unsigned) / sizeof(data_unsigned[0]); i++) {
        data_unsigned[i].result = data_unsigned[i].value;
    }

    return;
}


int main(void) {
    assignment();
    return 0;
}
