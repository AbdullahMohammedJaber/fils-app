import 'package:bloc/bloc.dart';
 import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:meta/meta.dart';

import '../../core/data/response/chat_bot/chat_bot_model.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotState());

  List<ChatBotModel> _list = [];

  Future<void> sendBot({required String message}) async {
    if (message.isNotEmpty) {
      _list.insert(
        0,
        ChatBotModel(
          id: 1,
          isSeen: false,
          message: message,
          create_at: DateTime.now(),
        ),
      );
      _list.insert(
        0,
        ChatBotModel(
          id: 0,
          isSeen: false,
          message: "",
          create_at: DateTime.now(),
        ),
      );
      emit(state.copyWith(loading: true, chatList: List.from(_list)));
      final result = await UserCase().botUserCase.sendMessage(message: message);
      result.handle(
        onSuccess: (data) {
          state.chatList![0].isSeen = true;
          state.chatList![0].message = result.data!['data'];
          emit(state.copyWith(loading: false));
        },
        onNoInternet: () {
          state.chatList!.removeAt(0);
          emit(state.copyWith(loading: false));
        },
        onFailed: (message) {
          state.chatList!.removeAt(0);

          emit(state.copyWith(loading: false));
        },
      );
    }
  }
}
