import 'package:salem/salem.dart';

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

const rosa = "Rosa";
const rob = "Robert";

List<SalemSpeech> firstSpeechList = [
  SalemSpeech(),
  SalemSpeech(
    characterName: "CAPTION",
    characterText: "1912, Coast of Portsmouth England",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Are you going to just sit there?",
    voice: "Speech/areyougoingtojustsitthere",
    centerCharacterImage: "rob",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "As compared to what? Standing?",
    voice: "Speech/ascomparedtowhat",
    centerCharacterImage: "rosa",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Not standing. Rowing.",
    voice: "Speech/notstanding",
    centerCharacterImage: "rob",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Rowing. I hadn't planned on it.",
    voice: "Speech/rowingIhadnt",
    centerCharacterImage: "rosa",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "So you expect me to shoulder the burden?",
    centerCharacterImage: "rob",
    voice: "Speech/soyouexpect",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "No. But I do expect you to do all the rowing.",
    centerCharacterImage: "rosa",
    voice: "Speech/nobut",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "And why is that?",
    centerCharacterImage: "rob",
    voice: "Speech/andwhyisthat",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Coming here was /your/ idea.",
    centerCharacterImage: "rosa",
    voice: "Speech/comingherewasyouridea",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "My idea?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "idle",
    voice: "Speech/myidea",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "I made it very clear that I don't believe in the exercise.",
    centerCharacterImage: "rosa",
    voice: "Speech/imadeitveryclear",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "The rowing?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    voice: "Speech/therowing",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "No. I imagine that's wonderful exercise.",
    voice: "Speech/noiimagethats",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Then what?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "success",
    voice: "Speech/thenwhat",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "The entire thought experiment.",
    voice: "Speech/theentirethought",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "One goes into an experiment knowing one /could/ fail.",
    voice: "Speech/onegoesinto",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText:
        "But one does not undertake an experiment knowing one *HAS* failed.",
    voice: "Speech/butonedoesnot",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Can we get back to the rowing?",
    voice: "Speech/canwegetback",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "I suggest you do, or we're never going to get there.",
    voice: "Speech/isuggestyoudo",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "No, I mean I'd greatly appreciate it if you would assist.",
    voice: "Speech/noimeanidgreatly",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText:
        "Perhaps you should ask him. I imagine he has a greater interest in getting there than I do.",
    voice: "Speech/perhapsyoushouldaskhim",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "I suppose he does...but there's no point in asking.",
    voice: "Speech/isupposehedoes",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Why not?",
    voice: "Speech/whynot",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Because he /doesn't/ row.",
    voice: "Speech/becausehedosentrow",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "He doesn't *ROW*?",
    voice: "Speech/hedoesentrow",
    leftCharacterImage: "rob",
    centerCharacterImage: "rob",
    rightCharacterImage: "rosa",
  ),
  SalemSpeech(
    characterName: rob,
    cT: "No. He *DOESN'T* row.",
    voice: "Speech/nohedoesentrow",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Ah. I /see/ what you mean. We've arrived.",
    voice: "Speech/ahisee",
  ),
  SalemSpeech(
    hasChoice: true,
    firstChoice: "/choice1",
    secondChoice: "/choice2",
    thirdChoice: "/mainmenu",
  ),
];

List<SalemSpeech> secondSpeechList = [
  SalemSpeech(
    characterName: "CAPTION",
    characterText: "1912, Coast of Portsmouth England",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Are you going to just sit there?",
    voice: "Speech/areyougoingtojustsitthere",
    centerCharacterImage: "rob",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "As compared to what? Standing?",
    voice: "Speech/ascomparedtowhat",
    centerCharacterImage: "rosa",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Not standing. Rowing.",
    voice: "Speech/notstanding",
    centerCharacterImage: "rob",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Rowing. I hadn't planned on it.",
    voice: "Speech/rowingIhadnt",
    centerCharacterImage: "rosa",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "So you expect me to shoulder the burden?",
    centerCharacterImage: "rob",
    voice: "Speech/soyouexpect",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "No. But I do expect you to do all the rowing.",
    centerCharacterImage: "rosa",
    voice: "Speech/nobut",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "And why is that?",
    centerCharacterImage: "rob",
    voice: "Speech/andwhyisthat",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Coming here was /your/ idea.",
    centerCharacterImage: "rosa",
    voice: "Speech/comingherewasyouridea",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "My idea?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "idle",
    voice: "Speech/myidea",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "I made it very clear that I don't believe in the exercise.",
    centerCharacterImage: "rosa",
    voice: "Speech/imadeitveryclear",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "The rowing?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "fail",
    voice: "Speech/therowing",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "No. I imagine that's wonderful exercise.",
    voice: "Speech/noiimagethats",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Then what?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "success",
    voice: "Speech/thenwhat",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "The entire thought experiment.",
    voice: "Speech/theentirethought",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "One goes into an experiment knowing one /could/ fail.",
    voice: "Speech/onegoesinto",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText:
        "But one does not undertake an experiment knowing one *HAS* failed.",
    voice: "Speech/butonedoesnot",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Can we get back to the rowing?",
    voice: "Speech/canwegetback",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "I suggest you do, or we're never going to get there.",
    voice: "Speech/isuggestyoudo",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "No, I mean I'd greatly appreciate it if you would assist.",
    voice: "Speech/noimeanidgreatly",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText:
        "Perhaps you should ask him. I imagine he has a greater interest in getting there than I do.",
    voice: "Speech/perhapsyoushouldaskhim",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "I suppose he does...but there's no point in asking.",
    voice: "Speech/isupposehedoes",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Why not?",
    voice: "Speech/whynot",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "Because he /doesn't/ row.",
    voice: "Speech/becausehedosentrow",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "He doesn't *ROW*?",
    voice: "Speech/hedoesentrow",
  ),
  SalemSpeech(
    characterName: rob,
    characterText: "No. He *DOESN'T* row.",
    voice: "Speech/nohedoesentrow",
  ),
  SalemSpeech(
    characterName: rosa,
    characterText: "Ah. I /see/ what you mean. We've arrived.",
    voice: "Speech/ahisee",
  ),
];
