import 'package:flutter/material.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class GlobalAudio {
  final musicName;
  GlobalAudio({this.musicName});
  static final playAudio = PlayAudio();
}

class PlayAudio with WidgetsBindingObserver {
  String? notHome;
  SharedPreferences? sharedPreferences;
  bool isPlaying = false;

  Future<void> getBGM(String musicName) async {
    isPlaying = true;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      if (GameAudioDesktop.playAudio.isPlaying == false) {
        GameAudioDesktop.playAudio.play(musicName);
      } else {
        GameAudioDesktop.playAudio.stop();
        GameAudioDesktop.playAudio.play(musicName);
      }
    } else {
      if (GameAudio.bgm.isPlaying == false) {
        GameAudio.bgm.play(musicName);
      } else {
        GameAudio.bgm.stop();
        GameAudio.bgm.play(musicName);
      }
    }
  }

  Future<void> stopAudio() async {
    //isPlaying = false;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      GameAudioDesktop.playAudio.stop();
    } else {
      GameAudio.bgm.stop();
    }
  }

  // @override
  // void didChangeDependencies() {
  //   if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
  //     super.didChangeDependencies();
  //     GameAudioDesktop.playAudio.player = Player(
  //       id: 0,
  //     );
  //   }
  // }
}
