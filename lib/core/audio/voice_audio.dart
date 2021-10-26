import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoiceAudio {
  static late final PlayVoice playVoice = PlayVoice();
}

class PlayVoice extends WidgetsBindingObserver {
  bool _isRegistered = false;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;

  void initialize() {
    if (_isRegistered) {
      return;
    }
    audioPlayer.play();
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

    final currentPlayer = audioPlayer;
    if (!currentPlayer.playing) {
      await currentPlayer.stop();
    }

    if (isPlaying == false) {
      isPlaying = true;
      await currentPlayer.setVolume(vol ?? 1.0);
      await currentPlayer.setAsset(filename + ".mp3");
    } else {
      await currentPlayer.stop();
      await currentPlayer.setVolume(vol ?? 1.0);
      await currentPlayer.setAsset(filename + ".mp3");
    }
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    await audioPlayer.stop();
  }

  /// Resumes the currently played (but resumed) background music.
  Future<void> resume() async {
    isPlaying = true;
    await audioPlayer.play();
  }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    isPlaying = false;
    await audioPlayer.pause();
  }

  Future<void> volume(volume) async {
    await audioPlayer.setVolume(volume);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isPlaying && audioPlayer.playerState == audioPlayer.playing) {
        audioPlayer.play();
      }
    } else {
      audioPlayer.pause();
    }
  }
}
