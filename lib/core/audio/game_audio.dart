import 'package:salem/core/audio/background_audio.dart';

class GameAudio {
  static late final Bgm playBGM = Bgm();
}

// class GameAudioDesktop {
//   static late final PlayAudio playBGMDesktop = PlayAudio();
// }

// class PlayAudio extends WidgetsBindingObserver {
//   Player player = Player(id: 0);
//   bool isPlaying = false;

//   /// Plays and loops a background music file specified by [filename].
//   ///
//   /// The volume can be specified in the optional named parameter [volume]
//   /// where `0` means off and `1` means max.
//   ///
//   /// It is safe to call this function even when a current BGM track is
//   /// playing.
//   Future<void> play(String filename, {double volume = 1.0}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     double? vol = prefs.getDouble('bgmValue');

//     player.open(
//       Playlist(
//         playlistMode: PlaylistMode.loop,
//         medias: [
//           Media.asset('assets/audio/' + filename + ".mp3"),
//         ],
//       ),
//     );
//     player.setVolume(vol ?? 1.0);
//     isPlaying = true;
//   }

//   /// Stops the currently playing background music track (if any).
//   Future<void> stop() async {
//     isPlaying = false;
//     player.stop();
//   }

//   /// Resumes the currently played (but resumed) background music.
//   // Future<void> resume() async {
//   //   if (audioPlayer != null) {
//   //     isPlaying = true;
//   //     await audioPlayer!.resume();
//   //   }
//   // }

//   /// Pauses the background music without unloading or resetting the audio
//   /// player.
//   Future<void> pause() async {
//     if (player != null) {
//       isPlaying = false;
//       player.pause();
//     }
//   }

//   Future<void> volume(volume) async {
//     player.setVolume(volume);
//   }

//   // @override
//   // void didChangeAppLifecycleState(AppLifecycleState state) {
//   //   if (state == AppLifecycleState.resumed) {
//   //     if (isPlaying && player?.state == PlayerState.PAUSED) {
//   //       audioPlayer?.resume();
//   //     }
//   //   } else {
//   //     audioPlayer?.pause();
//   //   }
//   // }
// }