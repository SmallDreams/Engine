import 'package:salem/components/visualnovel/components/coreSpeech.dart';

/* 
  API REFERENCE: https://pub.dev/documentation/simple_rich_text/latest/simple_rich_text/SimpleRichText-class.html
  Formating
  Format Character       Format Effect          Example
  asterisk (*)      =    bold             =     "this is *bold*"
  slash (/)         =    italics          =     "this is /italicized/"
  underscore (_)    =    underline        =     "this is _underlined_"
  Coloring
  {color:INSERTCOLOR} =  "this makes the name {color:blue}bob blue"
  Color Map: https://pub.dev/documentation/simple_rich_text/latest/simple_rich_text/colorMap-constant.html
*/

const mc = "MC";
const t = "Side Character";

class TextConstructor1 {
  int textNumber = 0;

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

  String? getMCImage() {
    return textBank[textNumber].mcImage;
  }

  String? getSideCharImage() {
    return textBank[textNumber].sideCharImage;
  }

  void reset() {
    textNumber = 0;
  }

  String? getBGM() {
    return "thefleet";
  }

  String? getBgImage() {
    return "mininature_003_y_19201440";
  }

  List<Speech> textBank = [
    // Name, Speech, Voice, Image
    Speech(
      characterName: mc,
      characterText: "…Okay.",
      mcImage: "tom_neutral",
    ),
    Speech(
      characterName: mc,
      characterText: "HELLO WORLD",
      mcImage: "tom_neutral",
    ),
    Speech(
      characterName: mc,
      characterText: "This is a random text.",
      mcImage: "tom_neutral",
    ),

    Speech(
      characterName: mc,
      characterText: "Some more random text.",
      mcImage: "transparent",
    ),
    Speech(
        characterName: t,
        characterText: "This is char2 ",
        mcImage: "transparent"),
    Speech(
        characterName: t,
        characterText:
            "Yesterday, the Affordable Care Act (ACA) nabbed its third 'You may pass Go' card from the Supreme Court. In a 7–2 vote, justices ruled that Texas and 17 other Republican-led states don't have the legal standing to challenge the law in federal court.",
        sideCharImage: "transparent"),
    Speech(
        characterName: t,
        characterText:
            "The ACA, aka 'Obamacare', is a controversial healthcare bill enacted in 2010. It's known for adding protections for individuals with preexisting conditions, allowing young adults to remain on their parents' plan until age 26, and making preventative services (including birth control on private plans) free.",
        sideCharImage: "tom_neutral"),
    Speech(
        characterName: t,
        characterText:
            "With their 6–3 majority on the court, some conservatives hoped this case might finally find the fatal chink in the ACA's legal armor. Although they fell short again, each major legal challenge threatens serious disruption to the healthcare industry and the 31+ million Americans who get their insurance through the ACA.",
        sideCharImage: "transparent"),
    Speech(
        characterName: "BOY",
        characterText:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        sideCharImage: "hidetake_neutral"),
    Speech(
        characterName: "GIRL",
        characterText:
            """This is considered an error condition because it indicates that there is content that cannot be
seen. If the content is legitimately bigger than the available space, consider clipping it with a
ClipRect widget before putting it in the flex, or using a scrollable container rather than a Flex,
like a ListView.""",
        sideCharImage: "hidetake_neutral"),
  ];
}
