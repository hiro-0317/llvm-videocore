extern "C" {
  int ctlz(unsigned int _ctlz);
}

__inline int
ctlz(unsigned int _ctlz) {
  return __builtin_clz(_ctlz);
}

int dst[4096] __attribute__((section(".data"))) = {0};

int main(void) {
  for (unsigned int i = 0; i < 4096; i++) {
    dst[i] = ctlz(i);
  }
  return 0;
}
