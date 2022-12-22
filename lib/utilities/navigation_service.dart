import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic>? navigateTo(String routeName, dynamic argumanet) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: argumanet);
  }

  Future<dynamic>? replaceTo(String routeName) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  Future<dynamic>? navigateToreplace(String routeName, dynamic argumanet) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: argumanet);
  }

  pop() {
    navigatorKey.currentState?.pop();
  }
}
