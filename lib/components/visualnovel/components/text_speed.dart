import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextSpeed extends StatefulWidget {
  final player;
  TextSpeed({Key? key, this.player});
  @override
  _TextSpeedState createState() => new _TextSpeedState();
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

  List images = [
    "icon_ground_scroll_06",
    "icon_active_scroll_05",
    "icon_active_scroll_04",
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
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "TEXT SPEED",
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
            Builder(
              builder: (context) {
                if (speed == 0) {
                  return Image.asset(
                      "assets/images/gui/icon_ground_scroll_06.png");
                } else if (speed <= 25) {
                  return Image.asset(
                      "assets/images/gui/icon_active_scroll_05.png");
                } else {
                  return Image.asset(
                      "assets/images/gui/icon_active_scroll_04.png");
                }
              },
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Faster",
              style: TextStyle(
                  fontFamily: "Mali", fontSize: 16, color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
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
            SizedBox(
              width: 10,
            ),
            Text(
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
