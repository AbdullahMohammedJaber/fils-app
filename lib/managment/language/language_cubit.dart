import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState.initial());

  void loadLanguage() {
    emit(LanguageState(locale: Locale(getLang())));
  }

  void changeLanguage(String code, BuildContext context) {
    setLang(code);
    setLocal(code == 'ar' ? 'sa' : code);

    context.setLocale(Locale(code));
    emit(LanguageState(locale: Locale(code)));
   
  }

  List<Map<String, dynamic>> get supportedLocales => [
    {'name': 'English', 'locale': Locale('en'), 'code': 'en'},
    {'name': 'اللغة العربية', 'locale': Locale('ar'), 'code': 'ar'},
    {'name': 'اردو', 'locale': Locale('ur'), 'code': 'ur'},
    {'name': 'हिंदी भाषा', 'locale': Locale('hi'), 'code': 'hi'},
    {'name': 'فارسي', 'locale': Locale('fa'), 'code': 'fa'},
  ];
}
