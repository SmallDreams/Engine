// import 'package:bubble/bubble.dart';
// import 'package:flutter/material.dart';
// import 'package:salem/components/visualnovel/models/text_animation.dart';
// import 'package:salem/components/visualnovel/vn_constructor.dart';

// class TextCardBubble extends StatefulWidget {
//   @override
//   _TextCardBubbleState createState() => _TextCardBubbleState();
// }

// class _TextCardBubbleState extends State<TextCardBubble> {
//   @override
//   Widget build(BuildContext context) {
//     return Bubble(
//       margin: BubbleEdges.only(top: 10, left: 10, right: 100),
//       padding: BubbleEdges.all(0),
//       elevation: 0,
//       alignment: Alignment.topLeft,
//       nip: BubbleNip.leftBottom,
//       color: Theme.of(context).cardColor,
//       child: AnimatedTextKit(
//         isRepeatingAnimation: true,
//         animatedTexts: [
//           TyperAnimatedText(
//             " ·  ·  · ",
//             textAlign: TextAlign.left,
//             textStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 17,
//             ),
//             speed: Duration(milliseconds: 50),
//           ),
//         ],
//       ),
//     );
//   }
// }
