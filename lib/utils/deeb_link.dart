// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:flutter/material.dart';

class AppLinkHandler {
  AppLinkHandler._();

  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription<Uri>? _subscription;

  static Uri? _pendingUri; // نخزن الرابط لحين جاهزية التطبيق

  /// 🚀 تهيئة App Links (تُستدعى مرة واحدة)
  static Future<void> init() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) {
        _pendingUri = uri;
      }
    } catch (_) {}

    _subscription = _appLinks.uriLinkStream.listen(
      (uri) {
        if (uri != null) {
          _pendingUri = uri;
        }
      },
    );
  }

  /// 🔥 استدعِ هذه بعد انتهاء Splash / تحميل البيانات
  static void handleIfNeeded() {
    if (_pendingUri == null) return;

    final uri = _pendingUri!;
    _pendingUri = null;

    _handleUri(uri);
  }

  /// 🧠 تحليل الرابط
  static void _handleUri(Uri uri) {
    debugPrint("🔗 AppLink: $uri");

    if (uri.host != 'dashboard.fils.app') return;

    if (uri.pathSegments.length < 2) return;

    final type = uri.pathSegments[0];
    final id = uri.pathSegments[1];

    switch (type) {
      case 'product':
        _openProduct(id);
        break;

      case 'store':
        _openStore(id);
        break;
    }
  }

  /// 🛒 صفحة المنتج
  static void _openProduct(String id) {
    NavigationService.navigatorKey.currentState?.pushNamed(
      '/product',
      arguments: int.tryParse(id),
    );
  }

  /// 🏬 صفحة المتجر
  static void _openStore(String id) {
    NavigationService.navigatorKey.currentState?.pushNamed(
      '/store',
      arguments: id,
    );
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
