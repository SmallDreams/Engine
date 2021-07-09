import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/global/logicalKeyboard.dart';
import 'package:salem/components/global/onWillPop.dart';
import 'package:salem/components/visualnovel/UserInterface/background_builder.dart';
import 'package:salem/components/visualnovel/vn_constructor.dart';
import 'package:salem/core/audio/game_audio.dart';
import 'package:salem/core/audio/global_audio.dart';
import 'dart:async';
import 'package:universal_platform/universal_platform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VNScaffold extends StatefulWidget {
  final bgImage;
  final speechList;
  final route;
  final nextRoute;
  final Function? callback;
  final int? updatedNumber;
  final bgm;
  VNScaffold({
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

class _VNState extends State<VNScaffold> {
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
      GameAudioDesktop.playAudio.player = Player(
        id: 0,
      );
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    if (GlobalAudio.playAudio.isPlaying == false) {
      if (widget.bgm.isNotEmpty) {
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

  String? getCharacterName() {
    return widget.speechList[textNumber].characterName;
  }

  String? getVoice() {
    return widget.speechList[textNumber].voice;
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

  String? getSideCharImage() {
    return widget.speechList[textNumber].sideCharImage;
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
                    onLongPressEnd: (_) => setState(() => isPressed = false),
                    onTap: () {
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
                    },
                    child: VNConstructor(
                      bgImage: widget.bgImage,
                      characterName: getCharacterName(),
                      characterText: getCharacterText(),
                      n: getNumber(),
                      mcImage: getMCImage(),
                      sideCharImage: getSideCharImage(),
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
      ),
    );
  }
}
