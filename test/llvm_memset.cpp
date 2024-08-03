extern "C" {
  void* memset(void  *dst, int  val, int len);
}

int dst[1024] __attribute__((section(".data"))) = {0};

int main(void) {
  memset((void *)dst, 1, sizeof(dst));
  return 0;
}
