import 'package:fils/core/data/response/notification/notification_response.dart';
import 'package:fils/core/domain/reposetry/notifications/notifications_repo.dart';
import 'package:fils/core/server/result.dart';

class NotificationUseCase {
  NotificationsRepoImpl notificationsRepoImpl;

  NotificationUseCase(this.notificationsRepoImpl);

  Future<ApiResult<NotificationResponse>> getNotifications({
    int page = 1,
  }) async {
    return await notificationsRepoImpl.getNotifications(page: page);
  }
}
