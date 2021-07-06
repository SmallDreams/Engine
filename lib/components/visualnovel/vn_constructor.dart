import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/UI/background_builder.dart';
import 'package:salem/components/visualnovel/UI/buttons.dart';
import 'package:salem/components/visualnovel/components/textAnimation.dart';
import 'package:salem/components/visualnovel/ui/vn_img_builder.dart';
import 'package:salem/core/audio/globalAudio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class VNConstructor extends StatefulWidget {
  VNConstructor({
    this.bgImage,
    this.characterName,
    this.characterText,
    this.n,
    this.mcImage,
    this.sideCharImage,
    this.route,
    this.nextRoute,
    this.nextText,
    this.voice,
  });

  final String? characterName;
  final bgImage;
  final String? mcImage;
  final String? sideCharImage;
  final int? n;
  final nextRoute;
  final characterText;
  final route;
  final nextText;
  final voice;

  @override
  _VNConstructorState createState() => _VNConstructorState();
}

class _VNConstructorState extends State<VNConstructor> {
  bool? isNoti = true;
  int? speed = 25;

  String? _name;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            _name = prefValue.getString('name') ?? 'MC';
          })
        });
  }

  Future<Null> getSharedPrefs() async {
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

  void _playAudio() async {
    GlobalAudio.playAudio.getBGM(widget.voice);
    //player = await _audioCache.play(widget.s! + '.mp3');
  }

  @override
  Widget build(BuildContext context) {
    _playAudio();
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
            if (widget.characterName == "MC" ||
                widget.characterName == "Narrator") {
              return ImageBuilderMC(image: widget.mcImage);
            } else {
              return ImageBuilder(image: widget.sideCharImage);
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
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        if (widget.characterName == "MC" ||
                            widget.characterName == "Narrator") {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Text(
                                  "$_name",
                                  style: TextStyle(
                                    fontFamily: "IndieFlower",
                                    fontSize: 32,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 15),
                              child: Text(
                                widget.characterName!,
                                style: TextStyle(
                                  fontFamily: "IndieFlower",
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          // constraints:
                          //     BoxConstraints(minWidth: 100, minHeight: 100),
                          width: MediaQuery.of(context).size.width / 2.05,
                          child: Builder(builder: (context) {
                            bool textbox = File("assets/images/gui/textbox.png")
                                .existsSync();
                            if (textbox == true) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/gui/textbox.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    color: Colors.white.withOpacity(0),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0),
                                    ),
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(0.0),
                                      topRight: const Radius.circular(0.0),
                                      bottomRight: const Radius.circular(0.0),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03,
                                      vertical: height * 0.025),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        widget.characterText,
                                        textAlign: TextAlign.left,
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mali",
                                            fontSize: 21),
                                        speed:
                                            Duration(milliseconds: speed ?? 25),
                                      ),
                                    ],
                                    displayFullTextOnTap: true,
                                    isRepeatingAnimation: false,
                                    key: ValueKey(widget.n),
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0),
                                    ),
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(0.0),
                                      topRight: const Radius.circular(0.0),
                                      bottomRight: const Radius.circular(0.0),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03,
                                      vertical: height * 0.025),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TyperAnimatedText(
                                        widget.characterText,
                                        textAlign: TextAlign.left,
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Mali",
                                            fontSize: 21),
                                        speed:
                                            Duration(milliseconds: speed ?? 25),
                                      ),
                                    ],
                                    displayFullTextOnTap: true,
                                    isRepeatingAnimation: false,
                                    key: ValueKey(widget.n),
                                  ),
                                ),
                              );
                            }
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
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 15),
                    child: Buttons(route: widget.route),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Builder(
                        builder: (context) {
                          if (widget.characterName == "MC") {
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
                                    style: TextStyle(
                                      fontFamily: "IndieFlower",
                                      fontSize: 19,
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 15),
                                  child: Text(
                                    widget.characterName!,
                                    style: TextStyle(
                                      fontFamily: "IndieFlower",
                                      fontSize: 19,
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
                            Stack(alignment: Alignment.centerLeft, children: <
                                Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                // constraints:
                                //     BoxConstraints(minWidth: 100, minHeight: 100),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Builder(
                                  builder: (context) {
                                    if (widget.characterName == "MC" ||
                                        widget.characterName == "Narrator") {
                                      return Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/gui/textbox_scroll_03.png'),
                                              fit: BoxFit.fill,
                                            ),
                                            color: Colors.white.withOpacity(0),
                                            border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0),
                                            ),
                                            borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(0.0),
                                              topRight:
                                                  const Radius.circular(0.0),
                                              bottomLeft:
                                                  const Radius.circular(0.0),
                                            )),
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
                                                      widget.characterText,
                                                      textAlign: TextAlign.left,
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Mali",
                                                          fontSize: 18),
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
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/gui/textbox_scroll_03.png'),
                                              fit: BoxFit.fill,
                                            ),
                                            color: Colors.white.withOpacity(0),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0),
                                            ),
                                            borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(0.0),
                                              topRight:
                                                  const Radius.circular(0.0),
                                              bottomRight:
                                                  const Radius.circular(0.0),
                                            )),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.025),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                widget.characterText,
                                                textAlign: TextAlign.left,
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Mali",
                                                    fontSize: 18),
                                                speed: Duration(
                                                    milliseconds: speed ?? 25),
                                              ),
                                            ],
                                            displayFullTextOnTap: true,
                                            isRepeatingAnimation: false,
                                            key: ValueKey(widget.n),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),

                                // FittedBox(
                                //   fit: BoxFit.fitHeight,
                                //   child: Stack(
                                //     children: <Widget>[
                                //       Container(
                                //         color: Colors.transparent,
                                //         padding: EdgeInsets.symmetric(
                                //             vertical: 15, horizontal: 70),
                                //         child: AnimatedTextKit(
                                //           animatedTexts: [
                                //             TyperAnimatedText(
                                //               widget.q!,
                                //               textAlign: TextAlign.left,
                                //               textStyle: TextStyle(
                                //                   color: Colors.black,
                                //                   fontFamily: "Aleo",
                                //                   fontSize: 18),
                                //               speed: Duration(milliseconds: isFinished ? 0 : speed!),),
                                //             ),
                                //           ],
                                //           displayFullTextOnTap: true,
                                //           isRepeatingAnimation: false,
                                //           key: ValueKey(widget.n),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ),
                            ]),
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
