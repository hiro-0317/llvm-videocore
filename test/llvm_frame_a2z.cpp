__attribute__((noinline)) extern "C" int frame_a2z(void) {
    volatile int a = 0;
    volatile int b = a + 1;
    volatile int c = b + 1;
    volatile int d = c + 1;
    volatile int e = d + 1;
    volatile int f = e + 1;
    volatile int g = f + 1;
    volatile int h = g + 1;
    volatile int i = h + 1;
    volatile int j = i + 1;
    volatile int k = j + 1;
    volatile int l = k + 1;
    volatile int m = l + 1;
    volatile int n = m + 1;
    volatile int o = n + 1;
    volatile int p = o + 1;
    volatile int q = p + 1;
    volatile int r = q + 1;
    volatile int s = r + 1;
    volatile int t = s + 1;
    volatile int u = t + 1;
    volatile int v = u + 1;
    volatile int w = v + 1;
    volatile int x = w + 1;
    volatile int y = x + 1;
    volatile int z = y + 1;

    return a + b + c + d + e + f + j + h + i + j + k + l + m + n + o + p + q +
           r + s + t + u + v + w + x + y + z;
}

int dst __attribute__((section(".data"))) = 0;

int main() {
    dst = frame_a2z();
    return dst;
}
