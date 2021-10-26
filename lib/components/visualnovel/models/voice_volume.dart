import 'package:flutter/material.dart';
import 'package:salem/core/audio/voice_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class VoiceVolume extends StatefulWidget {
  const VoiceVolume({Key? key}) : super(key: key);

  @override
  _TextSpeedState createState() => _TextSpeedState();
}

class _TextSpeedState extends State<VoiceVolume> {
  @override
  void initState() {
    super.initState();
    getVolume();
  }

  double? voiceVol = 1.0;
  getVolume() async {
    voiceVol = await getVolumeState();
    setState(() {});
  }

  saveVolumeState(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('voiceValue', value);
  }

  getVolumeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? voiceVol = prefs.getDouble('voiceValue');

    return voiceVol!;
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
            "Voice Volume",
            style: TextStyle(fontFamily: "Nasa", fontSize: 18),
          ),
        ),
      ),
      Container(
        height: 55,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: <Widget>[
            voiceVol == 0
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
                  value: voiceVol ?? 1.0,
                  onChanged: (volume) {
                    setState(() {
                      if (UniversalPlatform.isWindows ||
                          UniversalPlatform.isLinux) {
                        // VoiceAudioDesktop.playVoiceDesktop.player
                        //     .setVolume(volume);
                      } else {
                        VoiceAudio.playVoice.audioPlayer.setVolume(volume);
                        if (voiceVol == 0) {
                          VoiceAudio.playVoice.pause();
                        } else {
                          VoiceAudio.playVoice.resume();
                        }
                      }

                      voiceVol = volume;
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
