import 'package:flutter/material.dart';
import 'package:salem/core/audio/game_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class BGMVolume extends StatefulWidget {
  const BGMVolume({Key? key}) : super(key: key);

  @override
  _TextSpeedState createState() => _TextSpeedState();
}

class _TextSpeedState extends State<BGMVolume> {
  @override
  void initState() {
    super.initState();
    getVolume();
  }

  double? bgmVol = 1.0;
  getVolume() async {
    bgmVol = await getVolumeState();
    setState(() {});
  }

  saveVolumeState(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('bgmValue', value);
  }

  getVolumeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? bgmVol = prefs.getDouble('bgmValue');

    return bgmVol!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).cardColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
            "BGM Volume",
            style: TextStyle(fontSize: 18, fontFamily: "Arvo"),
          ),
        ),
      ),
      Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: <Widget>[
            bgmVol == 0
                ? const Icon(
                    Icons.music_off,
                    size: 35,
                  )
                : const Icon(
                    Icons.music_note,
                    size: 35,
                  ),
            const SizedBox(width: 15),
            Flexible(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Theme.of(context).colorScheme.secondary,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 0.0),
                ),
                child: Slider(
                  min: 0.0,
                  max: 1.0,
                  value: bgmVol ?? 1.0,
                  onChanged: (volume) {
                    setState(() {
                      if (UniversalPlatform.isWindows ||
                          UniversalPlatform.isLinux) {
                        GameAudioDesktop.playBGMDesktop.player
                            .setVolume(volume);
                      } else {
                        GameAudio.playBGM.audioPlayer!.setVolume(volume);
                        if (bgmVol == 0) {
                          GameAudio.playBGM.pause();
                        } else {
                          GameAudio.playBGM.resume();
                        }
                      }
                      bgmVol = volume;
                      saveVolumeState(volume);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
