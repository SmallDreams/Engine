// // Primary
// import 'package:dart_vlc/dart_vlc.dart';
// import 'package:salem/core/audio/gameAudio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io' show Platform;
// import 'package:flutter/material.dart';

// class MainMenu extends StatefulWidget {
//   final mainMenuBGM;
//   MainMenu({this.mainMenuBGM});
//   @override
//   _BaseScreenState createState() => _BaseScreenState();
// }

// /// The main widget state.
// class _BaseScreenState extends State<MainMenu> {
//   double? opacity = 0.0;

//   SharedPreferences? sharedPreferences;
//   String? getPersistBGM;
//   @override
//   void initState() {
//     super.initState();

//     GameAudio.playAudio.play(widget.mainMenuBGM);

//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         opacity = 1.0;
//       });
//     });
//     SharedPreferences.getInstance().then((SharedPreferences sp) {
//       sharedPreferences = sp;
//       getPersistBGM = sharedPreferences!.getString("getPersistBGM");
//       getPersistBGM = widget.mainMenuBGM;
//       persistBGM(getPersistBGM!);
//       print(getPersistBGM);
//     });
//   }

//   void persistBGM(String value) {
//     setState(() {
//       getPersistBGM = value;
//     });
//     sharedPreferences?.setString("getPersistBGM", value);
//   }

//   @override
//   void didChangeDependencies() {
//     if (Platform.isWindows || Platform.isLinux) {
//       super.didChangeDependencies();
//       GameAudioDesktop.playDesktopAudio.player = Player(
//         id: 0,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => getOnWillPop(),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(
//                       "assets/images/bgs/mininature_001_19201440.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             AnimatedOpacity(
//               opacity: opacity!,
//               duration: Duration(milliseconds: 300),
//               child: Center(
//                 child: Container(
//                   child: SafeArea(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 5),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: ElevatedButton(
//                                 child: Text(
//                                   "START",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 40,
//                                       fontFamily: "Julee"),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.white,
//                                     padding: EdgeInsets.symmetric(vertical: 20),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(40.0),
//                                         side: BorderSide(color: Colors.white))),
//                                 onPressed: () {
//                                   Navigator.of(context).pushNamed('/intro');
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 5),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: ElevatedButton(
//                                 child: Text(
//                                   "LOAD",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 35,
//                                       fontFamily: "Julee"),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.white,
//                                     padding: EdgeInsets.symmetric(vertical: 20),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(40.0),
//                                         side: BorderSide(color: Colors.white))),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => LoadGame()),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 5),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: ElevatedButton(
//                                 child: Text(
//                                   "OPTIONS",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 35,
//                                       fontFamily: "Julee"),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.white,
//                                     padding: EdgeInsets.symmetric(vertical: 20),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(40.0),
//                                         side: BorderSide(color: Colors.white))),
//                                 onPressed: () => Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Settings(
//                                             route: "/home",
//                                           )),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 5),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width / 3,
//                               child: ElevatedButton(
//                                 child: Text(
//                                   "CREDITS",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: 35,
//                                       fontFamily: "Julee"),
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                     primary: Colors.white,
//                                     padding: EdgeInsets.symmetric(vertical: 20),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(40.0),
//                                         side: BorderSide(color: Colors.white))),
//                                 onPressed: () => Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Credits()),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showAlertDialog(BuildContext context) {
//     // set up the button
//     Widget okButton = TextButton(
//       child: Text("Okay."),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       contentPadding: EdgeInsets.all(5),
//       backgroundColor: Colors.white,
//       title: Text(
//         "Not available",
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 28),
//       ),
//       content: Text(
//         "Sorry! Currently not available.",
//         textAlign: TextAlign.center,
//         style: TextStyle(),
//       ),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }

// Widget _buttons(context) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//     child: Container(
//       width: MediaQuery.of(context).size.width / 3,
//       child: ElevatedButton(
//         child: Text(
//           "CREDITS",
//           style:
//               TextStyle(color: Colors.black, fontSize: 35, fontFamily: "Julee"),
//         ),
//         style: ElevatedButton.styleFrom(
//             primary: Colors.white,
//             padding: EdgeInsets.symmetric(vertical: 20),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40.0),
//                 side: BorderSide(color: Colors.white))),
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Credits()),
//         ),
//       ),
//     ),
//   );
// }
