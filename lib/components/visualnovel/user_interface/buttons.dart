import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salem/salem.dart';
import 'package:universal_platform/universal_platform.dart';

class Buttons extends StatelessWidget {
  final route;
  final nextRoute;

  const Buttons({Key? key, required this.route, required this.nextRoute})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      if (UniversalPlatform.isMacOS ||
          UniversalPlatform.isWindows ||
          UniversalPlatform.isLinux ||
          UniversalPlatform.isWeb) {
        return SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              skipClip(context, nextRoute),
              const SizedBox(
                width: 7,
              ),
              SettingsClip(route: route),
            ],
          ),
        );
      } else {
        return Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              skipClip(context, nextRoute),
              const SizedBox(
                width: 5,
              ),
              SettingsClip(route: route),
            ],
          ),
          const SizedBox(height: 140),
        ]);
      }
    });
  }
}

class SettingsClip extends StatelessWidget {
  final route;

  const SettingsClip({Key? key, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () => Navigator.of(context)
              .pushNamed("/settings", arguments: ScreenArguments(route ?? "/")),
          child: Row(children: const [
            Text(
              "SETTINGS",
              style: TextStyle(
                fontFamily: "Nasa",
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              FontAwesomeIcons.cog,
              size: 20,
              color: Colors.black,
            ),
          ]));
    });
  }
}

class ScreenArguments {
  final String route;

  ScreenArguments(this.route);
}

dynamic skipClip(context, nextRoute) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () => showAlertDialog(context, nextRoute),
      child: Row(children: const [
        Text(
          "SKIP",
          style: TextStyle(
            fontFamily: "Nasa",
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          FontAwesomeIcons.forward,
          size: 20,
          color: Colors.black,
        ),
      ]),
    )
  ]);
}

showAlertDialog(BuildContext context, nextRoute) {
  Widget continueButton = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Theme.of(context).primaryColor),
        child: const Text(
          "YES",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Nasa",
              fontSize: 20,
              letterSpacing: .4),
        ),
        onPressed: () {
          GlobalAudio.playAudio.stopAmbienceAudio();
          GlobalAudio.playAudio.stopVoiceAudio();
          Navigator.of(context).pushNamed(nextRoute);
        },
      ),
      const SizedBox(
        width: 10,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Theme.of(context).primaryColor),
        child: const Text(
          "NO",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Nasa",
              fontSize: 20,
              letterSpacing: .4),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );

  Dialog alert = Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: const EdgeInsets.all(10),
    child: Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.amberAccent),
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: <Widget>[
          const Text("Chapter Skip",
              style: TextStyle(fontSize: 28, fontFamily: "Rubik"),
              textAlign: TextAlign.center),
          const Text("Are you sure about that?",
              style: TextStyle(fontSize: 24, fontFamily: "Rubik"),
              textAlign: TextAlign.center),
          const Spacer(),
          continueButton,
        ],
      ),
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
