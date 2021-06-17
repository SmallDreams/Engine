import 'package:flutter/material.dart';
import 'package:salem/visualnovel/vn_constructor.dart';

class VNScaffold extends StatefulWidget {
  final bgImage;
  final textSound;
  final route;
  final nextRoute;
  final hasVoiceActing;
  VNScaffold(
      {this.bgImage,
      this.textSound,
      this.route,
      this.nextRoute,
      this.hasVoiceActing});
  @override
  _VNState createState() => _VNState();
}

class _VNState extends State<VNScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: InkWell(
          onTap: () {
            setState(() {
              if (widget.textSound.isFinished() == true) {
                Navigator.of(context).pushNamed(widget.nextRoute);
              } else {
                widget.textSound.nextQuestion();
              }
            });
          },
          child: widget.hasVoiceActing
              ? VNConstructorTextSound(
                  "assets/images/bgs/" + widget.bgImage + ".jpg",
                  widget.textSound.getCorrectAnswer(),
                  widget.textSound.getQuestionText(),
                  widget.textSound.getNumber(),
                  widget.textSound.getImage(),
                  widget.route,
                  widget.nextRoute)
              // todo: add voiceacting constructor
              : VNConstructorTextSound(
                  "assets/images/bgs/" + widget.bgImage + ".jpg",
                  widget.textSound.getCorrectAnswer(),
                  widget.textSound.getQuestionText(),
                  widget.textSound.getNumber(),
                  widget.textSound.getImage(),
                  widget.route,
                  widget.nextRoute)),
    );
  }
}
