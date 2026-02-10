import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/storage.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  void toggleTheme(bool value) {
    setTheme(value);
    emit(state.copyWith(themeMode: getTheme() ? ThemeMode.dark : ThemeMode.light));

  }

  void toggleNotification(bool value){
    setShowNotification(value);
    emit(state.copyWith(themeMode: getTheme() ? ThemeMode.dark : ThemeMode.light));

  }
}
