class ChatBotModel {
  dynamic id;
  bool isSeen;
  String message;
  DateTime create_at;

  ChatBotModel({
    required this.id,
    required this.isSeen,
    required this.message,
    required this.create_at,
  });
}
