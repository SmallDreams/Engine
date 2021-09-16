import 'package:flutter/material.dart';
import 'package:salem/core/audio/ambience_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class SFXVolume extends StatefulWidget {
  const SFXVolume({Key? key}) : super(key: key);

  @override
  _SFXVolumeState createState() => _SFXVolumeState();
}

class _SFXVolumeState extends State<SFXVolume> {
  @override
  void initState() {
    super.initState();
    getVolume();
  }

  double? vol = 1.0;
  getVolume() async {
    vol = await getVolumeState();
    setState(() {});
  }

  saveVolumeState(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('sfxValue', value);
  }

  getVolumeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('sfxValue');

    return vol!;
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
            "SFX Volume",
            style: TextStyle(fontSize: 18, fontFamily: "Nasa"),
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
            vol == 0
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
                  value: vol ?? 1.0,
                  onChanged: (volume) {
                    setState(() {
                      if (UniversalPlatform.isWindows ||
                          UniversalPlatform.isLinux) {
                        //  AmbienceAudioDesktop.playBGMDesktop.volume(volume);
                      } else {
                        AmbienceAudio.playAmbience.audioPlayer!
                            .setVolume(volume);
                        if (vol == 0) {
                          AmbienceAudio.pause();
                        } else {
                          AmbienceAudio.resume();
                        }
                      }
                      vol = volume;
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
