import 'package:salem_example/pages/chat_screen.dart';
import 'package:salem_example/pages/vn1.dart';
import 'package:salem_example/routes/core/splash_screen.dart';
import 'package:salem_example/routes/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:salem/salem.dart';

// ignore: use_key_in_widget_constructors
class Routes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salem Example',
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
          return MainMenu();
        },
        // '/intro': (_) {
        //   return Intro();
        '/1': (_) {
          return VN1();
        },
        '/chatscreen': (_) {
          return Chat();
        },
      },
    );
  }
}
