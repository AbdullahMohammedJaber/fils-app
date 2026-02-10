import 'package:flutter/material.dart';

@immutable
class ThemeState {
  final ThemeMode? themeMode;

  const ThemeState({this.themeMode});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode);
  }
}
