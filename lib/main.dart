// ignore_for_file: library_private_types_in_public_api

import 'package:fils/cubit_list.dart';
import 'package:fils/firebase_options.dart';

import 'package:fils/init_app.dart';
import 'package:fils/utils/deeb_link.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
await AppLinkHandler.init();
  await initApp();
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
   @override
  void dispose() {
    AppLinkHandler.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: getCubitRoot(), child: InitAppScreen());
  }
}

 