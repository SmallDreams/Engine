import 'package:flutter/material.dart';

class ImageBuilder extends StatefulWidget {
  final String? image;
  const ImageBuilder({Key? key, this.image}) : super(key: key);
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
            )
          ],
        )
      ],
    );
  }
}

class ImageBuilderMC extends StatefulWidget {
  final String? image;
  const ImageBuilderMC({Key? key, this.image}) : super(key: key);
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
            ),
          );
        }
      },
    );
  }
}
