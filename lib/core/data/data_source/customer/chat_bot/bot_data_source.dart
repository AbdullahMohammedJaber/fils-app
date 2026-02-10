import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class ChatBotDataSource {
  Future<ApiResult<Map<String, dynamic>>> sendMessage({required String message});
}

class ChatBotDataSourceImpl extends ChatBotDataSource {
  DioClient dioClient;

  ChatBotDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> sendMessage({
    required String message,
  }) async {
    return await dioClient.request(
      path: ApiService.chatBot,
      method: 'POST',
      data: {"message": message},
    );
  }
}
