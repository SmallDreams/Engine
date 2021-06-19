import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistNavigation {
  /// Saves and loads the last route saved into cache.
  static Future<void> initSplash(context, mainmenu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastRoute = prefs.getString('last_route');
    String? previousRoute = prefs.getString('previous_route');
    if (lastRoute != null && lastRoute != "/") {
      Navigator.pushReplacementNamed(context, lastRoute);
    } else if (previousRoute != null && previousRoute != "/") {
      Navigator.pushReplacementNamed(context, previousRoute);
    } else {
      Navigator.of(context).pushReplacementNamed(mainmenu ?? "/");
    }
  }
}

class SplashLoadingScreen extends StatelessWidget {
  /// 'bgColor' sets the background Color for the splash page.
  final bgColor;

  /// 'opacity'
  final opacity;

  /// 'imgDuration' sets how long until the image fades completely in.
  final imgDuration;

  /// 'splashImage' defines the image which should be shown on the splash screen.
  final splashImage;
  SplashLoadingScreen(
      {this.bgColor, this.opacity, this.imgDuration, this.splashImage});
  @override
  Widget build(BuildContext context) {
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
                            )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
