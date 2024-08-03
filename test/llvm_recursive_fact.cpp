int recursive_fact(int n) {
    if (n == 0)
        return 1;
    return recursive_fact(n - 1) * n;
}

int src __attribute__((section(".data"))) = 7;
int dst __attribute__((section(".data"))) = 0;

int main(void) {
    dst = recursive_fact(src);
    return dst;
}
