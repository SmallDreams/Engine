import 'package:flutter/material.dart';
import 'package:salem/components/visualnovel/vn_constructor.dart';

class VNScaffold extends StatefulWidget {
  final bgImage;
  final textSound;
  final route;
  final nextRoute;
  final hasVoiceActing;
  VNScaffold(
      {Key? key,
      required this.bgImage,
      required this.textSound,
      required this.route,
      required this.nextRoute,
      required this.hasVoiceActing})
      : super(key: key);
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VNScaffold> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => getOnWillPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: InkWell(
          onTap: () {
            setState(() {
              if (widget.textSound.isFinished() == true) {
                Navigator.of(context).pushNamed(widget.nextRoute);
                widget.textSound.reset();
              } else {
                widget.textSound.nextQuestion();
              }
            });
          },
          child: widget.hasVoiceActing
              ? VNConstructorTextSound(
                  bgImage: "assets/images/bgs/" + widget.bgImage,
                  characterName: widget.textSound.getCharacterName(),
                  characterText: widget.textSound.getCharacterText(),
                  initNumber: widget.textSound.getNumber(),
                  charImage: widget.textSound.getImage(),
                  route: widget.route,
                  nextRoute: widget.nextRoute)
              // todo: add voiceacting constructor
              : VNConstructorTextSound(
                  bgImage: "assets/images/bgs/" + widget.bgImage,
                  characterName: widget.textSound.getCharacterName(),
                  characterText: widget.textSound.getCharacterText(),
                  initNumber: widget.textSound.getNumber(),
                  charImage: widget.textSound.getImage(),
                  route: widget.route,
                  nextRoute: widget.nextRoute),
        ),
      ),
    );
  }

  getOnWillPop() {
    print("Not allowed.");
  }
}
