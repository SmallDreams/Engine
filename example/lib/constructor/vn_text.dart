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
  static const t = "Side Character";

  List<Speech> textBank = [
    // Name, Speech, Voice, Image
    Speech(mc, "HELLO WORLD", "silence", "Cast/MC_Neutral"),
    Speech(mc, "This is a random text.", "silence", "Cast/MC_Blush"),

    Speech(mc, "Some more random text.", "silence", "Cast/MC_Happy"),
    Speech(t, "This is char2 ", "silence", "tom_neutral"),
    Speech(
        t,
        "Yesterday, the Affordable Care Act (ACA) nabbed its third 'You may pass Go' card from the Supreme Court. In a 7–2 vote, justices ruled that Texas and 17 other Republican-led states don't have the legal standing to challenge the law in federal court.",
        "silence",
        "tom_neutral"),
    Speech(
        t,
        "The ACA, aka 'Obamacare', is a controversial healthcare bill enacted in 2010. It's known for adding protections for individuals with preexisting conditions, allowing young adults to remain on their parents' plan until age 26, and making preventative services (including birth control on private plans) free.",
        "silence",
        "tom_neutral"),
    Speech(
        t,
        "With their 6–3 majority on the court, some conservatives hoped this case might finally find the fatal chink in the ACA's legal armor. Although they fell short again, each major legal challenge threatens serious disruption to the healthcare industry and the 31+ million Americans who get their insurance through the ACA.",
        "silence",
        "transparent"),
    Speech(
        "BOY",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "silence",
        "hidetake_neutral"),
    Speech(
        "GIRL",
        """This is considered an error condition because it indicates that there is content that cannot be
seen. If the content is legitimately bigger than the available space, consider clipping it with a
ClipRect widget before putting it in the flex, or using a scrollable container rather than a Flex,
like a ListView.""",
        "silence",
        "hidetake_neutral"),
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
