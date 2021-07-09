// Copyright (c) 2021 The SmallDreams Authors.

class Speech {
  final String? characterName;
  final String? characterText;
  final String? voice;
  final String? mcImage;
  final String? sideCharImage;
  final String? minorCharImage;
  final String? cgImg;
  final String? bgImage;
  final nextScene;
  final hasAnimation;
  final animationName;

  Speech({
    this.characterName,
    this.characterText,
    this.voice,
    this.mcImage,
    this.sideCharImage,
    this.minorCharImage,
    this.cgImg,
    this.bgImage,
    this.nextScene,
    this.hasAnimation = false,
    this.animationName,
  });
}
