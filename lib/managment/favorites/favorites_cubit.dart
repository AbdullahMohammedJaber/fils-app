// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
 import 'package:fils/utils/const.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/cupertino.dart';
 
import '../../core/data/response/product/item_product.dart';
import '../../core/user_case_state/coustomer/use_case_state.dart';
import '../../utils/navigation_service/navigation_server.dart';
import '../../utils/storage.dart';
import '../../utils/widget/dialog_auth.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());
  int _page = 1;
  bool _hasMore = true;
  bool _loading = false;
  final List<ProductListModel> _items = [];
  int countFav = 0;

  Future<void> getListFavorites({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(FavoritesProductsLoading());
    } else {
      if (_loading || !_hasMore) return;
    }

    _loading = true;
    final result = await UserCase().favoritesUserCase.callFavoritesList(
      pageTapBarFav,
      _page
    );
     _loading = false;
    result.handle(
      onSuccess: (data) {
        final data = result.data;

        _items.addAll(data!.data.data);
        _hasMore = data.data.meta.currentPage < data.data.meta.lastPage;
        _page++;
        countFav = data.data.meta.total;
        emit(
          FavoritesProductsLoaded(items: List.from(_items), hasMore: _hasMore),
        );
      },
      onFailed: (message) {
        emit(FavoritesProductsError(message));
      },
      onNoInternet: () {
        emit(FavoritesProductsError(StringApp.noInternet));
      },
    );
  }

  int pageTapBarFav = 0;

  void changePageTapBar({required int index}) {
    pageTapBarFav = index;
    print(pageTapBarFav);
    emit(FavoritesChangeTapBar());
    getListFavorites(refresh: true);
  }

  Future<bool> addRemoveFavorites({
    required int idProduct,
    required bool is_favorite,
    required int type,
  }) async {
    if (isLogin()) {
      if (is_favorite) {
        is_favorite = false;

        final result = await UserCase().favoritesUserCase.addRemoveFavorites(
          idProduct,
          type,
          false,
        );
        countFav--;
        emit(AddRemoveFav());
        showMessage(result.data!['message'], value: true);
       

        getListFavorites(refresh: true);

        return false;
      } else {
        is_favorite = true;

        final result = await UserCase().favoritesUserCase.addRemoveFavorites(
          idProduct,
          type,
          true,
        );
        countFav++;
        emit(AddRemoveFav());
        showMessage(  result.data!['message'], value: true);

        getListFavorites(refresh: true);
        return true;
      }
    } else {
      showDialogAuth(NavigationService.navigatorKey.currentContext!);
      return false;
    }
  }

  @override
  Future<void> close() {
    _page = 1;

    _loading = false;
    _hasMore = true;
    _loading = false;
    print('FavoritesCubit disposed');

    return super.close();
  }
}
