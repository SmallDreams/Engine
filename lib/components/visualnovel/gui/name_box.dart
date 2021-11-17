import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameBox extends StatefulWidget {
  final characterName;
  final String? vnNameFont;
  NameBox({
    this.characterName,
    this.vnNameFont,
  });
  @override
  _NameBoxState createState() => _NameBoxState();
}

class _NameBoxState extends State<NameBox> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((pref) => {
          setState(() {
            _name = pref.getString('name') ?? 'MC';
          })
        });
  }

  String? _name;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.characterName == "MC" ||
            widget.characterName == "Narrator") {
          return Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                child: Text(
                  "$_name ?? MC Name",
                  style: TextStyle(
                    fontFamily: widget.vnNameFont,
                    fontSize: 28.5,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              child: Text(
                widget.characterName ?? "Character Name",
                style: TextStyle(
                  // shadows: <Shadow>[
                  //   Shadow(
                  //     offset: Offset(1, 2),
                  //     blurRadius: 0,
                  //     color: Colors.black,
                  //   ),
                  //   Shadow(
                  //     offset: Offset(2.0, 1),
                  //     blurRadius: 0,
                  //     color: Colors.black,
                  //   ),
                  // ],
                  fontFamily: widget.vnNameFont,
                  fontSize: 29.5,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
