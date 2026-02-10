import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class FavoritesDataSource {
  Future<ApiResult<Map<String, dynamic>>> getFavorites(int type,int page);

  Future<ApiResult<Map<String, dynamic>>> addRemoveFavorites(
    int id,
    int type,
    bool isAdd,
  );
}

class FavoritesDataSourceImpl extends FavoritesDataSource {
  final DioClient dioClient;

  FavoritesDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getFavorites(int type , int page) async {
    return dioClient.request<Map<String, dynamic>>(
      path: '${ApiService.favorites}?is_auction=$type&page=$page',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addRemoveFavorites(
    int id,
    int type,
    bool isAdd,
  ) async {
    return dioClient.request<Map<String, dynamic>>(
      path:
          '${isAdd ? ApiService.favoritesAdd : ApiService.favoritesRemove}/$id?is_auction=$type',
      method: 'GET',
    );
  }
}
