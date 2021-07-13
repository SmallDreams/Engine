import 'package:flutter/material.dart';

class GetRoutes {
  static getLastRoute(context, lastRoute) {
    Navigator.pushReplacementNamed(context, lastRoute);
  }

  static getPreviousRoute(context, previousRoute) {
    Navigator.pushReplacementNamed(context, previousRoute);
  }

  static getPrimaryRoute(context, primary) {
    Navigator.of(context).pushReplacementNamed(primary ?? "/");
  }
}
