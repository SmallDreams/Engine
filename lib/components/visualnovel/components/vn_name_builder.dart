import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VNNameBuilder extends StatefulWidget {
  final characterCardOpacity;
  final characterCardColor;
  final characterName;
  final characterFontFamily;
  final characterFontSize;
  final characterFontColor;
  VNNameBuilder({
    Key? key,
    this.characterCardOpacity,
    this.characterCardColor,
    this.characterName,
    this.characterFontFamily,
    this.characterFontSize,
    this.characterFontColor,
  });
  @override
  _VNNameBuilderState createState() => _VNNameBuilderState();
}

class _VNNameBuilderState extends State<VNNameBuilder> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((nameValue) => {
          setState(() {
            _name = nameValue.getString('name') ?? 'MC';
          })
        });
  }

  String? _name = "MC";
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (widget.characterName == "MC") {
          return Opacity(
            opacity: widget.characterCardOpacity ?? 0.8,
            child: Card(
              color: widget.characterCardColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                child: Text(
                  "$_name",
                  style: TextStyle(
                    fontFamily: widget.characterFontFamily,
                    fontSize: widget.characterFontSize ?? 20,
                    color: widget.characterFontColor ?? Colors.black,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Opacity(
            opacity: widget.characterCardOpacity ?? 0.8,
            child: Card(
              color: widget.characterCardColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                child: Text(
                  widget.characterName ?? "Side Character",
                  style: TextStyle(
                    fontFamily: widget.characterFontFamily,
                    fontSize: widget.characterFontSize ?? 20,
                    color: widget.characterFontColor ?? Colors.black,
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
