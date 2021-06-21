// Primary
import 'package:dart_vlc/dart_vlc.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:salem/core/audio/globalAudio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  final bgImage;
  final bgm;
  MainMenu({this.bgImage, this.bgm});
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

/// The main widget state.
class _BaseScreenState extends State<MainMenu> {
  SharedPreferences? sharedPreferences;
  String? getPersistBGM;
  @override
  void initState() {
    super.initState();

    GlobalAudio.playAudio.getAudio(widget.bgm);

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      getPersistBGM = sharedPreferences!.getString("getPersistBGM");
      getPersistBGM = widget.bgm;
      persistBGM(getPersistBGM!);
      print(getPersistBGM);
    });
  }

  void persistBGM(String value) {
    setState(() {
      getPersistBGM = value;
    });
    sharedPreferences?.setString("getPersistBGM", value);
  }

  @override
  void didChangeDependencies() {
    if (Platform.isWindows || Platform.isLinux) {
      super.didChangeDependencies();
      GameAudioDesktop.playDesktopAudio.player = Player(
        id: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => getOnWillPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bgs/" + widget.bgImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _button(context, "Start", 30, "FONT", "/1",
                            Colors.white, Colors.black),
                        _button(context, "Load", 30, "FONT", "/loadgame",
                            Colors.white, Colors.black),
                        _button(context, "Settings", 30, "FONT", "/settings",
                            Colors.white, Colors.black),
                        _button(context, "Credits", 30, "", "/credits",
                            Colors.white, Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("Okay."),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.all(5),
      backgroundColor: Colors.white,
      title: Text(
        "Not available",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28),
      ),
      content: Text(
        "Sorry! Currently not available.",
        textAlign: TextAlign.center,
        style: TextStyle(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getOnWillPop() {
    print("Not allowed.");
  }
}

Widget _button(context, buttonName, double? fontSize, fontFamily, route,
    buttonColor, textColor) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
    child: Container(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
          child: Text(
            buttonName.toUpperCase(),
            style: TextStyle(
                color: textColor ?? Colors.black,
                fontSize: fontSize ?? 20,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: buttonColor ?? Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  side: BorderSide(color: Colors.transparent))),
          onPressed: () {
            Navigator.of(context).pushNamed(route);
          }),
    ),
  );
}
