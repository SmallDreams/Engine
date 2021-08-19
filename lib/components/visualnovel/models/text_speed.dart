import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextSpeed extends StatefulWidget {
  final player;
  TextSpeed({Key? key, this.player});
  @override
  _TextSpeedState createState() => _TextSpeedState();
}

class _TextSpeedState extends State<TextSpeed> {
  @override
  void initState() {
    super.initState();
    getSpeed();
  }

  getSpeed() async {
    speed = await getSpeedState();
    setState(() {});
  }

  saveSpeedState(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("speedValue", value);
  }

  getSpeedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? speed = prefs.getInt('speedValue');

    return speed;
  }

  int speed = 25;

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
            "Text Speed",
            style: TextStyle(fontSize: 18, fontFamily: "Arvo"),
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
            Builder(
              builder: (context) {
                if (speed == 0) {
                  return const Icon(
                    Icons.pause,
                    size: 35,
                  );
                } else if (speed <= 25) {
                  return const Icon(
                    Icons.fast_forward,
                    size: 35,
                  );
                } else {
                  return const Icon(
                    Icons.play_arrow,
                    size: 35,
                  );
                }
              },
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Faster",
              style: TextStyle(
                  fontFamily: "Mali", fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Theme.of(context).colorScheme.secondary,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 0.0),
                ),
                child: Slider(
                  divisions: 10,
                  label: "$speed ms",
                  min: 0,
                  max: 50,
                  value: speed.toDouble(),
                  onChanged: (fast) {
                    setState(() {
                      speed = fast.toInt();
                      saveSpeedState(fast.toInt());
                      print(speed);
                      //saveVolumeState(volume);
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Slower",
              style: TextStyle(
                  fontFamily: "Mali", fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    ]);
  }
}
