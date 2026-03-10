// ignore_for_file: unused_local_variable, empty_catches

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/printer.dart';
import 'package:fils/utils/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Channel ID for Android
  final String _channelId = "fils";

Future<void> init() async {
  await _initLocalNotifications();
 final FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus != AuthorizationStatus.authorized) {
    return;
  }
   await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
 await messaging.setAutoInitEnabled(true);
 
  try {
    if (Platform.isIOS) {
 
      await Future.delayed(const Duration(seconds: 2));

      String? apnsToken =
          await FirebaseMessaging.instance.getAPNSToken();

 
      if (apnsToken == null) {
    
        return;
      }

      
      await setFcmToken(apnsToken); // خزنه في السيرفر أو SharedPrefs

      String? fcmToken =
          await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
 
        await setFcmToken(fcmToken);
      }
    } else {
      // Android
      String? fcmToken =
          await FirebaseMessaging.instance.getToken();

      if (fcmToken != null) {
     
        await setFcmToken(fcmToken);
        await FirebaseMessaging.instance.subscribeToTopic("fils");
      }
    }

    // استماع لتحديث التوكن
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
   
      await setFcmToken(newToken);
    });

    _listenFCM();
  } catch (e) {
 
  }
}
  Future<void> _initLocalNotifications() async {
    var androidSettings = const AndroidInitializationSettings(
      '@drawable/logo_noti',
    );
    var iosSettings = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationSelected,
    );

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  int parseMessageId(String? id) {
    if (id == null || id.isEmpty) {
      return DateTime.now().millisecondsSinceEpoch ~/ 1000;
    }

    final numeric = id.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeric.isEmpty) {
      return DateTime.now().millisecondsSinceEpoch ~/ 1000;
    }

    String lastDigits =
        numeric.length > 6 ? numeric.substring(numeric.length - 6) : numeric;

    return int.parse(lastDigits);
  }

  void _listenFCM() {
    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printGreen("FCM Message Received: ${jsonEncode(message.data)}");
      bool notificationEnable = isShowNotification();
      if (notificationEnable && message.notification != null) {
        _showNotification(
          messageId: parseMessageId(message.messageId),
          title: message.notification!.title,
          body: message.notification!.body,
          payload: jsonEncode(message.data),
        );
      }
      if (message.data.isNotEmpty) {
        _handleSilent(message.data);
      }
    });

    // Background / app opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printGreen("FCM Opened Message: ${jsonEncode(message.data)}");
      bool notificationEnable = isShowNotification();
      if (notificationEnable && message.notification != null) {
        _showNotification(
          messageId: parseMessageId(message.messageId),
          title: message.notification!.title,
          body: message.notification!.body,
          payload: jsonEncode(message.data),
        );
      }
      _onNotificationSelected(
        NotificationResponse(
          notificationResponseType:
              NotificationResponseType.selectedNotification,
          payload: jsonEncode(message.data),
        ),
      );
    });
  }

  Future<void> _showNotification({
    required int messageId,
    String? title,
    String? body,
    required String payload,
  }) async {
    var androidDetails = AndroidNotificationDetails(
      _channelId,
      "Fils Channel",
      channelDescription: "Default channel for notifications",
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/logo_noti',
    );

    var iosDetails = const DarwinNotificationDetails(presentSound: true);

    var details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(
      messageId,
      title,
      body,
      details,
      payload: payload,
    );
  }

  void _onNotificationSelected(NotificationResponse response) {
    if (response.payload == null) return;

    Map<String, dynamic> data = jsonDecode(response.payload!);

    // Example: handle routing by notification type
    String type = data['notification_type_id'].toString();
    log("Notification Type: $type");

    switch (type) {
      case "1":
        // Navigate to Auction Win Page

        break;
      case "30":
        // Silent / custom handling
        break;
      default:
        // Default action
        break;
    }
  }

  void _handleSilent(Map<String, dynamic> data) {
    String productId = data['product_id'].toString();
    String userId = data['user_id'].toString();
    switch (data['notification_type_id'].toString()) {
      case "30":
        if (userId == getUser()!.user!.id) {
          showMessage(
            "You won the auction and won the product.\n Now you have to pay by going to the Cart and paying through it"
                .tr(),
            value: true,
          );
        }
        Future.delayed(Duration(seconds: 1), () {
          ToRemoveAll(AppRoutes.rootGeneral);
        });

        break;
    }
    log("Silent Notification: ${jsonEncode(data)}");
  }

  // Optional: background handler
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    print("Background message received: ${message.messageId}");
  }
}
