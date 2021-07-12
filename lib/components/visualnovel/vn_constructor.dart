part of salem_engine;

class VNConstructor extends StatefulWidget {
  VNConstructor({
    this.bgImage,
    this.characterName,
    this.characterText,
    this.cT,
    this.n,
    this.mcImage,
    this.centerCharacterImage,
    this.leftCharacterImage,
    this.rightCharacterImage,
    this.route,
    this.nextRoute,
    this.hasAnimation,
    this.animationName,
  });

  final String? characterName;
  final bgImage;
  final String? mcImage;
  final String? centerCharacterImage;
  final String? leftCharacterImage;
  final String? rightCharacterImage;
  final int? n;
  final nextRoute;
  final characterText;
  final cT;
  final route;
  final bool? hasAnimation;
  final animationName;

  @override
  _VNConstructorState createState() => _VNConstructorState();
}

class _VNConstructorState extends State<VNConstructor> {
  bool? isNoti = true;
  int? speed = 25;

  @override
  void initState() {
    super.initState();
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
            if (widget.mcImage != null ||
                widget.centerCharacterImage != null ||
                widget.leftCharacterImage != null ||
                widget.rightCharacterImage != null) {
              if (widget.characterName == "MC" ||
                  widget.characterName == "Narrator") {
                return ImageBuilderMC(image: widget.mcImage);
              } else {
                return ImageBuilder(
                  centerImage: widget.centerCharacterImage,
                  hasAnimation: widget.hasAnimation ?? false,
                  animationName: widget.animationName ?? "idle",
                );
              }
            } else {
              return SizedBox.shrink();
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
                    NameBox(
                      characterName: widget.characterName,
                    ),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          // constraints:
                          //     BoxConstraints(minWidth: 100, minHeight: 100),
                          width: MediaQuery.of(context).size.width / 2.05,
                          child: Builder(builder: (context) {
                            // bool textbox = File("assets/images/gui/textbox.png")
                            //     .existsSync();
                            // if (textbox == true) {
                            //   return Container(
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //           image: AssetImage(
                            //               'assets/images/gui/textbox.png'),
                            //           fit: BoxFit.fill,
                            //         ),
                            //         color: Colors.white.withOpacity(0),
                            //         border: Border.all(
                            //           color: Colors.black.withOpacity(0),
                            //         ),
                            //         borderRadius: new BorderRadius.only(
                            //           topLeft: const Radius.circular(0.0),
                            //           topRight: const Radius.circular(0.0),
                            //           bottomRight: const Radius.circular(0.0),
                            //         )),
                            //     child: Padding(
                            //       padding: EdgeInsets.symmetric(
                            //           horizontal: width * 0.03,
                            //           vertical: height * 0.025),
                            //       child: AnimatedTextKit(
                            //         animatedTexts: [
                            //           TyperAnimatedText(
                            //             widget.characterText,
                            //             textAlign: TextAlign.left,
                            //             textStyle: TextStyle(
                            //                 color: Colors.black,
                            //                 fontFamily: "Mali",
                            //                 fontSize: 21),
                            //             speed:
                            //                 Duration(milliseconds: speed ?? 25),
                            //           ),
                            //         ],
                            //         displayFullTextOnTap: true,
                            //         isRepeatingAnimation: false,
                            //         key: ValueKey(widget.n),
                            //       ),
                            //     ),
                            //   );
                            // } else {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
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
                                  child: Builder(
                                    builder: (context) {
                                      if (widget.characterText != null) {
                                        return AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              widget.characterText ?? "···",
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
                                        );
                                      } else {
                                        return AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              widget.cT ?? "···",
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
                                        );
                                      }
                                    },
                                  )),
                            );
                            //   }
                          }),
                        ),
                      ],
                    ),
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
                      NameBox(
                        characterName: widget.characterName,
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
                                                      widget.characterText ??
                                                          "···",
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
                                                widget.characterText ?? "···",
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
