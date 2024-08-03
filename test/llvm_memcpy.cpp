extern "C" {
  void* memcpy(void  *dst, void *src, int len);
}

int src[1024] __attribute__((section(".data"))) = {0};
int dst[1024] __attribute__((section(".data"))) = {0};

int main(void) {
  memcpy((void *)dst, (void *)src, sizeof(src));
  return 0;
}
