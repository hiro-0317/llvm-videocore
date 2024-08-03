__attribute__((noinline)) extern "C" int llvm_local_pointer() {
    int b = 3;

    volatile int *p = &b;

    return *p;
}

int dst __attribute__((section(".data"))) = 0;
int main(void) {
    dst = llvm_local_pointer();
    return dst;
}
