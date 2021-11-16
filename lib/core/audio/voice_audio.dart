import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoiceAudio {
  static late final PlayVoice playVoice = PlayVoice();
}

class PlayVoice extends WidgetsBindingObserver {
  bool _isRegistered = false;

  final audioPlayerVoice = AudioPlayer();
  bool isPlaying = false;

  void initialize() {
    if (_isRegistered) {
      return;
    }
    audioPlayerVoice.play();
    _isRegistered = true;
    WidgetsBinding.instance?.addObserver(this);
  }

  /// Dispose the [WidgetsBinding] observer.
  void dispose() {
    if (!_isRegistered) {
      return;
    }
    WidgetsBinding.instance?.removeObserver(this);
    _isRegistered = false;
  }

  /// Plays and loops a background music file specified by [filename].
  ///
  /// The volume can be specified in the optional named parameter [volume]
  /// where `0` means off and `1` means max.
  ///
  /// It is safe to call this function even when a current BGM track is
  /// playing.
  Future<void> play(String filename, {double volume = 1.0}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('voiceValue');

    final currentPlayer = audioPlayerVoice;
    if (!currentPlayer.playing) {
      await currentPlayer.stop();
    }

    await currentPlayer.setVolume(vol ?? 1.0);
    await currentPlayer.setAsset("assets/audio/" + filename + ".mp3");
    await currentPlayer.play();
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    await audioPlayerVoice.stop();
  }

  /// Resumes the currently played (but resumed) background music.
  Future<void> resume() async {
    isPlaying = true;
    await audioPlayerVoice.play();
  }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    isPlaying = false;
    await audioPlayerVoice.pause();
  }

  Future<void> volume(volume) async {
    await audioPlayerVoice.setVolume(volume);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isPlaying &&
          audioPlayerVoice.playerState == audioPlayerVoice.playing) {
        audioPlayerVoice.play();
      }
    } else {
      audioPlayerVoice.pause();
    }
  }
}
