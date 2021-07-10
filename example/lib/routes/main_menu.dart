// ignore: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:salem/salem.dart';

class MainMenu extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return SalemMainMenu(
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
