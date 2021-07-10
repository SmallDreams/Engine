import 'package:salem/components/visualnovel/components/core_speech.dart';

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

List<Speech> firstSpeechList = [
  Speech(),
  Speech(
    characterName: "CAPTION",
    characterText: "1912, Coast of Portsmouth England",
  ),
  Speech(
    characterName: rob,
    characterText: "Are you going to just sit there?",
    voice: "speech/areyougoingtojustsitthere",
    centerCharacterImage: "rob",
  ),
  Speech(
    characterName: rosa,
    characterText: "As compared to what? Standing?",
    voice: "speech/ascomparedtowhat",
    centerCharacterImage: "rosa",
  ),
  Speech(
    characterName: rob,
    characterText: "Not standing. Rowing.",
    voice: "speech/notstanding",
    centerCharacterImage: "rob",
  ),
  Speech(
    characterName: rosa,
    characterText: "Rowing. I hadn't planned on it.",
    voice: "speech/rowingIhadnt",
    centerCharacterImage: "rosa",
  ),
  Speech(
    characterName: rob,
    characterText: "So you expect me to shoulder the burden?",
    centerCharacterImage: "rob",
    voice: "speech/soyouexpect",
  ),
  Speech(
    characterName: rosa,
    characterText: "No. But I do expect you to do all the rowing.",
    centerCharacterImage: "rosa",
    voice: "speech/nobut",
  ),
  Speech(
    characterName: rob,
    characterText: "And why is that?",
    centerCharacterImage: "rob",
    voice: "speech/andwhyisthat",
  ),
  Speech(
    characterName: rosa,
    characterText: "Coming here was /your/ idea.",
    centerCharacterImage: "rosa",
    voice: "speech/comingherewasyouridea",
  ),
  Speech(
    characterName: rob,
    characterText: "My idea?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "idle",
    voice: "speech/myidea",
  ),
  Speech(
    characterName: rosa,
    characterText: "I made it very clear that I don't believe in the exercise.",
    centerCharacterImage: "rosa",
    voice: "speech/imadeitveryclear",
  ),
  Speech(
    characterName: rob,
    characterText: "The rowing?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    voice: "speech/therowing",
  ),
  Speech(
    characterName: rosa,
    characterText: "No. I imagine that's wonderful exercise.",
    voice: "speech/noiimagethats",
  ),
  Speech(
    characterName: rob,
    characterText: "Then what?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "success",
    voice: "speech/thenwhat",
  ),
  Speech(
    characterName: rosa,
    characterText: "The entire thought experiment.",
    voice: "speech/theentirethought",
  ),
  Speech(
    characterName: rob,
    characterText: "One goes into an experiment knowing one /could/ fail.",
    voice: "speech/onegoesinto",
  ),
  Speech(
    characterName: rosa,
    characterText:
        "But one does not undertake an experiment knowing one *HAS* failed.",
    voice: "speech/butonedoesnot",
  ),
  Speech(
    characterName: rob,
    characterText: "Can we get back to the rowing?",
    voice: "speech/canwegetback",
  ),
  Speech(
    characterName: rosa,
    characterText: "I suggest you do, or we're never going to get there.",
    voice: "speech/isuggestyoudo",
  ),
  Speech(
    characterName: rob,
    characterText: "No, I mean I'd greatly appreciate it if you would assist.",
    voice: "speech/noimeanidgreatly",
  ),
  Speech(
    characterName: rosa,
    characterText:
        "Perhaps you should ask him. I imagine he has a greater interest in getting there than I do.",
    voice: "speech/perhapsyoushouldaskhim",
  ),
  Speech(
    characterName: rob,
    characterText: "I suppose he does...but there's no point in asking.",
    voice: "speech/isupposehedoes",
  ),
  Speech(
    characterName: rosa,
    characterText: "Why not?",
    voice: "speech/whynot",
  ),
  Speech(
    characterName: rob,
    characterText: "Because he /doesn't/ row.",
    voice: "speech/becausehedosentrow",
  ),
  Speech(
    characterName: rosa,
    characterText: "He doesn't *ROW*?",
    voice: "speech/hedoesentrow",
    leftCharacterImage: "rob",
    centerCharacterImage: "rob",
    rightCharacterImage: "rosa",
  ),
  Speech(
    characterName: rob,
    cT: "No. He *DOESN'T* row.",
    voice: "speech/nohedoesentrow",
  ),
  Speech(
    characterName: rosa,
    characterText: "Ah. I /see/ what you mean. We've arrived.",
    voice: "speech/ahisee",
  ),
  Speech(
    hasChoice: true,
    firstChoice: "/choice1",
    secondChoice: "/choice2",
    thirdChoice: "/mainmenu",
  ),
];

List<Speech> secondSpeechList = [
  Speech(
    characterName: "CAPTION",
    characterText: "1912, Coast of Portsmouth England",
  ),
  Speech(
    characterName: rob,
    characterText: "Are you going to just sit there?",
    voice: "speech/areyougoingtojustsitthere",
    centerCharacterImage: "rob",
  ),
  Speech(
    characterName: rosa,
    characterText: "As compared to what? Standing?",
    voice: "speech/ascomparedtowhat",
    centerCharacterImage: "rosa",
  ),
  Speech(
    characterName: rob,
    characterText: "Not standing. Rowing.",
    voice: "speech/notstanding",
    centerCharacterImage: "rob",
  ),
  Speech(
    characterName: rosa,
    characterText: "Rowing. I hadn't planned on it.",
    voice: "speech/rowingIhadnt",
    centerCharacterImage: "rosa",
  ),
  Speech(
    characterName: rob,
    characterText: "So you expect me to shoulder the burden?",
    centerCharacterImage: "rob",
    voice: "speech/soyouexpect",
  ),
  Speech(
    characterName: rosa,
    characterText: "No. But I do expect you to do all the rowing.",
    centerCharacterImage: "rosa",
    voice: "speech/nobut",
  ),
  Speech(
    characterName: rob,
    characterText: "And why is that?",
    centerCharacterImage: "rob",
    voice: "speech/andwhyisthat",
  ),
  Speech(
    characterName: rosa,
    characterText: "Coming here was /your/ idea.",
    centerCharacterImage: "rosa",
    voice: "speech/comingherewasyouridea",
  ),
  Speech(
    characterName: rob,
    characterText: "My idea?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "idle",
    voice: "speech/myidea",
  ),
  Speech(
    characterName: rosa,
    characterText: "I made it very clear that I don't believe in the exercise.",
    centerCharacterImage: "rosa",
    voice: "speech/imadeitveryclear",
  ),
  Speech(
    characterName: rob,
    characterText: "The rowing?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "fail",
    voice: "speech/therowing",
  ),
  Speech(
    characterName: rosa,
    characterText: "No. I imagine that's wonderful exercise.",
    voice: "speech/noiimagethats",
  ),
  Speech(
    characterName: rob,
    characterText: "Then what?",
    centerCharacterImage: "bear",
    hasAnimation: true,
    animationName: "success",
    voice: "speech/thenwhat",
  ),
  Speech(
    characterName: rosa,
    characterText: "The entire thought experiment.",
    voice: "speech/theentirethought",
  ),
  Speech(
    characterName: rob,
    characterText: "One goes into an experiment knowing one /could/ fail.",
    voice: "speech/onegoesinto",
  ),
  Speech(
    characterName: rosa,
    characterText:
        "But one does not undertake an experiment knowing one *HAS* failed.",
    voice: "speech/butonedoesnot",
  ),
  Speech(
    characterName: rob,
    characterText: "Can we get back to the rowing?",
    voice: "speech/canwegetback",
  ),
  Speech(
    characterName: rosa,
    characterText: "I suggest you do, or we're never going to get there.",
    voice: "speech/isuggestyoudo",
  ),
  Speech(
    characterName: rob,
    characterText: "No, I mean I'd greatly appreciate it if you would assist.",
    voice: "speech/noimeanidgreatly",
  ),
  Speech(
    characterName: rosa,
    characterText:
        "Perhaps you should ask him. I imagine he has a greater interest in getting there than I do.",
    voice: "speech/perhapsyoushouldaskhim",
  ),
  Speech(
    characterName: rob,
    characterText: "I suppose he does...but there's no point in asking.",
    voice: "speech/isupposehedoes",
  ),
  Speech(
    characterName: rosa,
    characterText: "Why not?",
    voice: "speech/whynot",
  ),
  Speech(
    characterName: rob,
    characterText: "Because he /doesn't/ row.",
    voice: "speech/becausehedosentrow",
  ),
  Speech(
    characterName: rosa,
    characterText: "He doesn't *ROW*?",
    voice: "speech/hedoesentrow",
  ),
  Speech(
    characterName: rob,
    characterText: "No. He *DOESN'T* row.",
    voice: "speech/nohedoesentrow",
  ),
  Speech(
    characterName: rosa,
    characterText: "Ah. I /see/ what you mean. We've arrived.",
    voice: "speech/ahisee",
  ),
];
