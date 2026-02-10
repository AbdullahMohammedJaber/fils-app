import 'package:fils/core/domain/reposetry/chat_bot/chat_bot_repo.dart';

import '../../../server/result.dart';

class ChatBotUseCase {
  ChatBotRepoImpl chatBotRepoImpl;

  ChatBotUseCase(this.chatBotRepoImpl);

  Future<ApiResult<Map<String, dynamic>>> sendMessage({
    required String message,
  }) async {
    return await chatBotRepoImpl.sendMessage(message: message);
  }
}
