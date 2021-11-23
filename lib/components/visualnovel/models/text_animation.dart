/// Copyright (c) 2021 The SmallDreams Authors

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:salem/components/global/logical_keyboard.dart';
import 'package:salem/components/visualnovel/user_interface/vn_img_builder.dart';
import 'package:salem/salem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

// Copyright (c) 2018 Ayush Agarwal
/// Abstract base class for text animations.
abstract class AnimatedText {
  /// Text for [Text] widget.
  final String text;

  /// [TextAlign] property for [Text] widget.
  ///
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

  /// [TextStyle] property for [Text] widget.
  final TextStyle? textStyle;

  /// The Duration for the Animation Controller.
  ///
  /// This will set the total duration for the animated widget.
  /// For example, if you want the text animation to take 3 seconds,
  /// then you have to set [duration] to 3 seconds.
  final Duration duration;

  /// Same as [text] but as [Characters].
  ///
  /// Need to use character length, not String length, to propertly support
  /// Unicode and Emojis.
  final Characters textCharacters;

  AnimatedText({
    required this.text,
    this.textAlign = TextAlign.start,
    this.textStyle,
    required this.duration,
  }) : textCharacters = text.characters;

  /// Return the remaining Duration for the Animation (when applicable).
  Duration? get remaining => null;

  /// Initialize the Animation.
  void initAnimation(AnimationController controller);

  /// Utility method to create a styled [Text] widget using the [textAlign] and
  /// [textStyle], but you can specify the [data].
  Widget textWidget(String data) => Builder(
        builder: (context) {
          // if (data.contains(" ·  ·  · ")) {
          //   return SimpleRichText(
          //     data,
          //     logIt: false,
          //     style: textStyle,
          //     textAlign: textAlign,
          //     textOverflow: TextOverflow.ellipsis,
          //     maxLines: 1,
          //   );
          // } else {
          if (data.isNotEmpty) {
            return SimpleRichText(
              "\n› " + data + "\n",
              logIt: false,
              style: textStyle,
              textAlign: textAlign,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 10,
            );
          } else {
            return SimpleRichText(
              "\n› ···\n",
              logIt: false,
              style: textStyle,
              textAlign: textAlign,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 10,
              // pre: TextSpan(text: 'PRE', style: TextStyle(color: Colors.purple)),
              // post: TextSpan(text: 'POST', style: TextStyle(color: Colors.purple)),
            );
          }
        },
      );

  // Text(
  //       data,
  //       textAlign: textAlign,
  //       style: textStyle,
  //     );
  // StyledText(
  //   text: text,
  //   tags: {
  //     'red': StyledTextTag(style: TextStyle(color: Colors.red)),
  //     'orange': StyledTextTag(style: TextStyle(color: Colors.orange)),
  //     'yellow': StyledTextTag(style: TextStyle(color: Colors.yellow)),
  //     'green': StyledTextTag(style: TextStyle(color: Colors.green)),
  //     'blue': StyledTextTag(style: TextStyle(color: Colors.blue)),
  //     'indigo': StyledTextTag(style: TextStyle(color: Colors.indigo)),
  //     'purple': StyledTextTag(style: TextStyle(color: Colors.purple)),
  //     'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
  //     'i': StyledTextTag(style: TextStyle(fontStyle: FontStyle.italic)),
  //   },
  //   textAlign: textAlign,
  //   style: textStyle,
  // );
  // TextStyled(
  //   textStyle:
  //       TextStyle(color: Colors.black, fontFamily: "Mali", fontSize: 21),
  // ).getRichText(data);
  // Builder(builder: (context) {
  //   if (data.contains('/') == true) {
  //     return SuperRichText(
  //       text: data.replaceAll(new RegExp("/"), ''),
  //       textAlign: textAlign,
  //       style: textStyle,
  //     );
  //   } else {
  //     return
  // SuperRichText(
  //   text: data,
  //   textAlign: textAlign,
  //   style: textStyle,
  // );
  //   }
  // });

  /// Widget showing the complete text (when animation is complete or paused).
  /// By default, it shows a Text widget, but this may be overridden.
  Widget completeText(BuildContext context) => textWidget(text);

  /// Widget showing animated text, based on animation value(s).
  Widget animatedBuilder(BuildContext context, Widget? child);
}

/// Base class for Animated Text widgets.
class AnimatedTextKit extends StatefulWidget {
  /// List of [AnimatedText] to display subsequently in the animation.
  final List<AnimatedText> animatedTexts;

  /// Define the [Duration] of the pause between texts
  ///
  /// By default it is set to 1000 milliseconds.
  final Duration pause;

  /// Should the animation ends up early and display full text if you tap on it?
  ///
  /// By default it is set to false.
  final bool displayFullTextOnTap;

  final VoidCallback? callback;

  /// If on pause, should a tap remove the remaining pause time ?
  ///
  /// By default it is set to false.
  final bool stopPauseOnTap;

  /// Adds the onTap [VoidCallback] to the animated widget.
  final VoidCallback? onTap;

  /// Adds the onFinished [VoidCallback] to the animated widget.
  ///
  /// This method will run only if [isRepeatingAnimation] is set to false.
  final VoidCallback? onFinished;

  /// Adds the onNext callback to the animated widget.
  ///
  /// Will be called right before the next text, after the pause parameter
  final void Function(int, bool)? onNext;

  /// Adds the onNextBeforePause callback to the animated widget.
  ///
  /// Will be called at the end of n-1 animation, before the pause parameter
  final void Function(int, bool)? onNextBeforePause;

  /// Set if the animation should not repeat by changing the value of it to false.
  ///
  /// By default it is set to true.
  final bool isRepeatingAnimation;

  /// Sets if the animation should repeat forever. [isRepeatingAnimation] also
  /// needs to be set to true if you want to repeat forever.
  ///
  /// By default it is set to false, if set to true, [totalRepeatCount] is ignored.
  final bool repeatForever;

  /// Sets the number of times animation should repeat
  ///
  /// By default it is set to 3
  final int totalRepeatCount;

  final String? characterName;
  final bgImage;
  final String? vnFont;
  final String? vnNameFont;
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
  const AnimatedTextKit({
    Key? key,
    required this.animatedTexts,
    this.pause = const Duration(milliseconds: 1000),
    this.displayFullTextOnTap = false,
    this.stopPauseOnTap = false,
    this.onTap,
    this.onNext,
    this.onNextBeforePause,
    this.callback,
    this.onFinished,
    this.isRepeatingAnimation = true,
    this.totalRepeatCount = 3,
    this.repeatForever = false,
    this.bgImage,
    this.characterName,
    this.characterText,
    this.cT,
    this.n,
    this.mcImage,
    this.centerCharacterImage,
    this.leftCharacterImage,
    this.rightCharacterImage,
    required this.route,
    required this.nextRoute,
    this.hasAnimation,
    this.animationName,
    this.vnFont,
    this.vnNameFont,
  })  : assert(animatedTexts.length > 0),
        assert(!isRepeatingAnimation || totalRepeatCount > 0 || repeatForever),
        assert(null == onFinished || !repeatForever),
        super(key: key);

  /// Creates the mutable state for this widget. See [StatefulWidget.createState].
  @override
  _AnimatedTextKitState createState() => _AnimatedTextKitState();
}

class _AnimatedTextKitState extends State<AnimatedTextKit>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late AnimatedText _currentAnimatedText;

  int _currentRepeatCount = 0;

  int _index = 0;

  bool _isCurrentlyPausing = false;

  Timer? _timer;
  bool? isNoti = true;
  int? speed = 25;

  Future<void> getSharedPrefs() async {
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

  getSpeedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? speed = prefs.getInt('speedValue');
    return speed;
  }

  @override
  void initState() {
    super.initState();
    getSpeed();
    _initAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    onTap();
  }

  void _decrementCounter() {
    onTap();
  }

  @override
  Widget build(BuildContext context) {
    final completeText = _currentAnimatedText.completeText(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return CounterShortcuts(
        onIncrementDetected: _incrementCounter,
        onDecrementDetected: _decrementCounter,
        child: GestureDetector(
            onTap: () => onTap(),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(fit: StackFit.expand, children: [
                  //Character Image here
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
                        return const SizedBox.shrink();
                      }
                    },
                  ),

                  Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          NameBox(
                            characterName: widget.characterName,
                            vnNameFont: widget.vnNameFont,
                          ),
                          Column(
                            children: [
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: <Widget>[
                                  SizerUtil.deviceType == DeviceType.tablet
                                      ? SizedBox(
                                          height: 20,
                                        )
                                      : SizedBox.shrink(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: MediaQuery.of(context).size.width /
                                        1.225,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.black,
                                          //     blurRadius: 10,
                                          //     offset: Offset(
                                          //         5, 10), // Shadow position
                                          //   ),
                                          // ],
                                          color: Colors.white.withOpacity(0.9),
                                          border: Border.all(
                                            color: Colors.black.withOpacity(0),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Opacity(
                                            opacity: 1,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: width * 0.03,
                                              ),
                                              child: _isCurrentlyPausing ||
                                                      !_controller.isAnimating
                                                  ? completeText
                                                  : AnimatedBuilder(
                                                      animation: _controller,
                                                      builder:
                                                          _currentAnimatedText
                                                              .animatedBuilder,
                                                      child: completeText,
                                                    ),
                                            ),
                                          ),
                                          // Container(
                                          //   child: Icon(
                                          //       EvaIcons.arrowCircleRight),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height / 6,
                              ),
                              // Buttons(
                              //   route: widget.route,
                              //   nextRoute: widget.nextRoute,
                              // ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ]))));
    // GestureDetector(
    //   onTap: onTap,
    // child: _isCurrentlyPausing || !_controller.isAnimating
    //     ? completeText
    //     : AnimatedBuilder(
    //         animation: _controller,
    //         builder: _currentAnimatedText.animatedBuilder,
    //         child: completeText,
    //       ),
    // );
  }

  bool get _isLast => _index == widget.animatedTexts.length - 1;

  void _nextAnimation() {
    final isLast = _isLast;

    _isCurrentlyPausing = false;

    // Handling onNext callback
    widget.onNext?.call(_index, isLast);

    if (isLast) {
      if (widget.isRepeatingAnimation &&
          (widget.repeatForever ||
              _currentRepeatCount != (widget.totalRepeatCount - 1))) {
        _index = 0;
        if (!widget.repeatForever) {
          _currentRepeatCount++;
        }
      } else {
        widget.onFinished?.call();
        return;
      }
    } else {
      _index++;
    }

    if (mounted) setState(() {});

    _controller.dispose();

    // Re-initialize animation
    _initAnimation();
  }

  void _initAnimation() {
    _currentAnimatedText = widget.animatedTexts[_index];

    _controller = AnimationController(
      duration: _currentAnimatedText.duration,
      vsync: this,
    );

    _currentAnimatedText.initAnimation(_controller);

    _controller
      ..addStatusListener(_animationEndCallback)
      ..forward();
  }

  void _setPause() {
    final isLast = _isLast;

    _isCurrentlyPausing = true;
    if (mounted) setState(() {});

    // Handle onNextBeforePause callback
    widget.onNextBeforePause?.call(_index, isLast);
  }

  void _animationEndCallback(AnimationStatus state) {
    if (state == AnimationStatus.completed) {
      _setPause();
      assert(null == _timer || !_timer!.isActive);
      _timer = Timer(widget.pause, _nextAnimation);
    }
  }

  void onTap() {
    if (widget.displayFullTextOnTap) {
      if (_isCurrentlyPausing) {
        // widget.onNext?.call(_index, isLast);
        widget.onTap?.call();

        if (widget.stopPauseOnTap) {
          _timer?.cancel();
          _nextAnimation();
        }
      } else {
        final left =
            (_currentAnimatedText.remaining ?? _currentAnimatedText.duration)
                .inMilliseconds;

        _controller.stop();

        _setPause();

        assert(null == _timer || !_timer!.isActive);
        _timer = Timer(
          Duration(
            milliseconds: max(
              widget.pause.inMilliseconds,
              left,
            ),
          ),
          _nextAnimation,
        );
      }
    }
  }
}

/// Animated Text that displays a [Text] element as if it is being typed one
/// character at a time.
///
/// ![Typer example](https://raw.githubusercontent.com/aagarwal1012/Animated-Text-Kit/master/display/typer.gif)
class TyperAnimatedText extends AnimatedText {
  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 40 milliseconds.
  final Duration speed;

  /// The [Curve] of the rate of change of animation over time.
  ///
  /// By default it is set to Curves.linear.
  final Curve curve;

  TyperAnimatedText(
    String text, {
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    this.speed = const Duration(milliseconds: 40),
    this.curve = Curves.linear,
  }) : super(
          text: text,
          textAlign: textAlign,
          textStyle: textStyle,
          duration: speed * text.characters.length,
        );

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (textCharacters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  /// Widget showing partial text, up to [count] characters
  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    /// Output of CurveTween is in the range [0, 1] for majority of the curves.
    /// It is converted to [0, textCharacters.length].
    final count =
        (_typingText.value.clamp(0, 1) * textCharacters.length).round();

    assert(count <= textCharacters.length);
    return textWidget(textCharacters.take(count).toString());
  }
}

const Map<String, int> colorMap = {
  'aqua': 0x00FFFF,
  'black': 0x000000,
  'blue': 0x0000FF,
  'brown': 0x9A6324,
  'cream': 0xFFFDD0,
  'cyan': 0x46f0f0,
  'green': 0x00FF00,
  'gray': 0x808080,
  'grey': 0x808080,
  'mint': 0xAAFFC3,
  'lavender': 0xE6BEFF,
  'new': 0xFFFF00,
  'olive': 0x808000,
  'orange': 0xFFA500,
  'pink': 0xFFE1E6,
  'purple': 0x800080,
  'red': 0xFF0000,
  'silver': 0xC0C0C0,
  'white': 0xFFFFFF,
  'yellow': 0xFFFF00
};

Color parseColor(String color) {
//  print("parseColor: $color");
  var v = colorMap[color];
  if (v == null) {
    return Colors.red;
  } else {
//    return Color(v);
//    return Colors.green;
//    int n = Color(v);
    Color out = Color((0xff << 24) | v);
//    print("parseColor: $color => $out");
    return out;
  }
}

/// Copyright (c) 2021 Peter Alvin
/// Widget that renders a string with sub-string highlighting.
class SimpleRichText extends StatelessWidget {
  SimpleRichText(this.text,
      {this.chars,
      this.context,
      this.fussy,
      this.logIt = false,
      this.maxLines,
      this.pre,
      this.post,
      this.style = const TextStyle(),
      this.textAlign,
      this.textOverflow,
      this.textScaleFactor});

  final String? chars;

  /// For navigation
  final BuildContext? context;

  /// Throw exception if tags not closed (e.g., "this is *bold" because no closing * character)
  final bool? fussy;

  /// Pass in true for debugging/logging/trace
  final bool logIt;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// optional leading TextSpan
  final TextSpan? pre;

  /// optional trailing TextSpan
  final TextSpan? post;

  /// The {TextStyle} of the {SimpleRichText.text} that isn't highlighted.
  final TextStyle? style;

  /// The String to be displayed using rich text.
  final String text;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// How visual overflow should be handled.
  final TextOverflow? textOverflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  final double? textScaleFactor;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) {
      return Text('');
    } else {
      //print('text: $text');
      List<InlineSpan> children = [];

      if (pre != null) {
        children.add(pre!);
      }

      Set set = Set();

      bool containsNewLine = text.contains(r'\n');
      log('Contains new line: $containsNewLine');
      List<String> linesList = [];
      if (containsNewLine) {
        linesList = text.split(r'\n');
        log("lines=${linesList.length}: $linesList");
      } else {
        linesList.add(text);
      }

      // Apply modifications into all lines
      for (int k = 0; k < linesList.length; k++) {
        log('Line ${k + 1}: ${linesList[k]}');
        // split into array
        List<String> spanList =
            linesList[k].split(RegExp(chars ?? r"[*~/_\\]"));
        log("len=${spanList.length}: $spanList");

        if (spanList.length == 1) {
          log("trivial");
          if (style == null) {
            children.add(TextSpan(text: ''));
            // If no last line:
            if (k < linesList.length - 1) children.add(TextSpan(text: '\n'));
          } else {
            children.add(TextSpan(text: linesList[k], style: style));
            // If no last line:
            if (k < linesList.length - 1) children.add(TextSpan(text: '\n'));
          }
        } else {
          int i = 0;
          bool acceptNext = true;
          String? cmd;

          void wrap(String v) {
            log("wrap: $v set=$set");

            Map<String, String> map = {};

            if (cmd != null) {
              var pairs = cmd.split(';');
              for (var pair in pairs) {
                var a = pair.split(':');
                if (a.length == 2) {
                  map[a[0].trim()] = a[1].trim();
                } else {
                  throw "attribute value is missing a value (e.g., you passed {key} but not {key:value}";
                }
              }
              log("attributes: $map");
            }

            // TextDecorationStyle "values" is ignored
            TextDecorationStyle? _textDecorationStyle;
            if (map.containsKey('decorationStyle')) {
              if (map['decorationStyle'] == 'dashed')
                _textDecorationStyle = TextDecorationStyle.dashed;
              if (map['decorationStyle'] == 'double')
                _textDecorationStyle = TextDecorationStyle.double;
              if (map['decorationStyle'] == 'dotted')
                _textDecorationStyle = TextDecorationStyle.dotted;
              if (map['decorationStyle'] == 'solid')
                _textDecorationStyle = TextDecorationStyle.solid;
              if (map['decorationStyle'] == 'wavy')
                _textDecorationStyle = TextDecorationStyle.wavy;
            }

            TextStyle ts;
            ts = style!.copyWith(
              color: map.containsKey('color')
                  ? parseColor(map['color']!)
                  : style!.color,
              decoration: set.contains('_')
                  ? TextDecoration.underline
                  : TextDecoration.none,
              fontStyle:
                  set.contains('/') ? FontStyle.italic : FontStyle.normal,
              fontWeight:
                  set.contains('*') ? FontWeight.bold : FontWeight.normal,
              fontSize: map.containsKey('fontSize')
                  ? double.parse(map['fontSize']!)
                  : style!.fontSize,
              fontFamily: map.containsKey('fontFamily')
                  ? '${map['fontFamily']}'
                  : style!.fontFamily,
              backgroundColor: map.containsKey('backgroundColor')
                  ? parseColor(map['backgroundColor']!)
                  : style!.backgroundColor,
              decorationColor: map.containsKey('decorationColor')
                  ? parseColor(map['decorationColor']!)
                  : style!.decorationColor,
              decorationStyle: _textDecorationStyle ?? style!.decorationStyle,
              decorationThickness: map.containsKey('decorationThickness')
                  ? double.parse(map['decorationThickness']!)
                  : style!.decorationThickness,
              height: map.containsKey('height')
                  ? double.parse(map['height']!)
                  : style!.height,
              letterSpacing: map.containsKey('letterSpacing')
                  ? double.parse(map['letterSpacing']!)
                  : style!.letterSpacing,
              wordSpacing: map.containsKey('wordSpacing')
                  ? double.parse(map['wordSpacing']!)
                  : style!.wordSpacing,
            );

            if (map.containsKey('pop') ||
                map.containsKey('push') ||
                map.containsKey('repl') ||
                map.containsKey('http')) {
//            print("BBB cmd=$cmd");
//          GestureDetector
//        children.add(WidgetSpan(child: Text('****')));
//          children.add(WidgetSpan(
//              child: GestureDetector(
//            child: Text('CLICK'),
//            onTap: () async {
//              //print("TAPPED");
//            },
//          )));

              // assert(context != null, 'must pass context if using route links');

              children.add(TextSpan(
                  text: v,
                  // Beware!  This class is only safe because the TapGestureRecognizer is not given a deadline and therefore never allocates any resources.
                  // In any other situation -- setting a deadline, using any of the less trivial recognizers, etc -- you would have to manage the gesture recognizer's lifetime
                  // and call dispose() when the TextSpan was no longer being rendered.
                  // Since TextSpan itself is @immutable, this means that you would have to manage the recognizer from outside
                  // the TextSpan, e.g. in the State of a stateful widget that then hands the recognizer to the TextSpan.

                  style: ts));
            } else {
              children.add(TextSpan(text: v, style: ts));
            }
          }

          void toggle(String m) {
            if (m == r'\') {
              String c = linesList[k].substring(i + 1, i + 2);
              log("quote: i=$i: $c");
              wrap(c);
              acceptNext = false;
            } else {
              if (acceptNext) {
                if (set.contains(m)) {
                  log("REM: $m");
                  set.remove(m);
                } else {
                  log("ADD: $m");
                  set.add(m);
                }
              }

              acceptNext = true;
            }
          }

          for (var v in spanList) {
            log("========== $v ==========");
            cmd = null; //TRY
            if (v.isEmpty) {
              if (i < linesList[k].length) {
                String m = linesList[k].substring(i, i + 1);
                toggle(m);
                i++;
              }
            } else {
              int adv = v.length;
              if (v[0] == '{') {
                log("link: $v");
                int close = v.indexOf('}');
                if (close > 0) {
                  cmd = v.substring(1, close);
                  log("AAA cmd=$cmd");
                  v = v.substring(close + 1);
                  log("remaining: $v");
                }
              }
              wrap(v);
              i += adv;
              if (i < linesList[k].length) {
                String m = linesList[k].substring(i, i + 1);
                log("*** format: $m");
                toggle(m);
                i++;
              }
            }
          }

          if ((fussy ?? false) && set.isNotEmpty) {
            throw 'simple_rich_text: not closed: $set';
          }

          // If no last line:
          if (k < linesList.length - 1) children.add(TextSpan(text: '\n'));
        }
      }

      if (post != null) {
        children.add(post!);
      }

      return RichText(
          maxLines: this.maxLines ?? null,
          overflow: this.textOverflow ?? TextOverflow.clip,
          text: TextSpan(children: children),
          textAlign: this.textAlign ?? TextAlign.start,
          textScaleFactor:
              this.textScaleFactor ?? MediaQuery.of(context).textScaleFactor);
    } // else
  } // build

  void log(String s) {
    if (logIt) print('---- $s');
  }
} // class
