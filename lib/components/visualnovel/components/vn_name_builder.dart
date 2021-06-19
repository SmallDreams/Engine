import 'package:flutter/material.dart';

class VNNameBuilder extends StatelessWidget {
  final characterCardOpacity;
  final characterCardColor;
  final characterName;
  final characterFontFamily;
  final characterFontSize;
  final characterFontColor;
  VNNameBuilder(
      {this.characterCardOpacity,
      this.characterCardColor,
      this.characterName,
      this.characterFontFamily,
      this.characterFontSize,
      this.characterFontColor});

  String? _name = "MC";
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (characterName == "MC") {
          return Opacity(
            opacity: characterCardOpacity ?? 0.8,
            child: Card(
              color: characterCardColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                child: Text(
                  "$_name",
                  style: TextStyle(
                    fontFamily: characterFontFamily,
                    fontSize: characterFontSize ?? 20,
                    color: characterFontColor ?? Colors.black,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Opacity(
            opacity: characterCardOpacity ?? 0.8,
            child: Card(
              color: characterCardColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                child: Text(
                  characterName ?? "Side Character",
                  style: TextStyle(
                    fontFamily: characterFontFamily,
                    fontSize: characterFontSize ?? 20,
                    color: characterFontColor ?? Colors.black,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
