import 'package:fils/core/data/data_source/customer/favorites/favorites_data_source.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

import '../../../data/response/favorites/favorites_response.dart';

abstract class FavoritesRepo {
  Future<ApiResult<FavoritesResponse>> getFavorites(int type , int page);

  Future<ApiResult<Map<String, dynamic>>> addRemoveFavorites(
    int id,
    int type,
    bool isAdd,
  );
}

class FavoritesRepoImpl extends FavoritesRepo {
  FavoritesDataSourceImpl favoritesDataSource;

  FavoritesRepoImpl(this.favoritesDataSource);

  @override
  Future<ApiResult<FavoritesResponse>> getFavorites(int type,int page) async {
    final result = await favoritesDataSource.getFavorites(type , page);

    if (result.isSuccess &&
        result.statusCode == 200 &&
        (result.data!['status'] == 200 || result.data!['code'] == 200)) {
      final fav = FavoritesResponse.fromMap(result.data!);
      return ApiResult.success(fav);
    } else if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: result.message,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addRemoveFavorites(
    int id,
    int type,
    bool isAdd,
  ) async {
    final result = await favoritesDataSource.addRemoveFavorites(
      id,
      type,
      isAdd,
    );
    if (result.isSuccess && result.statusCode == 200) {
      return ApiResult.success(result.data!);
    } else if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: result.message,
      );
    }
  }
}
