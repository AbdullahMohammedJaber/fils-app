import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';

class LanguageState {
  final Locale locale;

  const LanguageState({required this.locale});
  factory LanguageState.initial() =>
        LanguageState(locale: Locale(getLang()));
}
