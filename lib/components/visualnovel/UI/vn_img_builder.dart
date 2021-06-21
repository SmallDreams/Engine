import 'package:flutter/material.dart';

class ImageBuilder extends StatefulWidget {
  final String? image;
  const ImageBuilder({this.image});
  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: UniqueKey(),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/sprites/" + widget.image! + ".png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 1,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Center(
                    child: Text("Here should be a Sprite."),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}

class ImageBuilderMC extends StatefulWidget {
  final String? image;
  const ImageBuilderMC({this.image});
  @override
  _ImageBuilderMCState createState() => _ImageBuilderMCState();
}

class _ImageBuilderMCState extends State<ImageBuilderMC> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Builder(
      builder: (context) {
        if (height < 700) {
          return Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/sprites/" + widget.image! + ".png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 1.4,
              key: UniqueKey(),
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Center(
                    child: Text("Here should be a Sprite."),
                  ),
                );
              },
            ),
          );
        } else {
          return Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/sprites/" + widget.image! + ".png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 2,
              key: UniqueKey(),
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Center(
                    child: Text("Here should be a Sprite."),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
