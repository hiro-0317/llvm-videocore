typedef unsigned int UINT32;

__attribute__((noinline)) extern "C" UINT32
udiv32(const UINT32 z, //!<[I ]:dividend
       const UINT32 d) //!<[I ]:divsor
{
    UINT32 q = 0;  // quotient
    UINT32 r = z;  // remainder
    UINT32 n = 32; // quotient bit

    do {
        n--;
        if ((r >> n) >= d) {
            r -= (d << n);
            q += (1 << n);
        }
    } while (n);
    return q;
}

#define LLVM_UDIV32_NUM 1024

UINT32 z[LLVM_UDIV32_NUM] __attribute__((section(".data"))) = {0};
UINT32 d[LLVM_UDIV32_NUM] __attribute__((section(".data"))) = {0};
UINT32 q[LLVM_UDIV32_NUM] __attribute__((section(".data"))) = {0};

int main(void) {
    const int N = LLVM_UDIV32_NUM;
    for (int i = 0; i < N; i++) {
        q[i] = udiv32(z[i], d[i]);
    }
    return q[0];
}

