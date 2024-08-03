extern "C" {
  int cttz(unsigned int _cttz);
}

__inline int
cttz(unsigned int _cttz) {
  return __builtin_ctz(_cttz);
}

int dst[4096] __attribute__((section(".data"))) = {0};

int main(void) {
  for (unsigned int i = 0; i < 4096; i++) {
    dst[i] = cttz(i);
  }
  return 0;
}
