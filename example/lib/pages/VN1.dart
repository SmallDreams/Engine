import 'package:example/constructor/speech_list.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/vn_scaffold.dart';

// ignore: use_key_in_widget_constructors
class VN1 extends StatefulWidget {
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VN1> {
  final canBeAnything = TextConstructor().firstSpeechList;

  @override
  Widget build(BuildContext context) {
    return VNScreen(
      speechList: canBeAnything,
      route: "/1",
      bgm: "storm",
      nextRoute: "/mainmenu",
      bgImage: "assets/images/bgs/lighthouse.jpg",
    );
  }
}
