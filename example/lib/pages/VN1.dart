import 'package:example/constructor/vn_text.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/vn_scaffold.dart';

class VN1 extends StatefulWidget {
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VN1> {
  static final textSound = TextConstructor1();
  @override
  Widget build(BuildContext context) {
    return VNScaffold(
      textSound: textSound,
      route: "/1",
      nextRoute: "/mainmenu",
      hasVoiceActing: false,
      bgImage: "bg1.jpg",
    );
  }
}
