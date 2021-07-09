import 'package:example/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/global/main_menu.dart';
import 'package:dart_vlc/dart_vlc.dart';

void main() {
  DartVLC.initialize();
  runApp(Routes());
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MainMenu(
      bgImage: "mainmenu.jpeg",
      mainMenuBGM: "jetstream",
      creditsButton: false,
      center: true,
      buttonWidth: 400,
      buttonHeight: 80,
      fontSize: 21,
      buttonColor: Colors.white,
      textColor: Colors.black,
      buttonRadius: 7,
    );
  }
}
