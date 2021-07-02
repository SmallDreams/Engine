import 'package:example/constructor/speech1.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/vn_scaffold.dart';

// ignore: use_key_in_widget_constructors
class VN1 extends StatefulWidget {
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VN1> {
  final textSound = TextConstructor1();

  @override
  Widget build(BuildContext context) {
    return VNScaffold(
      textSound: textSound,
      route: "/1",
      nextRoute: "/mainmenu",
      bgImage: "battlegroupSilverDawn.png",
    );
  }
}
