// Copyright (c) 2021 The SmallDreams Authors.

class Speech {
  /// 'characterName' defines the name for all characters
  ///
  /// Example:
  /// characterName: "Tom",
  ///
  /// For a more ease of use you can even call a const you defined at the top of the page.
  ///
  /// Example:
  /// const t = "Tom";
  /// characterName: t,
  final String? characterName;

  /// 'characterText' defines the written text which the character says.
  ///
  /// Example:
  /// characterText: "This is a example.",
  // todo: add docs for translation
  final String? characterText;

  /// 'voice' defines the file name of the spoken audio, which you defined in the assets.
  ///
  /// Example:
  /// voice: "audiofilename",
  final String? voice;

  /// 'mcImage' defines the file name of the MC, which you defined in the assets.
  /// This Image is ALWAYS in the bottom right corner and only visible on Desktop
  /// or mobile if you defined it so, by setting the phone orientation.
  final String? mcImage;

  final String? centerCharacterImage;
  final String? leftCharacterImage;
  final String? rightCharacterImage;
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
    this.centerCharacterImage,
    this.leftCharacterImage,
    this.rightCharacterImage,
    this.cgImg,
    this.bgImage,
    this.nextScene,
    this.hasAnimation = false,
    this.animationName,
  });
}
