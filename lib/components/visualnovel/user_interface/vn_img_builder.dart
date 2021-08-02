import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ImageBuilder extends StatefulWidget {
  final centerImage;
  final bool? hasAnimation;
  final animationName;
  ImageBuilder({
    Key? key,
    this.centerImage,
    this.hasAnimation,
    this.animationName,
  }) : super(key: key);

  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  // getImg() {
  //   if (widget.image != null) {
  //     bool img =
  //         File("assets/images/sprites/" + widget.image! + ".png").existsSync();
  //     return img;
  //   }
  // }
  late RiveAnimationController _controller;
  @override
  void initState() {
    print(widget.animationName);
    super.initState();
    _controller = SimpleAnimation(
      widget.animationName,
      autoplay: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.centerImage != null && widget.centerImage!.isNotEmpty) {
          if (widget.hasAnimation == true) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: RiveAnimation.asset(
                "assets/images/sprites/" + widget.centerImage! + ".riv",
                fit: BoxFit.contain,
                controllers: [_controller],
                //height: MediaQuery.of(context).size.height / 1.2,
              ),
            );
          } else {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/sprites/" + widget.centerImage! + ".png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 1.5,
              ),
            );
          }
        } else {
          return Container(
            child: Text("Here should be a Sprite!"),
          );
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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Builder(builder: (context) {
      if (widget.image != null || widget.image!.isNotEmpty) {
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
                ),
              );
            }
          },
        );
      } else {
        return Container(
          color: Colors.transparent,
          child: Text(
            "Here should be a Sprite!",
            style: TextStyle(color: Colors.transparent),
          ),
        );
      }
    });
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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Builder(
          builder: (context) {
            if (widget.sideCharImage!.isNotEmpty &&
                widget.sideCharImage != null) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/sprites/" + widget.sideCharImage! + ".png",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 1.5,
                ),
              );
            } else {
              return Container(
                child: Text("Here should be a Sprite!"),
              );
            }
          },
        ),
        Builder(builder: (context) {
          if (widget.mcImage!.isNotEmpty && widget.mcImage != null) {
            return Builder(
              builder: (context) {
                if (height < 700) {
                  return Align(
                      key: UniqueKey(),
                      alignment: Alignment.bottomRight,
                      child: Builder(
                        builder: (context) {
                          if (widget.mcImage != null) {
                            return Image.asset(
                              "assets/images/sprites/" +
                                  widget.mcImage! +
                                  ".png",
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
                    ),
                  );
                }
              },
            );
          } else {
            return Container(
              child: Text("Here should be a Sprite!"),
            );
          }
        }),
      ],
    );
  }
}
