typedef struct sra_param {
    int lhs;
    int rhs;
    int res;
} sra_param;

sra_param p[] = {
    //  lhs, rhs, expected
    {1024, 0, 1024},

    {1024, 1, 512},   {1024, 2, 256},   {1024, 3, 128},   {1024, 4, 64},
    {1024, 5, 32},    {1024, 6, 16},    {1024, 7, 8},     {1024, 8, 4},
    {1024, 9, 2},     {1024, 10, 1},    {1024, 11, 0},    {1024, 12, 0},
    {1024, 31, 0},

    {-1024, 1, -512}, {-1024, 2, -256}, {-1024, 3, -128}, {-1024, 4, -64},
    {-1024, 5, -32},  {-1024, 6, -16},  {-1024, 7, -8},   {-1024, 8, -4},
    {-1024, 9, -2},   {-1024, 10, -1},  {-1024, 11, -1},  {-1024, 12, -1},
    {-1024, 31, -1},
};

__attribute__((noinline)) extern "C" void _sra(sra_param *p, unsigned num) {
    for (unsigned i = 0; i < num; i++) {
        p[i].res = p[i].lhs >> p[i].rhs;
    }
}

int main(void) {
    _sra(p, sizeof(p) / sizeof(p[0]));
    return 0;
}
