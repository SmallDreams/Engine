import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:salem/core/persist/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import 'package:salem/core/audio/gameAudio.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? sharedPreferences;

  double? opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          AnimatedOpacity(
                            opacity: opacity!,
                            duration: const Duration(milliseconds: 250),
                            child: Center(
                                child: Image.asset(
                              "assets/images/MUTA.png",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width / 3,
                            )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // PRECACHE IMAGES

  List<Map<String, dynamic>> images = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Platform.isWindows ||
        Platform.isLinux && GameAudioDesktop.playAudio.isPlaying == false) {
      super.didChangeDependencies();
      GameAudioDesktop.playAudio.player = Player(
        id: 0,
      );
    }
    for (var i in images) {
      precacheImage(AssetImage(i["image"]), context);
    }
  }
  // PRECACHE IMAGES

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        PersistNavigation.initSplash(context);
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }
}
