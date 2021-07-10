import 'package:flutter/material.dart';
import 'package:salem/salem.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Starting opacity.
  double opacity = 0.0;

  /// Duration the splash screen is alive.
  int splashScreenDuration = 3;

  /// the opacity duration.
  int opacityDuration = 1;

  /// Main Menu route defined in Route
  String mainmenu = "/mainmenu";

  @override
  Widget build(BuildContext context) {
    return SplashLoadingScreen(
      hasAnimation: true,
      riveAnimation: "intro",
      bgColor: Colors.black,
      opacity: opacity,
      imgDuration: 250,
      splashImage: "assets/images/MUTA.png",
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: splashScreenDuration), () {
      PersistNavigation.initSplash(context, mainmenu);
    });
    Future.delayed(Duration(seconds: opacityDuration), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }
}
