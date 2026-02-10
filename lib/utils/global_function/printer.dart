// ignore_for_file: avoid_print

import 'dart:developer';

void printWarningLong(String text) {
  print(
      '\x1B[33m//////////////////////////////////////////////////////////////////////////\x1B[0m');
  log(text);

  print('\x1B[37m' '\x1B[0m');
}

void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
  log(text);
  print('\x1B[37m' '\x1B[0m');
}

void printGreen(String text) {
  print('\x1B[32m$text\x1B[0m');
  print('\x1B[37m' '\x1B[0m');
}

void printGreenLong(String text) {
  print(
      '\x1B[32m//////////////////////////////////////////////////////////////////////////\x1B[0m');
  log(text);

  print('\x1B[37m' '\x1B[0m');
}

void printBlue(String text) {
  print('\x1B[34m$text\x1B[0m');
  print('\x1B[37m' '\x1B[0m');
}

void printBlueLong(String text) {
  print(
      '\x1B[34m//////////////////////////////////////////////////////////////////////////\x1B[0m');
  log(text);

  print('\x1B[37m' '\x1B[0m');
}
