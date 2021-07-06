import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
// Saves previous route as also last route
// Example:
// If pushNamed "/page1" -> saves page1 into cache
// If pushNamed -> materialroute, still saves last pushNamed
//

class PrimaryRouteObserver extends RouteObserver {
  void saveLastRoute(Route? previousRoute, Route lastRoute) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (lastRoute.settings.name != null &&
        lastRoute.settings.name != "/" &&
        lastRoute.settings.name != "/settings") {
      prefs.setString('last_route', lastRoute.settings.name!);
    }
    // else if (previousRoute != null && previousRoute.settings.name != "/") {
    //  prefs.setString('previous_route', previousRoute.settings.name!);
    // }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    saveLastRoute(previousRoute, route);
    super.didPop(previousRoute!, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    saveLastRoute(previousRoute, route);
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    saveLastRoute(previousRoute, route);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    saveLastRoute(oldRoute, newRoute!);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
