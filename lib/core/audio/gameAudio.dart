import 'package:audioplayers/audioplayers.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/core/audio/bgm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class GameAudio {
  /// Access a shared instance of the [AudioCache] class.
  static AudioCache audioCache = AudioCache(prefix: 'assets/audio/');

  /// Plays a single run of the given [file], with a given [volume].
  static Future<AudioPlayer> play(String file, {double volume = 1.0}) {
    return audioCache.play(file, volume: volume, mode: PlayerMode.LOW_LATENCY);
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
  static late final Bgm bgm = Bgm(audioCache: audioCache);
}

class GameAudioDesktop {
  static late final PlayAudio playAudio = PlayAudio();
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
    if (UniversalPlatform.isLinux) {
      await player?.open(
        new Playlist(
          playlistMode: PlaylistMode.loop,
          medias: [
            await Media.network(
                'https://edenhost.de/gameAudio/fablesofdesire/' +
                    filename +
                    ".mp3"),
          ],
        ),
      );
    } else {
      await player?.open(
        new Playlist(
          playlistMode: PlaylistMode.loop,
          medias: [
            await Media.asset('assets/audio/' + filename + ".mp3"),
          ],
        ),
      );
    }
    await player?.setVolume(vol ?? 1.0);
    isPlaying = true;
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    if (player != null) {
      await player?.stop();
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
      await player?.pause();
    }
  }

  Future<void> volume(volume) async {
    await player?.setVolume(volume);
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
