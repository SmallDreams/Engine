import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/UI/buttons.dart';
import 'package:salem/components/visualnovel/UI/vn_img_builder.dart';
import 'package:salem/components/visualnovel/ui/background_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VNConstructorTextSound extends StatefulWidget {
  final bgImage;
  final characterName;
  final characterText;
  final initNumber;
  final charImage;
  final route;
  final nextRoute;
  final nameBuilder;

  VNConstructorTextSound(
      {required this.bgImage,
      required this.characterName,
      required this.characterText,
      required this.initNumber,
      required this.charImage,
      required this.route,
      required this.nextRoute,
      required this.nameBuilder});

  @override
  _InterludeState createState() => _InterludeState();
}

class _InterludeState extends State<VNConstructorTextSound> {
  int? speed;
  @override
  void initState() {
    super.initState();
    getSpeed();
  }

  getSpeed() async {
    speed = await getSpeedState() ?? 50;
    setState(() {});
  }

  saveSpeedState(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("speedValue", value);
  }

  getSpeedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? speed = prefs.getInt('speedValue');
    return speed;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        BackgroundBuilder(image: widget.bgImage),
        Builder(
          builder: (BuildContext context) {
            if (widget.charImage.isNotEmpty || widget.charImage != null) {
              if (widget.characterName == "MC") {
                return ImageBuilderMC(image: widget.charImage);
              } else {
                return ImageBuilder(image: widget.charImage);
              }
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        Builder(
          builder: (context) {
            if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    widget.nameBuilder,
                    Container(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Opacity(
                              opacity: 0.8,
                              child: ClayContainer(
                                spread: 2,
                                surfaceColor: Colors.white,
                                curveType: CurveType.none,
                                width: 700,
                                //color: Colors.brown[400],
                                color: Colors.grey,
                                customBorderRadius: const BorderRadius.only(
                                  //Radius.circular(30),
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.025,
                                      vertical: height * 0.025),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        widget.characterText ??
                                            "Placeholder text.",
                                        textAlign: TextAlign.left,
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mali",
                                            fontSize: 22),
                                        speed:
                                            Duration(milliseconds: speed ?? 50),
                                      ),
                                    ],
                                    displayFullTextOnTap: true,
                                    isRepeatingAnimation: false,
                                    key: ValueKey(widget.initNumber),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Buttons(
                      route: widget.route,
                      nextRoute: widget.nextRoute,
                    ),
                  ],
                ),
              );
            } else {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 15),
                    child: Buttons(route: widget.route),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //VNNameBuilder(),
                      widget.nameBuilder,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 4.4),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(5),
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.asset(
                                          "assets/images/gui/textbox_scroll_03.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 70),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              widget.characterText ??
                                                  "Placeholder text.",
                                              textAlign: TextAlign.left,
                                              textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Aleo",
                                                  fontSize: 18),
                                              speed: Duration(
                                                  milliseconds: speed ?? 50),
                                            ),
                                          ],
                                          displayFullTextOnTap: true,
                                          isRepeatingAnimation: false,
                                          key: ValueKey(widget.initNumber),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
