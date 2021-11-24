import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salem/components/global/onWillPop.dart';
import 'package:salem/components/visualnovel/models/text_animation.dart';
import 'package:salem/components/visualnovel/user_interface/background_builder.dart';
import 'package:salem/core/audio/global_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

class VNScreen extends StatefulWidget {
  final bgImage;
  final speechList;
  final String? route;
  final String? nextRoute;
  final Function? callback;
  final int? updatedNumber;
  final bgm;
  final String? vnFont;
  final String? vnNameFont;
  VNScreen({
    Key? key,
    this.bgImage,
    this.speechList,
    this.route,
    this.nextRoute,
    this.callback,
    this.updatedNumber,
    this.bgm,
    this.vnFont,
    this.vnNameFont,
  }) : super(key: key);
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VNScreen> {
  final buttonPlayer = AudioPlayer();
  var introFade = true;
  var switchFade = false;
  double? opacity = 0.0;
  double? opacityIntro = 1.0;
  String? notHome;
  SharedPreferences? sharedPreferences;

  // Function? callback;
  // int? updatedNumber;
  // _VNState({this.callback, this.updatedNumber});

  // @override
  // void didChangeDependencies() {
  //   if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
  //     super.didChangeDependencies();
  //     GameAudioDesktop.playBGMDesktop.player = Player(
  //       id: 0,
  //     );
  //   }
  //   super.didChangeDependencies();
  // }

  bool? isNoti = true;
  int? speed = 25;

  // final getChildData = AnimatedTextKit(
  //   animatedTexts: [],
  // ).onTap!();

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
  void initState() {
    super.initState();
    getSpeed();
    if (widget.bgm != notHome) {
      GlobalAudio.playAudio.getBGM(widget.bgm.toString());
    } else {
      if (notHome != null) {
        GlobalAudio.playAudio.getBGM(notHome!);
      }
    }

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
    if (widget.bgm.isNotEmpty) {
      SharedPreferences.getInstance().then((SharedPreferences sp) {
        sharedPreferences = sp;
        notHome = sharedPreferences!.getString("notHome");
        notHome = widget.bgm.toString();
        persistNotHome(notHome!);
      });
    }
  }

  void persistNotHome(String value) {
    setState(() {
      notHome = value;
    });
    sharedPreferences?.setString("notHome", value);
  }

  var isPressed;
  int textNumber = 0;
  void _playAudio() {
    if (getVoice()!.contains("connor")) {
      GlobalAudio.playAudio
          .getVoice("voices/speech/en/connor/" + getVoice().toString());
    } else {
      GlobalAudio.playAudio
          .getVoice("voices/speech/en/" + getVoice().toString());
    }
  }

  Function? nextSpeech() {
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
      GlobalAudio.playAudio.stopAmbienceAudio();
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
    getSpeed();
    int size = widget.speechList.length;
    return WillPopScope(
      onWillPop: () => getOnWillPop(),
      child: Stack(
        children: [
          BackgroundBuilder(image: widget.bgImage),
          Builder(
            builder: (context) {
              if (mounted && introFade == true) {
                Future.delayed(const Duration(milliseconds: 1200), () {
                  setState(() {
                    introFade = false;
                  });
                });
                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() {
                    opacityIntro = 0.0;
                  });
                });
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Stack(
                    children: [
                      // BackgroundBuilder(
                      //   image: widget.bgImage,
                      // ),
                      AnimatedOpacity(
                        opacity: opacityIntro!,
                        duration: const Duration(milliseconds: 300),
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
                        // BackgroundBuilder(
                        //   image: widget.bgImage,
                        // ),
                        AnimatedOpacity(
                          opacity: opacity!,
                          duration: const Duration(milliseconds: 300),
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
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () async {
                              Navigator.of(context).pushNamed("/settings");

                              await buttonPlayer
                                  .setAsset("assets/audio/button_click.mp3")
                                  .then((value) async =>
                                      await buttonPlayer.play());
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              child: Icon(
                                LineIcons.cog,
                                size: 32.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    body: SalemVisualNovelConstructor(
                      // callback: getCallback(),
                      // nextSpeech: widget.nextSpeech,
                      animatedTexts: [
                        TyperAnimatedText(
                          getCharacterText() ?? " ·  ·  · ",
                          textAlign: TextAlign.left,
                          textStyle: GoogleFonts.varelaRound(
                              //  shadows: <Shadow>[
                              //   Shadow(
                              //     offset:
                              //         Offset(1, 2),
                              //     blurRadius: 0,
                              //     color:
                              //         Colors.black,
                              //   ),
                              //   Shadow(
                              //     offset: Offset(
                              //         2.0, 1.1),
                              //     blurRadius: 0,
                              //     color:
                              //         Colors.black,
                              //   ),
                              // ],
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                              letterSpacing: 1.5),
                          speed: Duration(milliseconds: speed ?? 15),
                        ),
                      ],
                      displayFullTextOnTap: true,

                      onTap: () {
                        if (textNumber >= size - 1) {
                          GlobalAudio.playAudio.stopAmbienceAudio();

                          Future.delayed(const Duration(milliseconds: 1450),
                              () {
                            Navigator.of(context).pushNamed(widget.nextRoute!);
                          });

                          switchFade = true;
                          Future.delayed(const Duration(milliseconds: 300), () {
                            setState(() {
                              opacity = 1.0;
                            });
                          });
                        } else {
                          nextSpeech();
                          if (getVoice() != null && getVoice()!.isNotEmpty) {
                            _playAudio();
                          }
                          GlobalAudio.playAudio.stopVoiceAudio();
                          if (widget.callback != null) {
                            widget.callback!(getNumber());
                          }
                        }
                      },
                      isRepeatingAnimation: false,
                      key: ValueKey(
                        getNumber(),
                      ),

                      bgImage: widget.bgImage,
                      characterName: getCharacterName(),

                      cT: getCT(),

                      mcImage: getMCImage(),
                      centerCharacterImage: getCenterCharacterImage(),
                      leftCharacterImage: getLeftCharacterImage(),
                      rightCharacterImage: getRightCharacterImage(),
                      route: widget.route,
                      nextRoute: widget.nextRoute,
                      hasAnimation: hasAnimation(),
                      animationName: animationName(),
                      vnFont: widget.vnFont,
                      vnNameFont: widget.vnNameFont,
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
