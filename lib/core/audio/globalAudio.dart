import 'dart:io';

import 'package:flutter/material.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalAudio {
  final musicName;
  GlobalAudio({this.musicName});
  static final playAudio = PlayAudio();
}

class PlayAudio with WidgetsBindingObserver {
  String? notHome;
  SharedPreferences? sharedPreferences;

  Future<void> persistNotHome(String value) async {
    notHome = value;
    sharedPreferences?.setString("notHome", value);
  }

  Future<void> getAudio(String musicName) async {
    if (Platform.isWindows || Platform.isLinux) {
      if (GameAudioDesktop.playDesktopAudio.isPlaying == false) {
        GameAudioDesktop.playDesktopAudio.play(musicName);
      } else {
        GameAudioDesktop.playDesktopAudio.stop();
        GameAudioDesktop.playDesktopAudio.play(musicName);
      }
    } else {
      if (GameAudio.playAudio.isPlaying == false) {
        GameAudio.playAudio.play(musicName);
      } else {
        GameAudio.playAudio.stop();
        GameAudio.playAudio.play(musicName);
      }
    }
  }

  // @override
  // void didChangeDependencies() {
  //   if (Platform.isWindows || Platform.isLinux) {
  //     super.didChangeDependencies();
  //     GameAudioDesktop.playAudio.player = Player(
  //       id: 0,
  //     );
  //   }
  // }
}
