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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(
            side: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.5, horizontal: 15.5),
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
                fontSize: 32.5,
                letterSpacing: 1.5,
                //fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ));
  }
}
