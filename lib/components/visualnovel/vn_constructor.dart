import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/gui/name_box.dart';
import 'package:salem/components/visualnovel/models/text_animation.dart';
import 'package:salem/components/visualnovel/user_interface/background_builder.dart';
import 'package:salem/components/visualnovel/user_interface/buttons.dart';
import 'package:salem/components/visualnovel/user_interface/vn_img_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class VNConstructor extends StatefulWidget {
  VNConstructor({
    this.bgImage,
    this.characterName,
    this.characterText,
    this.cT,
    this.n,
    this.mcImage,
    this.centerCharacterImage,
    this.leftCharacterImage,
    this.rightCharacterImage,
    required this.route,
    required this.nextRoute,
    this.hasAnimation,
    this.animationName,
    this.vnFont,
    this.vnNameFont,
  });
  final String? characterName;
  final bgImage;
  final String? vnFont;
  final String? vnNameFont;
  final String? mcImage;
  final String? centerCharacterImage;
  final String? leftCharacterImage;
  final String? rightCharacterImage;
  final int? n;
  final nextRoute;
  final characterText;
  final cT;
  final route;
  final bool? hasAnimation;
  final animationName;

  @override
  _VNConstructorState createState() => _VNConstructorState();
}

class _VNConstructorState extends State<VNConstructor> {
  bool? isNoti = true;
  int? speed = 25;

  @override
  void initState() {
    super.initState();
    getSpeed();
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isNoti = (prefs.getBool("notiState"));
    if (isNoti == true) {
      //_playAudio();
    } else {}
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
    getSpeed();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        BackgroundBuilder(image: widget.bgImage),
        // Character Image here
        Builder(
          builder: (BuildContext context) {
            if (widget.mcImage != null ||
                widget.centerCharacterImage != null ||
                widget.leftCharacterImage != null ||
                widget.rightCharacterImage != null) {
              if (widget.characterName == "MC" ||
                  widget.characterName == "Narrator") {
                return ImageBuilderMC(image: widget.mcImage);
              } else {
                return ImageBuilder(
                  centerImage: widget.centerCharacterImage,
                  hasAnimation: widget.hasAnimation ?? false,
                  animationName: widget.animationName ?? "idle",
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),

        Builder(
          builder: (context) {
            if (UniversalPlatform.isMacOS ||
                UniversalPlatform.isWindows ||
                UniversalPlatform.isLinux ||
                UniversalPlatform.isWeb) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    NameBox(
                      characterName: widget.characterName,
                      vnNameFont: widget.vnNameFont,
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width / 2.05,
                          child: Builder(builder: (context) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03,
                                      vertical: height * 0.025),
                                  child: Builder(
                                    builder: (context) {
                                      if (widget.characterText != null) {
                                        return AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              widget.characterText ?? "···",
                                              textAlign: TextAlign.left,
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: widget.vnFont,
                                                  fontSize: 21),
                                              speed: Duration(
                                                  milliseconds: speed ?? 25),
                                            ),
                                          ],
                                          displayFullTextOnTap: true,
                                          isRepeatingAnimation: false,
                                          key: ValueKey(widget.n),
                                        );
                                      } else {
                                        return AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              widget.cT ?? "···",
                                              textAlign: TextAlign.left,
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: widget.vnFont,
                                                  fontSize: 21),
                                              speed: Duration(
                                                  milliseconds: speed ?? 25),
                                            ),
                                          ],
                                          displayFullTextOnTap: true,
                                          isRepeatingAnimation: false,
                                          key: ValueKey(widget.n),
                                        );
                                      }
                                    },
                                  )),
                            );
                            //   }
                          }),
                        ),
                      ],
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      NameBox(
                        characterName: widget.characterName,
                        vnNameFont: widget.vnNameFont,
                      ),
                      Column(
                        children: [
                          Stack(alignment: Alignment.centerLeft, children: <
                              Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: MediaQuery.of(context).size.width / 1.25,
                              child: Builder(
                                builder: (context) {
                                  if (widget.characterName == "MC" ||
                                      widget.characterName == "Narrator") {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          border: Border.all(
                                            color: Colors.black.withOpacity(0),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Stack(
                                        children: [
                                          Opacity(
                                            opacity: 1,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03,
                                                  vertical: height * 0.025),
                                              child: AnimatedTextKit(
                                                animatedTexts: [
                                                  TyperAnimatedText(
                                                    widget.characterText ??
                                                        "···",
                                                    textAlign: TextAlign.left,
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            widget.vnFont,
                                                        fontSize: 20),
                                                    speed: Duration(
                                                        milliseconds:
                                                            speed ?? 25),
                                                  ),
                                                ],
                                                displayFullTextOnTap: true,
                                                isRepeatingAnimation: false,
                                                key: ValueKey(widget.n),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(1),
                                          border: Border.all(
                                            color: Colors.black.withOpacity(0),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Stack(
                                        children: [
                                          Opacity(
                                            opacity: 1,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.045,
                                              ),
                                              child: AnimatedTextKit(
                                                // nextSpeech: widget.nextSpeech,
                                                animatedTexts: [
                                                  TyperAnimatedText(
                                                    widget.characterText ??
                                                        "···",
                                                    textAlign: TextAlign.left,
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            widget.vnFont,
                                                        fontSize: 20),
                                                    speed: Duration(
                                                        milliseconds:
                                                            speed ?? 25),
                                                  ),
                                                ],
                                                displayFullTextOnTap: true,
                                                isRepeatingAnimation: false,
                                                key: ValueKey(widget.n),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ]),
                        ],
                      ),
                      Buttons(
                        route: widget.route,
                        nextRoute: widget.nextRoute,
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
