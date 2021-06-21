class Speech {
  String? characterName;
  String? characterText;
  String? sound;
  String? image;

  Speech(String cn, String ct, String s, String i) {
    characterName = cn;
    characterText = ct;
    sound = s;
    image = i;
  }
}

class TextConstructor1 {
  int textNumber = 0;

  static const mc = "MC";
  static const severin = "Captain Severin";
  static const catallia = "Admiral Venesca Catallia";
  static const razim = "Major Razim";
  static const tre = "Commodore Trevaux";
  static const t = "Side Character";
  static const ambience = "...";

  List<Speech> textBank = [
    // Name, Speech, Voice, Image
    Speech(severin, "Admiral! This is madness!", "silence", "severin"),
    Speech(
        severin,
        "Entering realspace so close to a planet? You'll doom us all!",
        "silence",
        "severin"),

    Speech(catallia, "A good officer commands without doubt...", "silence",
        "catallia"),
    Speech(catallia, "...and obeys without question.", "silence", "catallia"),
    Speech(razim, "Entering realspace in 3...2...1...", "silence", "razim"),
    Speech(severin, "Blessed Emperor!", "silence", "severin"),
    Speech(severin, "We're in the heart of the fight!", "silence", "severin"),
    Speech(catallia, "This is Admiral Catallia to battlegroup Silver Dawn!",
        "silence", "catallia"),
    Speech(catallia, "Form up!", "silence", "catallia"),
    Speech(ambience, "Battlegroup warping in.", "warp", "transparent"),
    Speech(severin, "Incoming enemy squadrons!", "silence", "severin"),
    Speech(catallia, "Brace for impact!", "silence", "severin"),
    Speech(severin, "We've lost the Purity Blade!", "silence", "severin"),
    Speech(
        catallia,
        "Silver Dawn to Cadian High Command. Where do you need us?",
        "silence",
        "catallia"),
    Speech(severin, "This battle is lost! We must disengage!", "silence",
        "severin_scared"),
    Speech(catallia, "Coward!", "silence", "catallia"),
    Speech(catallia, "Commissar! Do your duty!", "silence", "catallia"),
    Speech("Commisar", "As the Emperor wills!", "silence", "transparent"),
    Speech(tre, "Phalanx to Silver Dawn. This is Commodore Trevaux.", "silence",
        "trevaux"),
    Speech(tre, "Situation critical.", "silence", "trevaux"),
    Speech(tre, "Chaos forces have launched a full-scale planetstrike.",
        "silence", "trevaux"),
    Speech(tre, "They aim to destroy the pylons of the Elysion Fields.",
        "silence", "trevaux"),
    Speech(tre, "They must not succeed.", "silence", "trevaux"),
    Speech(tre, "Reinforce the position, the Phalanx will cover your back.",
        "silence", "trevaux"),
    Speech(
        tre,
        "Remain vigilant. We have reports that the Despoiler leads the assault.",
        "silence",
        "trevaux"),
    Speech(tre, "The Emperor Protects!", "silence", "trevaux"),
    Speech(catallia, "The Emperor Protects!", "silence", "catallia"),
    Speech(tre, "Silver Dawn! This is the admiral. All ahead full!", "silence",
        "catallia"),
  ];

  void nextQuestion() {
    if (textNumber < textBank.length - 1) {
      textNumber++;
    }
  }

  String? getCharacterText() {
    return textBank[textNumber].characterText;
  }

  String? getCharacterName() {
    return textBank[textNumber].characterName;
  }

  bool isFinished() {
    if (textNumber >= textBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  getNumber() {
    return textNumber;
  }

  String? getSound() {
    return textBank[textNumber].sound;
  }

  String? getImage() {
    return textBank[textNumber].image;
  }

  void reset() {
    textNumber = 0;
  }
}
