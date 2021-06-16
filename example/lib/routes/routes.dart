import 'package:example/main.dart';
import 'package:example/routes/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:salem/core/persist/route_observer.dart';

class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Example',
      //initialRoute: '/',
      navigatorObservers: <NavigatorObserver>[
        PrimaryRouteObserver(),
      ],

      routes: {
        '/': (_) {
          return SplashScreen();
        },
        "/home": (_) {
          return MyHomePage();
        },
        // '/intro': (_) {
        //   return Intro();
        // },
        // '/1': (_) {
        //   return VN1();
        // },
        // '/2': (_) {
        //   return VN2();
        // },
      },
    );
  }
}
