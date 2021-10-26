// ignore: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:salem/salem.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return SalemMainMenu(
      bgImage: "main.jpg",
      mainMenuBGM: "kids",
      creditsButton: false,
      bottomCenter: true,
      buttonWidth: 250,
      buttonHeight: 65,
      fontSize: 21,
      buttonColor: Colors.white,
      textColor: Colors.black,
      buttonRadius: 15,
    );
  }
}
