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

const rosa = "Rosalind";
const rob = "Robert";

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

  String? getVoice() {
    return textBank[textNumber].voice;
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

  bool? hasAnimation() {
    return textBank[textNumber].hasAnimation;
  }

  String? animationName() {
    return textBank[textNumber].animationName;
  }

  List<Speech> textBank = [
    // Name, Speech, Voice, Image
    Speech(
      characterName: "CAPTION",
      characterText: "1912, Coast of Portsmouth England",
    ),
    Speech(
      characterName: rob,
      characterText: "Are you going to just sit there?",
      voice: "speech/areyougoingtojustsitthere",
      sideCharImage: "rob",
    ),
    Speech(
      characterName: rosa,
      characterText: "As compared to what? Standing?",
      voice: "speech/ascomparedtowhat",
      sideCharImage: "rosa",
    ),

    Speech(
      characterName: rob,
      characterText: "Not standing. Rowing.",
      voice: "speech/notstanding",
      sideCharImage: "rob",
    ),
    Speech(
      characterName: rosa,
      characterText: "Rowing. I hadn't planned on it.",
      voice: "speech/rowingIhadnt",
      sideCharImage: "rosa",
    ),
    Speech(
      characterName: rob,
      characterText: "So you expect me to shoulder the burden?",
      sideCharImage: "rob",
    ),
    Speech(
      characterName: rosa,
      characterText: "No. But I do expect you to do all the rowing.",
      sideCharImage: "rosa",
    ),
    Speech(
      characterName: rob,
      characterText: "And why is that?",
      sideCharImage: "rob",
    ),
    Speech(
      characterName: rosa,
      characterText: "Coming here was /your/ idea.",
      sideCharImage: "rosa",
    ),
    Speech(
      characterName: rob,
      characterText: "My idea?",
      sideCharImage: "bear",
      hasAnimation: true,
      animationName: "idle",
    ),
    Speech(
      characterName: rosa,
      characterText:
          "I made it very clear that I don't believe in the exercise.",
      sideCharImage: "rosa",
    ),
    Speech(
      characterName: rob,
      characterText: "The rowing?",
      sideCharImage: "bear",
      hasAnimation: true,
      animationName: "fail",
    ),
    Speech(
      characterName: rosa,
      characterText: "No. I imagine that's wonderful exercise.",
    ),
    Speech(
      characterName: rob,
      characterText: "Then what?",
      sideCharImage: "bear",
      hasAnimation: true,
      animationName: "success",
    ),
    Speech(
      characterName: rosa,
      characterText: "The entire thought experiment.",
    ),
    Speech(
      characterName: rob,
      characterText: "One goes into an experiment knowing one /could/ fail.",
    ),
    Speech(
      characterName: rosa,
      characterText:
          "But one does not undertake an experiment knowing one *HAS* failed.",
    ),
    Speech(
      characterName: rob,
      characterText: "Can we get back to the rowing?",
    ),
    Speech(
      characterName: rosa,
      characterText: "I suggest you do, or we're never going to get there.",
    ),
    Speech(
      characterName: rob,
      characterText:
          "No, I mean I'd greatly appreciate it if you would assist.",
    ),
    Speech(
      characterName: rosa,
      characterText:
          "Perhaps you should ask him. I imagine he has a greater interest in getting there than I do.",
    ),
    Speech(
      characterName: rob,
      characterText: "I suppose he does...but there's no point in asking.",
    ),
    Speech(
      characterName: rosa,
      characterText: "Why not?",
    ),
    Speech(
      characterName: rob,
      characterText: "Because he /doesn't/ row.",
    ),
    Speech(
      characterName: rosa,
      characterText: "He doesn't *ROW*?",
    ),
    Speech(
      characterName: rob,
      characterText: "No. He *DOESN'T* row.",
    ),
    Speech(
      characterName: rosa,
      characterText: "Ah. I /see/ what you mean. We've arrived.",
    ),
  ];
}
