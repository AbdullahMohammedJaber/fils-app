import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/notification/notification_response.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/string.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  bool _loading = false;
  bool _hasMore = true;
  int _page = 1;
  List<Notifications> _items = [];

  Future<void> getAllNotification({bool refresh = false}) async {
    if (refresh) {
      _hasMore = true;
      _page = 1;
      _items.clear();
      emit(NotificationLoading());
    } else {
      if (_loading || !_hasMore) return;
    }
    _loading = true;
    final result = await UserCase().notificationsUserCase.getNotifications(
      page: _page,
    );
    if (result.isSuccess) {
      final data = result.data;

      _items.addAll(data!.data);
      _hasMore = data.meta.currentPage < data.meta.lastPage;
      _page++;
      emit(
        NotificationLoaded(hasMore: _hasMore, notifications: List.from(_items)),
      );
    } else if (result.isNoInternet) {
      emit(NotificationLoadingError(error: StringApp.noInternet));
    } else {
      emit(NotificationLoadingError(error: StringApp.noData));
    }
    _loading = false;
  }
}
