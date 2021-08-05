import 'package:audioplayers/audioplayers.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class VoiceAudio {
//   final musicName;
//   VoiceAudio({this.musicName});
//   static final getVoice = PlayVoice();
// }

// class PlayVoice with WidgetsBindingObserver {
//   bool isPlaying = false;

//   Future<void> play(String musicName) async {
//     isPlaying = true;
//     if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
//       if (GameAudioDesktop.playAudio.isPlaying == false) {
//         GameAudioDesktop.playAudio.play(musicName);
//       } else {
//         GameAudioDesktop.playAudio.stop();
//         GameAudioDesktop.playAudio.play(musicName);
//       }
//     } else {
//       if (GameAudio.isPlaying == false) {
//         VoiceAudio.play(musicName);
//       } else {
//         GameAudio.stop();
//         GameAudio.play(musicName);
//       }
//     }
//   }
// }

class VoiceAudio {
  /// Access a shared instance of the [AudioCache] class.
  static AudioCache audioCache = AudioCache(prefix: 'assets/audio/');
  static late final PlayVoice playVoice = PlayVoice(audioCache: audioCache);
}

class PlayVoice extends WidgetsBindingObserver {
  bool _isRegistered = false;
  late AudioCache audioCache;
  AudioPlayer? audioPlayer;
  bool isPlaying = false;

  PlayVoice({AudioCache? audioCache}) : audioCache = audioCache ?? AudioCache();

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
    //AudioService service = Provider.of<AudioService>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('voiceValue');

    final currentPlayer = audioPlayer;
    if (currentPlayer != null && currentPlayer.state != PlayerState.STOPPED) {
      currentPlayer.stop();
    }

    if (isPlaying == false) {
      isPlaying = true;

      audioPlayer =
          await audioCache.play(filename + ".mp3", volume: vol ?? 1.0);
    } else {
      currentPlayer?.stop();

      audioPlayer =
          await audioCache.play(filename + ".mp3", volume: vol ?? 1.0);
    }
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    if (audioPlayer != null) {
      await audioPlayer!.stop();
    }
  }

  /// Resumes the currently played (but resumed) background music.
  Future<void> resume() async {
    if (audioPlayer != null) {
      isPlaying = true;
      await audioPlayer!.resume();
    }
  }

  /// Pauses the background music without unloading or resetting the audio
  /// player.
  Future<void> pause() async {
    if (audioPlayer != null) {
      isPlaying = false;
      await audioPlayer!.pause();
    }
  }

  Future<void> volume(volume) async {
    await audioPlayer!.setVolume(volume);
  }

  /// Pre-fetch an audio and store it in the cache.
  ///
  /// Alias of `audioCache.load();`.
  Future<Uri> load(String file) => audioCache.load(file);

  /// Pre-fetch an audio and store it in the cache.
  ///
  /// Alias of `audioCache.loadAsFile();`.

  /// Pre-fetch a list of audios and store them in the cache.
  ///
  /// Alias of `audioCache.loadAll();`.
  Future<List<Uri>> loadAll(List<String> files) => audioCache.loadAll(files);

  /// Clears the file in the cache.
  ///
  /// Alias of `audioCache.clear();`.
  void clear(Uri file) => audioCache.clear(file);

  /// Clears all the audios in the cache.
  ///
  /// Alias of `audioCache.clearAll();`.
  void clearAll() => audioCache.clearAll();

  /// Handler for AppLifecycleState changes.
  ///
  /// This function handles the automatic pause and resume when the app
  /// lifecycle state changes. There is NO NEED to call this function directly
  /// directly.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (isPlaying && audioPlayer?.state == PlayerState.PAUSED) {
        audioPlayer?.resume();
      }
    } else {
      audioPlayer?.pause();
    }
  }
}

class VoiceAudioDesktop {
  /// Access a shared instance of the [AudioCache] class.
  static late final PlayVoiceDesktop playVoiceDesktop = PlayVoiceDesktop();
}

class PlayVoiceDesktop extends WidgetsBindingObserver {
  bool _isRegistered = false;
  bool isPlaying = false;
  Player player = Player(id: 1);

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
    //AudioService service = Provider.of<AudioService>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('voiceValue');

    final currentPlayer = player;

    if (isPlaying == false) {
      isPlaying = true;

      player.open(
        Playlist(
          playlistMode: PlaylistMode.single,
          medias: [
            Media.asset('assets/audio/' + filename + ".mp3"),
          ],
        ),
      );
      player.setVolume(vol ?? 1.0);
    } else {
      currentPlayer.stop();

      player.open(
        Playlist(
          playlistMode: PlaylistMode.single,
          medias: [
            Media.asset('assets/audio/' + filename + ".mp3"),
          ],
        ),
      );
      player.setVolume(vol ?? 1.0);
    }
  }

  /// Stops the currently playing background music track (if any).
  Future<void> stop() async {
    isPlaying = false;
    if (player != null) {
      player.stop();
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
      player.pause();
    }
  }

  Future<void> volume(volume) async {
    player.setVolume(volume);
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
