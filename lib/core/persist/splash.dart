import 'package:flutter/material.dart';
import 'package:salem/core/persist/constants/get_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rive_splash.dart';

class PersistNavigation {
  static Future<void> initSplash(context, primary) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastRoute = prefs.getString('last_route');
    if (lastRoute != null && lastRoute != "/" && lastRoute != "/settings") {
      GetRoutes.getLastRoute(context, lastRoute);
    } else {
      GetRoutes.getPrimaryRoute(context, primary);
    }
  }
}

class SalemSplashScreen extends StatefulWidget {
  final String mainMenuRoute;
  final dynamic splashloadingscreen;
  final String? hasAnimation;
  SalemSplashScreen({
    required this.mainMenuRoute,
    required this.splashloadingscreen,
    this.hasAnimation,
  });
  @override
  _State createState() => _State();
}

class _State extends State<SalemSplashScreen> {
  @override
  void initState() {
    super.initState();
    PersistNavigation.initSplash(context, widget.mainMenuRoute);
  }

  @override
  Widget build(BuildContext context) {
    return widget.splashloadingscreen;
  }
}

/// Necessary screen to load in all the assets.
class SplashLoadingScreen extends StatelessWidget {
  /// 'bgColor' sets the background Color for the splash page.
  final bgColor;

  /// 'opacity'
  final opacity;

  /// 'imgDuration' sets how long until the image fades completely in.
  final imgDuration;

  /// 'splashImage' defines the image which should be shown on the splash screen.
  final splashImage;

  final hasAnimation;

  final riveAnimation;
  SplashLoadingScreen({
    this.bgColor,
    this.opacity,
    this.imgDuration,
    this.splashImage,
    this.hasAnimation = false,
    this.riveAnimation,
  });
  @override
  Widget build(BuildContext context) {
    if (hasAnimation == true) {
      return RiveSplashScreen.navigate(
        name: "assets/images/" + riveAnimation + ".riv",
        until: () => Future.delayed(Duration(seconds: 2)),
        startAnimation: 'Landing',
      );
    } else {
      return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Container(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            AnimatedOpacity(
                              opacity: opacity,
                              duration: Duration(milliseconds: imgDuration),
                              child: Center(
                                child: Image.asset(
                                  splashImage,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
