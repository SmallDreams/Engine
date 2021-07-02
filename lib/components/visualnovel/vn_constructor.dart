import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/UI/background_builder.dart';
import 'package:salem/components/visualnovel/UI/buttons.dart';
import 'package:salem/components/visualnovel/components/textAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

class VNConstructor extends StatefulWidget {
  VNConstructor({
    this.bgImage,
    this.characterName,
    this.characterText,
    this.n,
    this.mcImage,
    this.sideCharImage,
    this.route,
    this.nextRoute,
    this.nextText,
  });

  final String? characterName;
  final bgImage;
  final String? mcImage;
  final String? sideCharImage;
  final int? n;
  final nextRoute;
  final characterText;
  final route;
  final nextText;

  @override
  _VNConstructorState createState() => _VNConstructorState();
}

class _VNConstructorState extends State<VNConstructor> {
  bool? isNoti = true;
  int? speed = 25;

  String? _name;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefValue) => {
          setState(() {
            _name = prefValue.getString('name') ?? 'MC';
          })
        });
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isNoti = (prefs.getBool("notiState"));
    if (isNoti == true) {
      //_playAudio();
    } else {}
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

  List images = [
    "icon_ground_scroll_05",
    "more",
  ];
  @override
  void didChangeDependencies() {
    for (var i in images)
      precacheImage(AssetImage("assets/images/gui/" + i + ".png"), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getSpeed();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        BackgroundBuilder(image: widget.bgImage),
        // Character Image here
        Builder(
          builder: (BuildContext context) {
            if (widget.mcImage != null && widget.sideCharImage != null) {
              return ImageBuilderMultiple(
                  mcImage: widget.mcImage, sideCharImage: widget.sideCharImage);
            } else {
              if (widget.characterName == "MC" ||
                  widget.characterName == "Narrator") {
                return ImageBuilderMC(image: widget.mcImage);
              } else {
                return ImageBuilder(image: widget.sideCharImage);
              }
            }
          },
        ),

        Builder(
          builder: (context) {
            if (UniversalPlatform.isMacOS ||
                UniversalPlatform.isWindows ||
                UniversalPlatform.isLinux ||
                UniversalPlatform.isWeb) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        if (widget.characterName == "MC" ||
                            widget.characterName == "Narrator") {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                child: Text(
                                  "$_name",
                                  style: TextStyle(
                                    fontFamily: "IndieFlower",
                                    fontSize: 32,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 15),
                              child: Text(
                                widget.characterName!,
                                style: TextStyle(
                                  fontFamily: "IndieFlower",
                                  fontSize: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 12),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         width: 100,
                    //         height: 100,
                    //         decoration: BoxDecoration(
                    //           color: Colors.transparent,
                    //           border: Border.all(
                    //             color: Colors.white,
                    //             width: 10,
                    //           ),
                    //           borderRadius: BorderRadius.circular(100),
                    //         ),
                    //       ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        // Stack(
                        //   children: <Widget>[
                        //     Container(
                        //       color: Colors.transparent,
                        //       padding: EdgeInsets.all(5),
                        //       width: MediaQuery.of(context).size.width * 2,
                        //       child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(10.0),
                        //         child: Image.asset(
                        //           "assets/images/gui/textbox_scroll_03.png",
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          // constraints:
                          //     BoxConstraints(minWidth: 100, minHeight: 100),
                          width: MediaQuery.of(context).size.width / 2.05,
                          child: Builder(
                            builder: (context) {
                              if (widget.characterName == "MC" ||
                                  widget.characterName == "Narrator") {
                                return Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/gui/textbox_scroll_03.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      color: Colors.white.withOpacity(0),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0),
                                      ),
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(0.0),
                                        topRight: const Radius.circular(0.0),
                                        bottomLeft: const Radius.circular(0.0),
                                      )),
                                  child: Stack(
                                    children: [
                                      Opacity(
                                        opacity: 1,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.025),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                widget.characterText,
                                                textAlign: TextAlign.left,
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Mali",
                                                    fontSize: 21),
                                                speed: Duration(
                                                    milliseconds: speed ?? 25),
                                              ),
                                            ],
                                            displayFullTextOnTap: true,
                                            isRepeatingAnimation: false,
                                            key: ValueKey(widget.n),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/gui/textbox_scroll_03.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      color: Colors.white.withOpacity(0),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0),
                                      ),
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(0.0),
                                        topRight: const Radius.circular(0.0),
                                        bottomRight: const Radius.circular(0.0),
                                      )),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03,
                                        vertical: height * 0.025),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          widget.characterText,
                                          textAlign: TextAlign.left,
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Mali",
                                              fontSize: 21),
                                          speed: Duration(
                                              milliseconds: speed ?? 25),
                                        ),
                                      ],
                                      displayFullTextOnTap: true,
                                      isRepeatingAnimation: false,
                                      key: ValueKey(widget.n),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),

                          // FittedBox(
                          //   fit: BoxFit.fitHeight,
                          //   child: Stack(
                          //     children: <Widget>[
                          //       Container(
                          //         color: Colors.transparent,
                          //         padding: EdgeInsets.symmetric(
                          //             vertical: 15, horizontal: 70),
                          //         child: AnimatedTextKit(
                          //           animatedTexts: [
                          //             TyperAnimatedText(
                          //               widget.q!,
                          //               textAlign: TextAlign.left,
                          //               textStyle: TextStyle(
                          //                   color: Colors.black,
                          //                   fontFamily: "Aleo",
                          //                   fontSize: 18),
                          //               speed: Duration(milliseconds: isFinished ? 0 : speed!),),
                          //             ),
                          //           ],
                          //           displayFullTextOnTap: true,
                          //           isRepeatingAnimation: false,
                          //           key: ValueKey(widget.n),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                    // Container(
                    //   width: 100,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //     color: Colors.transparent,
                    //     border: Border.all(
                    //       color: Colors.white,
                    //       width: 10,
                    //     ),
                    //     borderRadius: BorderRadius.circular(100),
                    //   ),
                    // ),
                    // Container(
                    //   transform: Matrix4.translationValues(-140.0, 0.0, 0.0),
                    //   width: 100,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //     border: Border(
                    //       right: BorderSide(width: 16.0, color: Colors.white),
                    //     ),
                    //     color: Colors.transparent,
                    //   ),
                    // ),

                    Buttons(
                      route: widget.route,
                      nextRoute: widget.nextRoute,
                    ),
                  ],
                ),
              );
            } else {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 15),
                    child: Buttons(route: widget.route),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Builder(
                        builder: (context) {
                          if (widget.characterName == "MC") {
                            return Opacity(
                              opacity: 0.8,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 15),
                                  child: Text(
                                    "$_name",
                                    style: TextStyle(
                                      fontFamily: "IndieFlower",
                                      fontSize: 19,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Opacity(
                              opacity: 0.8,
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 15),
                                  child: Text(
                                    widget.characterName!,
                                    style: TextStyle(
                                      fontFamily: "IndieFlower",
                                      fontSize: 19,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 4.4),
                        child: Column(
                          children: [
                            Stack(alignment: Alignment.centerLeft, children: <
                                Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                // constraints:
                                //     BoxConstraints(minWidth: 100, minHeight: 100),
                                width: MediaQuery.of(context).size.width / 2,
                                child: Builder(
                                  builder: (context) {
                                    if (widget.characterName == "MC" ||
                                        widget.characterName == "Narrator") {
                                      return Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/gui/textbox_scroll_03.png'),
                                              fit: BoxFit.fill,
                                            ),
                                            color: Colors.white.withOpacity(0),
                                            border: Border.all(
                                              color:
                                                  Colors.white.withOpacity(0),
                                            ),
                                            borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(0.0),
                                              topRight:
                                                  const Radius.circular(0.0),
                                              bottomLeft:
                                                  const Radius.circular(0.0),
                                            )),
                                        child: Stack(
                                          children: [
                                            Opacity(
                                              opacity: 1,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.03,
                                                    vertical: height * 0.025),
                                                child: AnimatedTextKit(
                                                  animatedTexts: [
                                                    TyperAnimatedText(
                                                      widget.characterText,
                                                      textAlign: TextAlign.left,
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Mali",
                                                          fontSize: 18),
                                                      speed: Duration(
                                                          milliseconds:
                                                              speed ?? 25),
                                                    ),
                                                  ],
                                                  displayFullTextOnTap: true,
                                                  isRepeatingAnimation: false,
                                                  key: ValueKey(widget.n),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/gui/textbox_scroll_03.png'),
                                              fit: BoxFit.fill,
                                            ),
                                            color: Colors.white.withOpacity(0),
                                            border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(0),
                                            ),
                                            borderRadius: new BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(0.0),
                                              topRight:
                                                  const Radius.circular(0.0),
                                              bottomRight:
                                                  const Radius.circular(0.0),
                                            )),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.025),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              TyperAnimatedText(
                                                widget.characterText,
                                                textAlign: TextAlign.left,
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Mali",
                                                    fontSize: 18),
                                                speed: Duration(
                                                    milliseconds: speed ?? 25),
                                              ),
                                            ],
                                            displayFullTextOnTap: true,
                                            isRepeatingAnimation: false,
                                            key: ValueKey(widget.n),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),

                                // FittedBox(
                                //   fit: BoxFit.fitHeight,
                                //   child: Stack(
                                //     children: <Widget>[
                                //       Container(
                                //         color: Colors.transparent,
                                //         padding: EdgeInsets.symmetric(
                                //             vertical: 15, horizontal: 70),
                                //         child: AnimatedTextKit(
                                //           animatedTexts: [
                                //             TyperAnimatedText(
                                //               widget.q!,
                                //               textAlign: TextAlign.left,
                                //               textStyle: TextStyle(
                                //                   color: Colors.black,
                                //                   fontFamily: "Aleo",
                                //                   fontSize: 18),
                                //               speed: Duration(milliseconds: isFinished ? 0 : speed!),),
                                //             ),
                                //           ],
                                //           displayFullTextOnTap: true,
                                //           isRepeatingAnimation: false,
                                //           key: ValueKey(widget.n),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

class ImageBuilder extends StatefulWidget {
  ImageBuilder({Key? key, this.image}) : super(key: key);

  final String? image;

  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  List images = [
    "fox_hidetake_blush",
    "fox_hidetake_frown",
    "fox_hidetake_happy",
    "fox_hidetake_neutral",
    "fox_hidetake_sad",
    "hidetake_blush",
    "hidetake_frown",
    "hidetake_happy",
    "hidetake_neutral",
    "hidetake_sad",
    "raven_naoki_blush",
    "raven_naoki_frown",
    "raven_naoki_happy",
    "raven_naoki_neutral",
    "raven_naoki_sad",
    "naoki_blush",
    "naoki_frown",
    "naoki_happy",
    "naoki_neutral",
    "naoki_sad",
    "raccoon_tom_blush",
    "raccoon_tom_frown",
    "raccoon_tom_happy",
    "raccoon_tom_neutral",
    "raccoon_tom_sad",
    "tom_blush",
    "tom_frown",
    "tom_happy",
    "tom_neutral",
    "tom_sad",
  ];
  @override
  void didChangeDependencies() {
    for (var i in images)
      precacheImage(AssetImage("assets/images/sprites/" + i + ".png"), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.image != null) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/images/sprites/" + widget.image! + ".png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 1.2,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class ImageBuilderMC extends StatefulWidget {
  ImageBuilderMC({Key? key, this.image}) : super(key: key);

  final String? image;

  @override
  _ImageBuilderMCState createState() => _ImageBuilderMCState();
}

class _ImageBuilderMCState extends State<ImageBuilderMC> {
  List images = [
    "mc_blush",
    "mc_frown",
    "mc_happy",
    "mc_neutral",
    "mc_sad",
  ];
  @override
  void didChangeDependencies() {
    for (var i in images)
      precacheImage(AssetImage("assets/images/sprites/" + i + ".png"), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // for (var i in images)
    //   precacheImage(AssetImage("assets/images/sprites/" + i + ".png"), context);
    double height = MediaQuery.of(context).size.height;
    return Builder(
      builder: (context) {
        if (height < 700) {
          return Align(
              key: UniqueKey(),
              alignment: Alignment.bottomRight,
              child: Builder(
                builder: (context) {
                  if (widget.image != null) {
                    return Image.asset(
                      "assets/images/sprites/" + widget.image! + ".png",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 1.7,
                      gaplessPlayback: true,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ));
        } else {
          return Align(
              key: UniqueKey(),
              alignment: Alignment.bottomRight,
              child: Builder(
                builder: (context) {
                  if (widget.image != null) {
                    return Image.asset(
                      "assets/images/sprites/" + widget.image! + ".png",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2,
                      gaplessPlayback: true,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ));
        }
      },
    );
  }
}

class ImageBuilderMultiple extends StatefulWidget {
  ImageBuilderMultiple({Key? key, this.mcImage, this.sideCharImage})
      : super(key: key);

  final String? mcImage;
  final String? sideCharImage;

  @override
  _ImageBuilderMultipleState createState() => _ImageBuilderMultipleState();
}

class _ImageBuilderMultipleState extends State<ImageBuilderMultiple> {
  List images = [
    "mc_blush",
    "mc_frown",
    "mc_happy",
    "mc_neutral",
    "mc_sad",
    "fox_hidetake_blush",
    "fox_hidetake_frown",
    "fox_hidetake_happy",
    "fox_hidetake_neutral",
    "fox_hidetake_sad",
    "hidetake_blush",
    "hidetake_frown",
    "hidetake_happy",
    "hidetake_neutral",
    "hidetake_sad",
    "raven_naoki_blush",
    "raven_naoki_frown",
    "raven_naoki_happy",
    "raven_naoki_neutral",
    "raven_naoki_sad",
    "naoki_blush",
    "naoki_frown",
    "naoki_happy",
    "naoki_neutral",
    "naoki_sad",
    "raccoon_tom_blush",
    "raccoon_tom_frown",
    "raccoon_tom_happy",
    "raccoon_tom_neutral",
    "raccoon_tom_sad",
    "tom_blush",
    "tom_frown",
    "tom_happy",
    "tom_neutral",
    "tom_sad",
  ];
  @override
  void didChangeDependencies() {
    for (var i in images)
      precacheImage(AssetImage("assets/images/sprites/" + i + ".png"), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // for (var i in images)
    //   precacheImage(AssetImage("assets/images/sprites/" + i + ".png"), context);
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Builder(
          builder: (context) {
            if (widget.sideCharImage != null) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/sprites/" + widget.sideCharImage! + ".png",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 1.2,
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
        Builder(
          builder: (context) {
            if (height < 700) {
              return Align(
                  key: UniqueKey(),
                  alignment: Alignment.bottomRight,
                  child: Builder(
                    builder: (context) {
                      if (widget.mcImage != null) {
                        return Image.asset(
                          "assets/images/sprites/" + widget.mcImage! + ".png",
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 2,
                          gaplessPlayback: true,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ));
            } else {
              return Align(
                  key: UniqueKey(),
                  alignment: Alignment.bottomRight,
                  child: Builder(
                    builder: (context) {
                      if (widget.mcImage != null) {
                        return Image.asset(
                          "assets/images/sprites/" + widget.mcImage! + ".png",
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 2,
                          gaplessPlayback: true,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ));
            }
          },
        ),
      ],
    );
  }
}
