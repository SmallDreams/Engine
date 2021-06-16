import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistNavigation {
  static Future<void> initSplash(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastRoute = prefs.getString('last_route');
    String? previousRoute = prefs.getString('previous_route');
    if (lastRoute != null && lastRoute != '/') {
      Navigator.pushReplacementNamed(context, lastRoute);
    } else if (previousRoute != null && previousRoute != '/') {
      Navigator.pushReplacementNamed(context, previousRoute);
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
