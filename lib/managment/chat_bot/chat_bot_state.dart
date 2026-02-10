part of 'chat_bot_cubit.dart';

@immutable
class ChatBotState {
  final List<ChatBotModel>? chatList;
  final bool loading;
  final String? error;

  const ChatBotState({this.chatList, this.loading = true, this.error});

  ChatBotState copyWith({
    bool? loading,
    String? error,
    List<ChatBotModel>? chatList,
  }) {
    return ChatBotState(
      loading: loading ?? this.loading,
      error: error,
      chatList: chatList ?? this.chatList,
    );
  }
}
