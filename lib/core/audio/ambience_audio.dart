import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AmbienceAudio {
  static late final Ambience playAmbience = Ambience();
}

class Ambience extends WidgetsBindingObserver {
  bool _isRegistered = false;
  final audioPlayerAmbience = AudioPlayer();
  bool isPlaying = false;

  /// Registers a [WidgetsBinding] observer.
  ///
  /// This must be called for auto-pause and resume to work properly.
  void initialize() {
    if (_isRegistered) {
      return;
    }
    _isRegistered = true;
    WidgetsBinding.instance?.addObserver(this);
  }

  /// Dispose the [WidgetsBinding] observer.
  void dispose() {
    if (!_isRegistered) {
      return;
    }
    audioPlayerAmbience.dispose();
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
    double? vol = prefs.getDouble('sfxValue') ?? 1.0;

    await audioPlayerAmbience.setVolume(vol).then((value) async =>
        await audioPlayerAmbience
            .setAsset("assets/audio/ambience/" + filename + ".mp3",
                preload: true)
            .then((value) async => await audioPlayerAmbience
                .setLoopMode(LoopMode.one)
                .then((value) async => await audioPlayerAmbience.play())));
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    await audioPlayerAmbience.stop();
  }

  /// Resumes the currently played (but resumed) background music.
  Future<void> resume() async {
    isPlaying = true;
    await audioPlayerAmbience.play();
  }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    isPlaying = false;
    await audioPlayerAmbience.pause();
  }

  Future<void> volume(volume) async {
    await audioPlayerAmbience.setVolume(volume);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isPlaying &&
          audioPlayerAmbience.playerState ==
              audioPlayerAmbience.playerState.playing) {
        audioPlayerAmbience.play();
      }
    } else {
      audioPlayerAmbience.pause();
    }
  }
}
