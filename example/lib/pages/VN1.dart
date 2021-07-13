import 'package:salem_example/constructor/speech_list.dart';
import 'package:flutter/material.dart';
import 'package:salem/salem.dart';

// ignore: use_key_in_widget_constructors
class VN1 extends StatelessWidget {
  final canBeAnything = firstSpeechList;

  @override
  Widget build(BuildContext context) {
    return VNScreen(
      speechList: canBeAnything,
      route: "/1",
      bgm: "storm",
      nextRoute: "/chatscreen",
      bgImage: "assets/images/bgs/lighthouse.jpg",
    );
  }
}
