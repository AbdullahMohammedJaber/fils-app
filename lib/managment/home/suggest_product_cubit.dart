import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fils/core/data/response/product/item_product.dart';
 
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/string.dart';
 import 'package:meta/meta.dart';

part 'suggest_product_state.dart';

class SuggestProductCubit extends Cubit<SuggestProductState> {
  SuggestProductCubit() : super(SuggestProductInitial());

  int _page = 1;
  bool _hasMore = true;
  bool _loading = false;
  final List<ProductListModel> _items = [];
  CancelToken? _homeCancelToken;

  Future<void> fetch({bool refresh = false}) async {
    _homeCancelToken = CancelToken();
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(SuggestedProductsLoading());
    } else {
      if (_loading || !_hasMore) return;
    }

    _loading = true;

    final result = await UserCase().homeUserCase.callSuggestProduct(
      page: _page,
      cancelToken: _homeCancelToken!,
    );

    if (result.isSuccess) {
      final data = result.data;

      _items.addAll(data!.data.data);
      _hasMore = data.data.meta.currentPage < data.data.meta.lastPage;
      _page++;

      emit(
        SuggestedProductsLoaded(items: List.from(_items), hasMore: _hasMore),
      );
    }
   if(result.isNoInternet){
      emit(SuggestedProductsError(StringApp.noInternet));
   }
    if (result.isFailed) {
      emit(SuggestedProductsError(result.message!));
    }
    _loading = false;
  }
  void cancelHomeRequest() {

    if (_homeCancelToken != null &&
        !_homeCancelToken!.isCancelled) {
      _homeCancelToken!.cancel('Home screen disposed');
    }
  }
  @override
  Future<void> close() {
    cancelHomeRequest();
    _page = 1;

    _loading = false;
    _hasMore = true;
    _loading = false;

    return super.close();
  }
}
