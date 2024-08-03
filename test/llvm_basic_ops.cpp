enum opcode {
    ADD,
    SUB,
    MUL,
    SRL,
    SLL,
    AND,
    IOR,
    XOR,
    CEQ,
    CNE,
    CLT,
    CLE,
    CGT,
    CGE,
    OP_NUM,
};

__attribute__((noinline)) extern "C" void
test_basic_ops(unsigned int *res, unsigned int *lhs, unsigned int *rhs) {
    res[ADD] = lhs[ADD] + rhs[ADD];
    res[SUB] = lhs[SUB] - rhs[SUB];
    res[MUL] = lhs[MUL] * rhs[MUL];
    res[SRL] = lhs[SRL] >> rhs[SRL];
    res[SLL] = lhs[SLL] << rhs[SLL];
    res[AND] = lhs[AND] & rhs[AND];
    res[IOR] = lhs[IOR] | rhs[IOR];
    res[XOR] = lhs[XOR] ^ rhs[XOR];
    res[CEQ] = lhs[CEQ] == rhs[CEQ];
    res[CNE] = lhs[CNE] != rhs[CNE];
    res[CLT] = lhs[CLT] < rhs[CLT];
    res[CLE] = lhs[CLE] <= rhs[CLE];
    res[CGT] = lhs[CGT] > rhs[CGT];
    res[CGE] = lhs[CGE] >= rhs[CGE];
}

unsigned int lhs[OP_NUM] __attribute__((section(".data")));
unsigned int rhs[OP_NUM] __attribute__((section(".data")));
unsigned int res[OP_NUM] __attribute__((section(".data")));

int main(void) {
    test_basic_ops(res, lhs, rhs);
    return 0;
}
