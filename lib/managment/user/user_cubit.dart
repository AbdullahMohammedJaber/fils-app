// ignore_for_file: unused_field

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/global_function/attachment_manage.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  String _greeting = 'Hello 👋';
  Timer? _timer;

  String get greeting => _greeting;

  void startRealtimeUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateGreeting();
    });
  }

  void _updateGreeting() {
    final now = DateTime.now().toLocal();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      _greeting = 'Good Morning 👋'.tr();
    } else if (hour >= 12 && hour < 18) {
      _greeting = 'Good Afternoon 🌞'.tr();
    } else if (hour >= 18 && hour < 21) {
      _greeting = 'Good Evening 🌅'.tr();
    } else {
      _greeting = 'Good Night 🌙'.tr();
    }
    emit(state.copyWith(greet: _greeting));
  }

  functionSelectImage(BuildContext context) async {
    
    final result = await pickEditAndUploadImage(
      context: context,
      endpoint: "file/upload",
      fileKey: "aiz_file",
    );
    
    if (result != null) {
      emit(
        state.copyWith(
          idImageProfile: int.parse(result.imageId),
          greet: state.greeting,
        ),
      );
      showBoatToast();

      final json = await UserCase().profileUseCase.profileUpdate(
        data: {
          "name": getUser()!.user!.name,
          "email": getUser()!.user!.email,
          "phone": getUser()!.user!.phone,
          "avatar_original": state.idImageProfile,
        },
      );
      closeAllLoading();
      json.handle(
        onSuccess: (data) {
          setUserStorage(data);
          emit(
            state.copyWith(
              idImageProfile: int.parse(result.imageId),
              greet: state.greeting,
            ),
          );
        },
      );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
