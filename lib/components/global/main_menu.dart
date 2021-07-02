// Primary
import 'package:dart_vlc/dart_vlc.dart';
import 'package:salem/core/audio/gameAudio.dart';
import 'package:salem/core/audio/globalAudio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class MainMenu extends StatefulWidget {
  final bgImage;
  final mainMenuBGM;
  bool button;
  bool startButton;
  bool loadButton;
  bool settingsButton;
  bool creditsButton;
  bool topLeft;
  bool centerLeft;
  bool bottomLeft;
  bool topCenter;
  bool center;
  bool bottomCenter;
  bool topRight;
  bool centerRight;
  bool bottomRight;
  double? buttonWidth;
  double? buttonHeight;
  double? fontSize;
  final buttonColor;
  final textColor;
  double? buttonRadius;

  MainMenu({
    this.topLeft = false,
    this.centerLeft = false,
    this.bottomLeft = false,
    this.topCenter = false,
    this.center = false,
    this.bottomCenter = false,
    this.topRight = false,
    this.centerRight = false,
    this.bottomRight = false,
    this.bgImage,
    this.mainMenuBGM,
    this.button = true,
    this.startButton = true,
    this.loadButton = true,
    this.settingsButton = true,
    this.creditsButton = true,
    this.buttonWidth,
    this.buttonHeight,
    this.fontSize,
    this.buttonColor,
    this.textColor,
    this.buttonRadius,
  });
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

    GlobalAudio.playAudio.getBGM(widget.mainMenuBGM);

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      getPersistBGM = sharedPreferences!.getString("getPersistBGM");
      getPersistBGM = widget.mainMenuBGM;
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
    if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      super.didChangeDependencies();
      GameAudioDesktop.playAudio.player = Player(
        id: 0,
      );
    }
  }

  checkForImgExtension() {
    if (widget.bgImage.contains("png")) {
      return AssetImage("assets/images/bgs/" + widget.bgImage + ".png");
    } else if (widget.bgImage.contains("jpg")) {
      return AssetImage("assets/images/bgs/" + widget.bgImage + ".jpg");
    } else if (widget.bgImage.contains("jpeg")) {
      return AssetImage("assets/images/bgs/" + widget.bgImage + ".jpeg");
    } else if (widget.bgImage.contains("svg")) {
      return AssetImage("assets/images/bgs/" + widget.bgImage + ".svg");
    }
  }

  getAlignment() {
    if (widget.topLeft) {
      return Alignment.topLeft;
    } else if (widget.centerLeft) {
      return Alignment.centerLeft;
    } else if (widget.bottomLeft) {
      return Alignment.bottomLeft;
    } else if (widget.topCenter) {
      return Alignment.topCenter;
    } else if (widget.center) {
      return Alignment.center;
    } else if (widget.bottomCenter) {
      return Alignment.bottomCenter;
    } else if (widget.topRight) {
      return Alignment.topRight;
    } else if (widget.centerRight) {
      return Alignment.centerRight;
    } else if (widget.bottomRight) {
      return Alignment.bottomRight;
    } else {
      return Alignment.center;
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
            Align(
              alignment: getAlignment(),
              child: Container(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        widget.startButton
                            ? _button(
                                context,
                                "Start",
                                widget.fontSize,
                                "FONT",
                                "/1",
                                widget.buttonColor,
                                widget.textColor,
                                widget.buttonRadius,
                              )
                            : SizedBox.shrink(),
                        widget.loadButton
                            ? _button(
                                context,
                                "Load",
                                widget.fontSize,
                                "FONT",
                                "/loadgame",
                                widget.buttonColor,
                                widget.textColor,
                                widget.buttonRadius,
                              )
                            : SizedBox.shrink(),
                        widget.settingsButton
                            ? _button(
                                context,
                                "Settings",
                                widget.fontSize,
                                "FONT",
                                "/settings",
                                widget.buttonColor,
                                widget.textColor,
                                widget.buttonRadius,
                              )
                            : SizedBox.shrink(),
                        widget.creditsButton
                            ? _button(
                                context,
                                "Credits",
                                widget.fontSize,
                                "",
                                "/credits",
                                widget.buttonColor,
                                widget.textColor,
                                widget.buttonRadius,
                              )
                            : SizedBox.shrink(),
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

  _button(context, buttonName, double? fontSize, fontFamily, route, buttonColor,
      textColor, buttonRadius) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Container(
        width: widget.buttonWidth != null
            ? widget.buttonWidth
            : MediaQuery.of(context).size.width / 3,
        height: widget.buttonHeight != null ? widget.buttonHeight : 60,
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
                    borderRadius: BorderRadius.circular(buttonRadius ?? 40.0),
                    side: BorderSide(color: Colors.transparent))),
            onPressed: () {
              Navigator.of(context).pushNamed(route);
            }),
      ),
    );
  }
}
