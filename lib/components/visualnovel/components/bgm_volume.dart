import 'package:flutter/material.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class BGMVolume extends StatefulWidget {
  @override
  _TextSpeedState createState() => new _TextSpeedState();
}

class _TextSpeedState extends State<BGMVolume> {
  @override
  void initState() {
    super.initState();
    getVolume();
  }

  double? vol = 0.5;
  getVolume() async {
    vol = await getVolumeState();
    setState(() {});
  }

  saveVolumeState(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('volValue', value);
  }

  getVolumeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? vol = prefs.getDouble('volValue');

    return vol!;
  }

  List images = [
    "sound",
    "soundhover",
  ];
  @override
  void didChangeDependencies() {
    for (var i in images)
      precacheImage(AssetImage("assets/images/gui/" + i + ".png"), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "BGM VOLUME",
            style: TextStyle(
                fontFamily: "Mali", fontSize: 24, color: Colors.black),
          ),
        ),
      ),
      Container(
        height: 55,
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white.withOpacity(0.8),
        ),
        child: Row(
          children: <Widget>[
            vol == 0
                ? Image.asset("assets/images/gui/sound.png")
                : Image.asset("assets/images/gui/soundhover.png"),
            // vol == 0
            //     ? Icon(
            //         Icons.music_off,
            //         size: 35,
            //       )
            //     : Icon(
            //         Icons.music_note,
            //         size: 35,
            //       ),
            SizedBox(width: 15),
            Flexible(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.lightGreen,
                  inactiveTrackColor: Colors.grey,
                  thumbColor: Colors.green,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                ),
                child: Slider(
                  min: 0.0,
                  max: 1.0,
                  value: vol ?? 1.0,
                  onChanged: (volume) {
                    setState(() {
                      if (UniversalPlatform.isWindows ||
                          UniversalPlatform.isLinux) {
                        GameAudioDesktop.playAudio.player?.setVolume(volume);
                      } else {
                        GameAudio.bgm.audioPlayer!.setVolume(volume);
                        if (vol == 0) {
                          GameAudio.bgm.pause();
                        } else {
                          GameAudio.bgm.resume();
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
