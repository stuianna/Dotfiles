#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

union floatConvert {
  int32_t asInteger;
  float asFloat;
};

void printUsage();
void printAsHex(float value);

int main(int argc, char *argv[]) {

  if (sizeof(float) != 4) {
    printf("Warning floating point is not 4-bytes wide.");
    return -1;
  }

  if ((argc < 2) || (argc > 2)) {
    printUsage();
    return -1;
  }

  if ((strlen(argv[1]) == 1) && (argv[1][0] == '0')) {
    printAsHex(0.0f);
    return 0;
  }

  float number = atof(argv[1]);

  // atio returns zero if cannot convert
  if (number != 0) {
    printAsHex(number);
  } else {
    printf("Cannot convert '%s' to a number\n", argv[1]);
    return -1;
  }

  return 0;
}

void printAsHex(float numberAsFloat) {
  union floatConvert value;
  value.asFloat = numberAsFloat;
  printf("0x%X\n", value.asInteger);
}

void printUsage() { printf("Usage: \nfth [single number to convert]\n"); }
