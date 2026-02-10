import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fils/core/data/response/update/update_response.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  UpdateCubit() : super(UpdateInitial());

  Future<UpdateResponse?> fetchUpdateConfig() async {
    final ref = FirebaseDatabase.instance.ref('update');

    final snapshot = await ref.get();

    if (!snapshot.exists) return null;

    final data = Map<String, dynamic>.from(snapshot.value as Map);

    return UpdateResponse.fromJson(data);
  }

  Future<void> checkForUpdate(BuildContext context) async {
    final config = await fetchUpdateConfig();
    if (config == null) return;

    final packageInfo = await PackageInfo.fromPlatform();
    final localVersion = packageInfo.version;

    final isAndroid = Platform.isAndroid;
    final isIOS = Platform.isIOS;

    late String remoteVersion;
    late bool showUpdate;
    late bool forceUpdate;

    if (isAndroid) {
      remoteVersion = config.version_android;
      showUpdate = config.show_update_android;
      forceUpdate = config.force_update_android;
    } else if (isIOS) {
      remoteVersion = config.version_ios;
      showUpdate = config.show_update_ios;
      forceUpdate = config.force_update_ios;
    } else {
      return;
    }

    if (!showUpdate) return;
    if (remoteVersion != localVersion) {
      _showUpdateDialog(context, forceUpdate);
    }
    return;
  }

  void _showUpdateDialog(BuildContext context, bool force) {
    showDialog(
      context: context,
      barrierDismissible: !force,
      builder:
          (_) => WillPopScope(
            onWillPop: () async => !force,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              title: DefaultText("Update the app".tr()),
              content: DefaultText(
                "We've added new improvements for a better experience ✨\nPlease update the app."
                    .tr(),
                overflow: TextOverflow.visible,
              ),

              actions: [
                if (!force)
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: DefaultText("Skip".tr()),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await toUrl('https://play.google.com/store/apps/details?id=com.app.fils');
                    } else {
                      await toUrl('https://apps.apple.com/us/app/fils/id6745802326');
                    }
                  },
                  child: DefaultText("Update".tr()),
                ),
              ],
            ),
          ),
    );
  }
}
