import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/global/logicalKeyboard.dart';
import 'package:salem/components/global/onWillPop.dart';
import 'package:salem/components/visualnovel/UI/background_builder.dart';
import 'package:salem/components/visualnovel/vn_constructor.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:salem/core/audio/globalAudio.dart';
import 'package:salem/core/audio/voice_audio.dart';
import 'dart:async';
import 'package:universal_platform/universal_platform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VNScaffold extends StatefulWidget {
  final bgImage;
  final textSound;
  final route;
  final nextRoute;
  final Function? callback;
  final int? updatedNumber;
  final bgm;
  VNScaffold({
    this.bgImage,
    this.textSound,
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
    if (UniversalPlatform.isWindows ||
        UniversalPlatform.isLinux &&
            GameAudioDesktop.playAudio.isPlaying == false) {
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
    print(notHome!);
    if (GlobalAudio.playAudio.isPlaying == false) {
      try {
        if (widget.bgm.isNotEmpty) {
          GlobalAudio.playAudio.getBGM(widget.bgm.toString());
        }
      } catch (e) {
        //GlobalAudio.playAudio.getBGM(notHome ?? "");
      }
    } else {
      try {
        if (widget.bgm.isNotEmpty) {
          GlobalAudio.playAudio.stopAudio();
          GlobalAudio.playAudio.getBGM(widget.bgm.toString());
        } else {
          GlobalAudio.playAudio.getBGM(notHome!);
        }
      } catch (e) {
        //GlobalAudio.playAudio.getBGM(notHome ?? "");
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
      if (widget.textSound.isFinished() == true) {
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
        widget.textSound.nextQuestion();
        if (widget.callback != null) {
          widget.callback!(widget.textSound.getNumber());
        }
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (widget.textSound.isFinished() == true) {
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
        widget.textSound.nextQuestion();
        if (widget.callback != null) {
          widget.callback!(widget.textSound.getNumber());
        }
      }
    });
  }

  var isPressed;

  void _playAudio() {
    VoiceAudio.playVoice.play(widget.textSound.getVoice().toString());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.textSound.getVoice() != null &&
        widget.textSound.getVoice().isNotEmpty) {
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
                        //print('long pressing');
                        setState(() {
                          if (widget.textSound.isFinished() != true) {
                            widget.textSound.nextQuestion();
                            if (widget.callback != null) {
                              widget.callback!(widget.textSound.getNumber());
                            }
                          }
                        });
                        await Future.delayed(Duration(milliseconds: 100));
                      } while (isPressed);
                    },
                    onLongPressEnd: (_) => setState(() => isPressed = false),
                    onTap: () {
                      setState(() {
                        if (widget.textSound.isFinished() == true) {
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
                          widget.textSound.nextQuestion();
                          if (widget.callback != null) {
                            widget.callback!(widget.textSound.getNumber());
                          }
                        }
                      });
                    },
                    child: VNConstructor(
                      bgImage: widget.bgImage,
                      characterName: widget.textSound.getCharacterName(),
                      characterText: widget.textSound.getCharacterText(),
                      n: widget.textSound.getNumber(),
                      mcImage: widget.textSound.getMCImage(),
                      sideCharImage: widget.textSound.getSideCharImage(),
                      route: widget.route,
                      nextRoute: widget.nextRoute,
                      nextText: widget.textSound,
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
