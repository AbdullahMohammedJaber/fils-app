import 'package:fils/core/data/data_source/customer/notifications/notification_data_source.dart';
import 'package:fils/core/data/response/notification/notification_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class NotificationsRepo {
  Future<ApiResult<NotificationResponse>> getNotifications({int page});
}

class NotificationsRepoImpl extends NotificationsRepo {
  NotificationsDataSourceImpl notificationsDataSourceImpl;

  NotificationsRepoImpl(this.notificationsDataSourceImpl);

  @override
  Future<ApiResult<NotificationResponse>> getNotifications({
    int page = 1,
  }) async {
    final result = await notificationsDataSourceImpl.getNotifications(
      page: page,
    );
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      NotificationResponse notificationResponse = NotificationResponse.fromJson(
        result.data!,
      );
      return ApiResult.success(notificationResponse, statusCode: 200);
    } else {
      return ApiResult.failed(
        message: result.data!['message'],
        statusCode: result.statusCode,
      );
    }
  }
}
