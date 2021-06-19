import 'package:audioplayers/audioplayers.dart';
import 'package:salem/core/audio/bgm.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<AudioPlayer> playBubble(String file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? bubbleValue = prefs.getDouble('bubbleValue');
    return audioCache.play(file,
        volume: bubbleValue ?? 1.0, mode: PlayerMode.LOW_LATENCY);
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
  static late final Bgm playAudio = Bgm(audioCache: audioCache);
}

class GameAudioDesktop {
  static late final PlayDesktopAudio playDesktopAudio = PlayDesktopAudio();
}
