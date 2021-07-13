import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/global/logical_keyboard.dart';
import 'package:salem/components/global/onWillPop.dart';
import 'package:salem/components/visualnovel/user_interface/background_builder.dart';
import 'package:salem/core/audio/game_audio.dart';
import 'package:salem/core/audio/global_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'vn_constructor.dart';
import 'package:universal_platform/universal_platform.dart';

class VNScreen extends StatefulWidget {
  final bgImage;
  final speechList;
  final route;
  final nextRoute;
  final Function? callback;
  final int? updatedNumber;
  final bgm;
  VNScreen({
    this.bgImage,
    this.speechList,
    this.route,
    this.nextRoute,
    this.callback,
    this.updatedNumber,
    this.bgm,
  });
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VNScreen> {
  var introFade = true;
  var switchFade = false;
  double? opacity = 0.0;
  double? opacityIntro = 1.0;
  String? notHome;
  SharedPreferences? sharedPreferences;

  // Function? callback;
  // int? updatedNumber;
  // _VNState({this.callback, this.updatedNumber});

  @override
  void didChangeDependencies() {
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      super.didChangeDependencies();
      GameAudioDesktop.playBGMDesktop.player = Player(
        id: 0,
      );
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    if (GlobalAudio.playAudio.isPlaying == false) {
      if (widget.bgm != null) {
        GlobalAudio.playAudio.getBGM(widget.bgm.toString());
      } else if (notHome != null) {
        GlobalAudio.playAudio.getBGM(notHome!);
      }
    } else {
      if (notHome != null) {
        GlobalAudio.playAudio.getBGM(notHome!);
      }
    }

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      notHome = sharedPreferences!.getString("notHome");
      try {
        if (widget.bgm.isNotEmpty) {
          notHome = widget.bgm.toString();
        }
      } catch (e) {
        print("EMPTY");
      }

      persistNotHome(notHome!);
      print(notHome);
    });
  }

  void persistNotHome(String value) {
    setState(() {
      notHome = value;
    });
    sharedPreferences?.setString("notHome", value);
  }

  void _incrementCounter() {
    setState(() {
      if (isFinished() == true) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushNamed(widget.nextRoute);
        });

        switchFade = true;
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            opacity = 1.0;
          });
        });
      } else {
        nextSpeech();
        if (widget.callback != null) {
          widget.callback!(getNumber());
        }
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (isFinished() == true) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushNamed(widget.nextRoute);
        });

        switchFade = true;
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            opacity = 1.0;
          });
        });
      } else {
        nextSpeech();
        if (widget.callback != null) {
          widget.callback!(getNumber());
        }
      }
    });
  }

  var isPressed;
  int textNumber = 0;
  void _playAudio() {
    GlobalAudio.playAudio.getVoice(getVoice().toString());
  }

  void nextSpeech() {
    if (textNumber < widget.speechList.length - 1) {
      textNumber++;
    }
  }

  String? getCharacterText() {
    return widget.speechList[textNumber].characterText;
  }

  String? getCT() {
    return widget.speechList[textNumber].cT;
  }

  String? getCharacterName() {
    return widget.speechList[textNumber].characterName;
  }

  String? getVoice() {
    if (widget.speechList != null) {
      return widget.speechList[textNumber].voice;
    }
  }

  bool? isFinished() {
    if (textNumber >= widget.speechList.length - 1) {
      GlobalAudio.playAudio.stopVoiceAudio();
      return true;
    } else {
      return false;
    }
  }

  getNumber() {
    return textNumber;
  }

  String? getMCImage() {
    return widget.speechList[textNumber].mcImage;
  }

  String? getCenterCharacterImage() {
    return widget.speechList[textNumber].centerCharacterImage;
  }

  String? getLeftCharacterImage() {
    return widget.speechList[textNumber].leftCharacterImage;
  }

  String? getRightCharacterImage() {
    return widget.speechList[textNumber].rightCharacterImage;
  }

  void reset() {
    textNumber = 0;
  }

  bool? hasAnimation() {
    return widget.speechList[textNumber].hasAnimation;
  }

  String? animationName() {
    return widget.speechList[textNumber].animationName;
  }

  @override
  Widget build(BuildContext context) {
    if (getVoice() != null && getVoice()!.isNotEmpty) {
      _playAudio();
    }

    return WillPopScope(
      onWillPop: () => getOnWillPop(),
      child: Builder(
        builder: (context) {
          if (widget.speechList == null || widget.speechList.isEmpty) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(
                  "Error!\nPlease ensure that you added the correct 'speechList'.",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return Builder(
              builder: (context) {
                if (this.mounted && introFade == true) {
                  Future.delayed(Duration(milliseconds: 1200), () {
                    setState(() {
                      introFade = false;
                    });
                  });
                  Future.delayed(Duration(milliseconds: 300), () {
                    setState(() {
                      opacityIntro = 0.0;
                    });
                  });
                  return Scaffold(
                    backgroundColor: Colors.black,
                    body: Stack(
                      children: [
                        BackgroundBuilder(
                          image: widget.bgImage,
                        ),
                        AnimatedOpacity(
                          opacity: opacityIntro!,
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  if (switchFade != false) {
                    return Scaffold(
                      backgroundColor: Colors.black,
                      body: Stack(
                        children: [
                          BackgroundBuilder(
                            image: widget.bgImage,
                          ),
                          AnimatedOpacity(
                            opacity: opacity!,
                            duration: Duration(milliseconds: 300),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return CounterShortcuts(
                      onIncrementDetected: _incrementCounter,
                      onDecrementDetected: _decrementCounter,
                      child: Scaffold(
                        resizeToAvoidBottomInset: false,
                        backgroundColor: Colors.black,
                        body: GestureDetector(
                          onLongPressStart: (_) async {
                            isPressed = true;
                            do {
                              setState(() {
                                if (isFinished() != true) {
                                  nextSpeech();
                                  if (widget.callback != null) {
                                    widget.callback!(getNumber());
                                  }
                                }
                              });
                              await Future.delayed(Duration(milliseconds: 100));
                            } while (isPressed);
                          },
                          onLongPressEnd: (_) =>
                              setState(() => isPressed = false),
                          onTap: () {
                            setState(() {
                              if (isFinished() == true) {
                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.of(context)
                                      .pushNamed(widget.nextRoute);
                                });

                                switchFade = true;
                                Future.delayed(Duration(milliseconds: 300), () {
                                  setState(() {
                                    opacity = 1.0;
                                  });
                                });
                              } else {
                                nextSpeech();
                                if (widget.callback != null) {
                                  widget.callback!(getNumber());
                                }
                              }
                            });
                          },
                          child: VNConstructor(
                            bgImage: widget.bgImage,
                            characterName: getCharacterName(),
                            characterText: getCharacterText(),
                            cT: getCT(),
                            n: getNumber(),
                            mcImage: getMCImage(),
                            centerCharacterImage: getCenterCharacterImage(),
                            leftCharacterImage: getLeftCharacterImage(),
                            rightCharacterImage: getRightCharacterImage(),
                            route: widget.route,
                            nextRoute: widget.nextRoute,
                            hasAnimation: hasAnimation(),
                            animationName: animationName(),
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            );
          }
        },
      ),
    );
  }
}
