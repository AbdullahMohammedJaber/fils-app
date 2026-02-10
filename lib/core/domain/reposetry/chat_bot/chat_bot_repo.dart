import 'package:fils/core/data/data_source/customer/chat_bot/bot_data_source.dart';
import 'package:fils/utils/string.dart';

import '../../../server/result.dart';

abstract class ChatBotRepo {
  Future<ApiResult<Map<String, dynamic>>> sendMessage({
    required String message,
  });
}

class ChatBotRepoImpl extends ChatBotRepo {
  ChatBotDataSourceImpl chatBotDataSourceImpl;

  ChatBotRepoImpl(this.chatBotDataSourceImpl);

  @override
  Future<ApiResult<Map<String, dynamic>>> sendMessage({
    required String message,
  }) async {
    final result = await chatBotDataSourceImpl.sendMessage(message: message);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      return ApiResult.success(result.data!);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }
}
