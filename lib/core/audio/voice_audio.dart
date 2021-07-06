import 'package:flutter/material.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:universal_platform/universal_platform.dart';

class VoiceAudio {
  final musicName;
  VoiceAudio({this.musicName});
  static final getVoice = PlayVoice();
}

class PlayVoice with WidgetsBindingObserver {
  bool isPlaying = false;

  Future<void> play(String musicName) async {
    isPlaying = true;
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      if (GameAudioDesktop.playAudio.isPlaying == false) {
        GameAudioDesktop.playAudio.play(musicName);
      } else {
        GameAudioDesktop.playAudio.stop();
        GameAudioDesktop.playAudio.play(musicName);
      }
    } else {
      if (GameAudio.isPlaying == false) {
        GameAudio.play(musicName);
      } else {
        GameAudio.stop();
        GameAudio.play(musicName);
      }
    }
  }
}
