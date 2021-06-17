import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/UI/buttons.dart';
import 'package:salem/components/visualnovel/UI/vn_img_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VNConstructorTextSound extends StatefulWidget {
  final bgImage;
  final String? a;
  final String? q;
  final int n;
  final charImage;
  final route;
  final nextRoute;

  const VNConstructorTextSound(this.bgImage, this.a, this.q, this.n,
      this.charImage, this.route, this.nextRoute);

  @override
  _InterludeState createState() => _InterludeState();
}

class _InterludeState extends State<VNConstructorTextSound> {
  int? speed;
  String? _name;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            _name = prefValue.getString('name') ?? 'MC';
          })
        });
    getSpeed();
  }

  getSpeed() async {
    speed = await getSpeedState();
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
        // Character here
        Builder(
          builder: (BuildContext context) {
            if (widget.a == "MC") {
              return ImageBuilderMC(image: widget.charImage);
            } else {
              return ImageBuilder(image: widget.charImage);
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
                    Builder(
                      builder: (context) {
                        if (widget.a! == "MC") {
                          return Opacity(
                            opacity: 0.8,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Text(
                                  "$_name",
                                  style: const TextStyle(
                                    fontFamily: "Julee",
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Opacity(
                            opacity: 0.8,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Text(
                                  widget.a!,
                                  style: const TextStyle(
                                    fontFamily: "Julee",
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
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
                                        widget.q!,
                                        textAlign: TextAlign.left,
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mali",
                                            fontSize: 22),
                                        speed: Duration(milliseconds: speed!),
                                      ),
                                    ],
                                    displayFullTextOnTap: true,
                                    isRepeatingAnimation: false,
                                    key: ValueKey(widget.n),
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
                      Builder(
                        builder: (context) {
                          if (widget.a! == "MC") {
                            return Opacity(
                              opacity: 0.8,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 15),
                                  child: Text(
                                    "$_name",
                                    style: const TextStyle(
                                      fontFamily: "Julee",
                                      fontSize: 21,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Opacity(
                              opacity: 0.8,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 15),
                                  child: Text(
                                    widget.a!,
                                    style: const TextStyle(
                                      fontFamily: "Julee",
                                      fontSize: 21,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
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
                                              widget.q!,
                                              textAlign: TextAlign.left,
                                              textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Aleo",
                                                  fontSize: 18),
                                              speed: Duration(
                                                  milliseconds: speed!),
                                            ),
                                          ],
                                          displayFullTextOnTap: true,
                                          isRepeatingAnimation: false,
                                          key: ValueKey(widget.n),
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
