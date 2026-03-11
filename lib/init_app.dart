import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
 import 'package:fils/language_list.dart';
import 'package:fils/main.dart';
import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/language/language_state.dart';
import 'package:fils/managment/theme/theme_cubit.dart';
import 'package:fils/managment/theme/theme_state.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/router_manager.dart';
import 'package:fils/utils/fcm/fcm_config.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/dark_theme.dart';
import 'package:fils/utils/theme/theme_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

initApp() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
 // await NotificationService().init();

  FirebaseMessaging.onBackgroundMessage(NotificationService.firebaseMessagingBackgroundHandler);

  runApp(
    EasyLocalization(
        path: 'language',
        fallbackLocale: const Locale('ar', ''),
        startLocale: const Locale('ar', ''),
         
        supportedLocales: [...localList],
        child: DevicePreview(
          builder: (context) => MyApp(),
          enabled: false,


          ),
      ),
     
  );
}

class InitAppScreen extends StatefulWidget {
  const InitAppScreen({super.key});

  @override
  State<InitAppScreen> createState() => _InitAppScreenState();
}

class _InitAppScreenState extends State<InitAppScreen> {
  var botToastBuilder = BotToastInit();

  @override
  void initState() {
    super.initState();

    botToastBuilder = BotToastInit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, ThemeState themeState) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, LanguageState languageState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'fils',
              theme: getApplicationTheme(),
              darkTheme: getApplicationThemeDark(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: Locale(getLang()),
              navigatorObservers: [BotToastNavigatorObserver()],
              themeMode: getTheme() ? ThemeMode.dark : ThemeMode.light,
              initialRoute: AppRoutes.splash,
              navigatorKey: NavigationService.navigatorKey,
              onGenerateRoute: AppRouter.generateRoute,
              builder: (context, child) {
                child = botToastBuilder(context, child);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: Scaffold(
                    body: Stack(children: [child]),

                   // floatingActionButton: const GeneralWhatsappButton(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
