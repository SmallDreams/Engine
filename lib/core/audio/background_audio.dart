import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The looping background music class.
///
/// This class helps with looping background music management that reacts to
/// application lifecycle state changes. On construction, the instance is added
/// as an observer to the [WidgetsBinding] instance. A [dispose] function is
/// provided in case this functionality needs to be unloaded but the app needs
/// to keep running.
class Bgm extends WidgetsBindingObserver {
  bool _isRegistered = false;
  bool isPlaying = false;
  final audioPlayerBGM = AudioPlayer();

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
    double vol = prefs.getDouble('bgmValue') ?? 1.0;

    isPlaying = true;
    await audioPlayerBGM.setVolume(vol).then((value) async => audioPlayerBGM
        .setAsset("assets/audio/" + filename + ".mp3", preload: true)
        .then((value) async => await audioPlayerBGM.setLoopMode(LoopMode.one))
        .then((value) async => await audioPlayerBGM.play()));
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    await audioPlayerBGM.stop();
  }

  /// Resumes the currently played (but resumed) background music.
  Future<void> resume() async {
    isPlaying = true;
    await audioPlayerBGM.play();
  }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    isPlaying = false;
    await audioPlayerBGM.pause();
  }

  Future<void> volume(volume) async {
    await audioPlayerBGM.setVolume(volume);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isPlaying &&
          audioPlayerBGM.playerState == audioPlayerBGM.playerState.playing) {
        audioPlayerBGM.play();
      }
    } else {
      audioPlayerBGM.pause();
    }
  }
}
