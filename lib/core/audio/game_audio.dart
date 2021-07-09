import 'package:audioplayers/audioplayers.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/core/audio/background_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameAudio {
  static bool isPlaying = false;
  static AudioPlayer? audioPlayer;

  /// Access a shared instance of the [AudioCache] class.
  static AudioCache audioCache = AudioCache(prefix: 'assets/audio/');

  /// Plays a single run of the given [file], with a given [volume].
  static Future<AudioPlayer> play(String file, {double volume = 1.0}) {
    return audioCache.play(file + ".mp3",
        volume: volume, mode: PlayerMode.LOW_LATENCY);
  }

  static Future<void> stop() async {
    isPlaying = false;
    if (audioPlayer != null) {
      await audioPlayer!.stop();
    }
  }

  /// Plays, and keep looping the given [file]
  static Future<AudioPlayer> loop(String file, {double volume = 1.0}) {
    return audioCache.loop(file, volume: volume, mode: PlayerMode.LOW_LATENCY);
  }

  /// Plays a single run of the given file [file]
  /// This method supports long audio files
  static Future<AudioPlayer> playLongAudio(String file, {double volume = 1.0}) {
    return audioCache.play(file, volume: volume);
  }

  /// Plays, and keep looping the given [file]
  /// This method supports long audio files
  ///
  /// NOTE: Length audio files on Android have an audio gap between loop
  /// iterations, this happens due to limitations on Android's native media
  /// player features, if you need a gapless loop, prefer the loop method
  static Future<AudioPlayer> loopLongAudio(String file, {double volume = 1.0}) {
    return audioCache.loop(file, volume: volume);
  }

  /// Access a shared instance of the [Bgm] class.
  ///
  /// This will use the same global audio cache from [FlameAudio].
  static late final Bgm playBGM = Bgm(audioCache: audioCache);
}

class GameAudioDesktop {
  static late final PlayAudio playBGMDesktop = PlayAudio();
}

class PlayAudio extends WidgetsBindingObserver {
  Player? player;
  bool isPlaying = false;

  /// Plays and loops a background music file specified by [filename].
  ///
  /// The volume can be specified in the optional named parameter [volume]
  /// where `0` means off and `1` means max.
  ///
  /// It is safe to call this function even when a current BGM track is
  /// playing.
  Future<void> play(String filename, {double volume = 1.0}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('volValue');

    player?.open(
      new Playlist(
        playlistMode: PlaylistMode.loop,
        medias: [
          Media.asset('assets/audio/' + filename + ".mp3"),
        ],
      ),
    );
    player?.setVolume(vol ?? 1.0);
    isPlaying = true;
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    if (player != null) {
      player?.stop();
    }
  }

  /// Resumes the currently played (but resumed) background music.
  // Future<void> resume() async {
  //   if (audioPlayer != null) {
  //     isPlaying = true;
  //     await audioPlayer!.resume();
  //   }
  // }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    if (player != null) {
      isPlaying = false;
      player?.pause();
    }
  }

  Future<void> volume(volume) async {
    player?.setVolume(volume);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     if (isPlaying && player?.state == PlayerState.PAUSED) {
  //       audioPlayer?.resume();
  //     }
  //   } else {
  //     audioPlayer?.pause();
  //   }
  // }
}
