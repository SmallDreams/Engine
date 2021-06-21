import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/vn_constructor.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:salem/core/audio/globalAudio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VNScaffold extends StatefulWidget {
  final bgImage;
  final textSound;
  final route;
  final nextRoute;
  final hasVoiceActing;
  final nameBuilder;
  final bgm;
  VNScaffold({
    required this.bgImage,
    required this.textSound,
    required this.route,
    required this.nextRoute,
    required this.hasVoiceActing,
    required this.nameBuilder,
    this.bgm,
  });
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VNScaffold> {
  SharedPreferences? sharedPreferences;
  String? getPersistBGM;
  @override
  void initState() {
    super.initState();

    GlobalAudio.playAudio.getAudio(widget.bgm);

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      getPersistBGM = sharedPreferences!.getString("getPersistBGM");
      getPersistBGM = widget.bgm;
      persistBGM(getPersistBGM!);
      print(getPersistBGM);
    });
  }

  void persistBGM(String value) {
    setState(() {
      getPersistBGM = value;
    });
    sharedPreferences?.setString("getPersistBGM", value);
  }

  @override
  void didChangeDependencies() {
    if (Platform.isWindows || Platform.isLinux) {
      super.didChangeDependencies();
      GameAudioDesktop.playDesktopAudio.player = Player(
        id: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => getOnWillPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: InkWell(
          onTap: () {
            setState(() {
              if (widget.textSound.isFinished() == true) {
                Navigator.of(context).pushNamed(widget.nextRoute);
                widget.textSound.reset();
              } else {
                widget.textSound.nextQuestion();
              }
            });
          },
          child: widget.hasVoiceActing
              ? VNConstructorTextSound(
                  bgImage: "assets/images/bgs/" + widget.bgImage,
                  characterName: widget.textSound.getCharacterName(),
                  characterText: widget.textSound.getCharacterText(),
                  initNumber: widget.textSound.getNumber(),
                  charImage: widget.textSound.getImage(),
                  route: widget.route,
                  nextRoute: widget.nextRoute,
                  nameBuilder: widget.nameBuilder,
                )
              // TODO: add voiceacting constructor
              : VNConstructorTextSound(
                  bgImage: "assets/images/bgs/" + widget.bgImage,
                  characterName: widget.textSound.getCharacterName(),
                  characterText: widget.textSound.getCharacterText(),
                  initNumber: widget.textSound.getNumber(),
                  charImage: widget.textSound.getImage(),
                  route: widget.route,
                  nextRoute: widget.nextRoute,
                  nameBuilder: widget.nameBuilder,
                ),
        ),
      ),
    );
  }

  getOnWillPop() {
    print("Not allowed.");
  }
}
