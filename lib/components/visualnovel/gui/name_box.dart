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
                  color: Colors.white.withOpacity(0.7),
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
                color: Colors.white.withOpacity(1),
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              child: Text(
                widget.characterName ?? "Character Name",
                style: TextStyle(
                  fontFamily: widget.vnNameFont,
                  fontSize: 28.5,
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
