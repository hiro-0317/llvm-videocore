float test(float *c, float a) {
  *c = a * a;
  return *c;
}

int main(int argc, char **argv) {
  float c;
  volatile float d = test(&c, (float)argc);

  return d;
}
  
