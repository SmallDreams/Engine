import 'package:example/main.dart';
import 'package:example/pages/VN1.dart';
import 'package:example/routes/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:salem/core/persist/route_observer.dart';
import 'package:salem/components/global/undefinedView.dart';

// ignore: use_key_in_widget_constructors
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
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedView(
                error: settings.name,
              )),
      routes: {
        '/': (_) {
          return SplashScreen();
        },
        "/mainmenu": (_) {
          return MyHomePage();
        },
        // '/intro': (_) {
        //   return Intro();
        '/1': (_) {
          return VN1();
        },
        // '/2': (_) {
        //   return VN2();
        // },
      },
    );
  }
}
