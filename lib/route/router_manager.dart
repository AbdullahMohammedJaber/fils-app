import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder:
          (_) => NavigationService.getPage(
            settings.name ?? '',
            settings.arguments,
          ),
    );
  }
}
