// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/product/item_product.dart';
import 'package:fils/core/data/response/store/store_response.dart';
import 'package:fils/utils/string.dart';
import 'package:meta/meta.dart';

import '../../core/data/request/store/product_store.dart';
import '../../core/user_case_state/coustomer/use_case_state.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit() : super(StoreState());

  int _page = 1;
  bool _hasMore = true;
  bool _loading = false;
  final List<Store> _items = [];

  Future<void> fetchAllStore({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(state.copyWith(loading: true));
    } else {
      if (_loading || !_hasMore) return;
    }

    _loading = true;
    final result = await UserCase().storeUserCase.callAllStore(page: _page);
    if (result.isSuccess) {
      final data = result.data;

      _items.addAll(data!.data);
      _hasMore = data.meta.currentPage < data.meta.lastPage;
      _page++;

      emit(
        state.copyWith(
          items: List.from(_items),
          hasMore: _hasMore,
          loading: false,
        ),
      );
    }

    if (result.isFailed) {
      emit(state.copyWith(error: result.message!));
    }
    _loading = false;
  }

  Future<void> fetchTabBar({required int id}) async {
    emit(
      state.copyWith(
        loadingTabBar: true,
        error: null,
        getProductLoading: false,
        listTabBar: [],
      ),
    );
    final result = await UserCase().storeUserCase.callTabBar(id: id);

    result.handle(
      onSuccess: (data) {
        final list = data['data']['data'] as List;
        List<TabBarStore> finalList = [];
        for (int i = 0; i < list.length; i++) {
          if (i == 0) {
            emit(
              state.copyWith(
                tabBarSelect: TabBarStore(
                  select: true,
                  id: int.parse(list[i]['id'].toString()),
                  name: list[i]['name'],
                ),
              ),
            );
          }
          finalList.add(
            TabBarStore(
              select: i == 0 ? true : false,
              id: int.parse(list[i]['id'].toString()),
              name: list[i]['name'],
            ),
          );
        }

        emit(
          state.copyWith(
            loadingTabBar: false,
            listTabBar: finalList,
            error: null,
          ),
        );
        if (finalList.isNotEmpty) {
          getAllProductIntoStore(id, refresh: true);
        }
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            loadingTabBar: false,
            listTabBar: [],
            errorTabBar: StringApp.noInternet,
          ),
        );
      },
      onFailed: (message) {
        emit(
          state.copyWith(
            loadingTabBar: false,
            listTabBar: [],
            errorTabBar: message,
          ),
        );
      },
    );
  }

  functionChangeSelectTabBar(int id, int idStore) {
    for (var element in state.listTabBar!) {
      if (element.id == id) {
        element.select = true;
        emit(
          state.copyWith(
            tabBarSelect: TabBarStore(
              select: element.select,
              id: element.id,
              name: element.name,
            ),
          ),
        );
      }
    }

    getAllProductIntoStore(idStore, refresh: true);
  }

  int _pageAllProduct = 1;
  bool _hasMoreAllProduct = true;
  bool _loadingAllProduct = false;
  final List<ProductListModel> _itemsAllProduct = [];

  Future<void> getAllProductIntoStore(
    int idStore, {
    bool refresh = false,
  }) async {
    if (refresh) {
      _pageAllProduct = 1;
      _hasMoreAllProduct = true;
      _itemsAllProduct.clear();
      emit(state.copyWith(getProductLoading: true));
    } else {
      if (_loadingAllProduct || !_hasMoreAllProduct) return;
    }

    _loadingAllProduct = true;

    final result = await UserCase().storeUserCase.callProductIntoStore(
      categoryId: state.tabBarSelect!.id,
      page: _pageAllProduct,
      idStore: idStore,
    );
    emit(state.copyWith(getProductLoading: false));

    result.handle(
      onSuccess: (data) {
        final data = result.data;

        final List list = data!['data']['data'];
        for (var element in list) {
          if (int.parse(element['current_stock'].toString()) > 0) {
            _itemsAllProduct.add(ProductListModel.fromJson(element));
          }
        }

        _hasMoreAllProduct =
            data['data']['meta']['current_page'] <
            data['data']['meta']['last_page'];
        _pageAllProduct++;
        emit(
          state.copyWith(
            listProductInStore: List.from(_itemsAllProduct),
            hasMoreListAllProductStore: _hasMoreAllProduct,
          ),
        );
        _loadingAllProduct = false;
      },
      onFailed: (message) {
        _loadingAllProduct = false;
        emit(state.copyWith(errorListAllProductStore: message));
      },
      onNoInternet: () {
        _loadingAllProduct = false;

        emit(state.copyWith(errorListAllProductStore: StringApp.noInternet));
      },
    );
  }

  int _pageStoreCategory = 1;
  bool _hasMoreStoreCategory = true;
  bool _loadingStoreCategory = false;
  final List<Store> _itemsStoreCategory = [];

  Future<void> fetchAllStoreStoreCategory({
    bool refresh = false,
    required int categoryId,
  }) async {
    if (refresh) {
      _pageStoreCategory = 1;
      _hasMoreStoreCategory = true;
      _itemsStoreCategory.clear();
      emit(state.copyWith(loadingStoreCategory: true));
    } else {
      if (_loadingStoreCategory || !_hasMoreStoreCategory) return;
    }

    _loadingStoreCategory = true;
    final result = await UserCase().storeUserCase.callProductIntoStoreCategory(
      categoryId: categoryId,
    );
    if (result.isSuccess) {
      final data = result.data;

      _itemsStoreCategory.addAll(data!.data.shops.data);
      _hasMoreStoreCategory =
          data.data.shops.meta.currentPage < data.data.shops.meta.lastPage;
      _pageStoreCategory++;

      emit(
        state.copyWith(
          itemsStoreCategory: List.from(_itemsStoreCategory),
          hasMoreStoreCategory: _hasMoreStoreCategory,
          loadingStoreCategory: false,
        ),
      );
    }

    if (result.isFailed) {
      emit(state.copyWith(errorStoreCategory: result.message!));
    }
    _loadingStoreCategory = false;
  }
}
