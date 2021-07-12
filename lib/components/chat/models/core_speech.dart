part of salem_engine;

class ChatMessage {
  String messageContent;
  String messageType;
  final isVisible;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
    this.isVisible = false,
  });
}
