import 'package:salem_example/constructor/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:salem/salem.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final m = messages;
    return SalemChatScreen(
      messages: m,
      route: "/chatscreen",
      nextRoute: "/mainmenu",
    );
  }
}
