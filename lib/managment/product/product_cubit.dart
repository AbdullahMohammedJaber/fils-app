import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/data/response/product/item_product.dart';
import '../../core/user_case_state/coustomer/use_case_state.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  int _page = 1;
  bool _hasMore = true;
  bool _loading = false;
  final List<ProductListModel> _items = [];

  Future<void> fetch({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(ProductAllLoading());
    } else {
      if (_loading || !_hasMore) return;
    }

    _loading = true;

    final result = await UserCase().homeUserCase.callAllProducts(page: _page);

    if (result.isSuccess) {
      final data = result.data;
       for (var element in data!.data) {
          if (int.parse(element.current_stock.toString()) > 0) {
            _items.add( element );
          }
        }
    
      _hasMore = data.meta.currentPage < data.meta.lastPage;
      _page++;

      emit(ProductAllLoaded(items: List.from(_items), hasMore: _hasMore));
    }

    if (result.isFailed) {
      emit(ProductAllError(error: result.toString()));
    }
    _loading = false;
  }
}
