import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/haraj/haraj_response.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/string.dart';
 
part 'haraj_home_state.dart';

class HarajHomeCubit extends Cubit<HarajHomeState> {
  HarajHomeCubit() : super(HarajHomeState(products: []));

  
  bool _hasMore = false;
  bool _loading = false;
  int _page = 1;
  List<MarketOpenResponse> _items = [];

  Future<void> getAllHaraj({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(state.copyWith(loading: true));
    } else {
      if (_loading || !_hasMore) return;
    }
    _loading = true;
    final result = await UserCase().harajUserCase.getAllHaraj(page: _page);
    emit(state.copyWith(loading: false));
    _loading = false;

    result.handle(
      onSuccess: (data) {
        final data = result.data;
        _items.addAll(data!.data!);
        _hasMore = data.meta!.currentPage < data.meta!.lastPage;
        _page++;
        emit(state.copyWith(product: List.from(_items), hasMore: _hasMore));
      },
      onFailed: (message) {
        emit(state.copyWith(error: message, loading: false));
      },
      onNoInternet: () {
        emit(state.copyWith(error: StringApp.noInternet, loading: false));
      },
    );
  }

}
