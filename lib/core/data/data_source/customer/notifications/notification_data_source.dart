import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class NotificationsDataSource {
  Future<ApiResult<Map<String, dynamic>>> getNotifications({int page});
}

class NotificationsDataSourceImpl extends NotificationsDataSource {
  DioClient dioClient;

  NotificationsDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getNotifications({
    int page = 1,
  }) async {
    return await dioClient.request(
      path: '${ApiService.notifications}?page=$page',
      method: 'GET',
    );
  }
}
