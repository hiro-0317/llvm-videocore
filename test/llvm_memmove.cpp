extern "C" {
  void* memmove(void *dst, void *src, int len);
}

int dst[1024] __attribute__((section(".data"))) = {0x01020304};

int main(void) {
  memmove((void *)(dst + 32), (void *)dst, sizeof(dst) / sizeof(int) - 32);
  return 0;
}
