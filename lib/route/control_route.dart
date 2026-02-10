// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:url_launcher/url_launcher.dart';

import '../utils/navigation_service/navigation_server.dart';

/// 🔹 Navigate to a route normally
Future To(
    String routeName, {
      Object? arguments,
    }) async {
  return await Navigator.of(
    NavigationService.navigatorKey.currentContext!,
  ).pushNamed(
    routeName,
    arguments: arguments,
  );
}

/// 🔹 Navigate to a route with a page transition
Future ToWithTransition(
    String routeName, {
      Object? arguments,
      PageTransitionType type = PageTransitionType.rightToLeft,
    }) async {
  return await Navigator.push(
    NavigationService.navigatorKey.currentContext!,
    PageTransition(
      type: type,
      child: NavigationService.getPage(routeName, arguments),
      curve: Curves.easeInOutQuart,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    ),
  );
}

/// 🔹 Open external URL
Future<void> toUrl(String url2) async {
  final Uri url = Uri.parse(url2);

  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

/// 🔹 Navigate with fade transition
Future ToWithFade(
    String routeName, {
      Object? arguments,
    }) async {
  return await Navigator.of(
    NavigationService.navigatorKey.currentContext!,
  ).push(
    PageRouteBuilder(
      pageBuilder: (c, a1, a2) =>
          NavigationService.getPage(routeName, arguments),
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ),
  );
}

/// 🔹 Replace current page with new route (fade)
Future ToRemove(
    String routeName, {
      Object? arguments,
    }) async {
  return await Navigator.of(NavigationService.navigatorKey.currentContext!)
      .pushReplacement(
    PageRouteBuilder(
      pageBuilder: (c, a1, a2) =>
          NavigationService.getPage(routeName, arguments),
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ),
  );
}

/// 🔹 Remove all previous routes and push new
Future ToRemoveAll(
    String routeName, {
      Object? arguments,
    }) async {
  Navigator.pushAndRemoveUntil(
    NavigationService.navigatorKey.currentContext!,
    PageRouteBuilder(
      pageBuilder: (c, a1, a2) =>
          NavigationService.getPage(routeName, arguments),
      transitionsBuilder: (c, anim, a2, child) {
        return FadeTransition(opacity: anim, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ),
        (_) => false,
  );
}

/// 🔹 Remove all except first route
Future ToRemoveExcept(
    String routeName, {
      Object? arguments,
    }) async {
  Navigator.pushAndRemoveUntil(
    NavigationService.navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (_) => NavigationService.getPage(routeName, arguments),
    ),
        (Route<dynamic> route) => route.isFirst,
  );
}
