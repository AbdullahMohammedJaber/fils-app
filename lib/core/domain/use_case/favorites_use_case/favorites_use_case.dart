import 'package:fils/core/domain/reposetry/favorites/favorites_repo.dart';
import 'package:fils/core/server/result.dart';

import '../../../data/response/favorites/favorites_response.dart';

class FavoritesUseCase {
  FavoritesRepoImpl favoritesRepo;

  FavoritesUseCase(this.favoritesRepo);

  Future<ApiResult<FavoritesResponse>> callFavoritesList(int type , int page) async {
    return await favoritesRepo.getFavorites(type , page);
  }

  Future<ApiResult<Map<String, dynamic>>> addRemoveFavorites(
    int id,
    int type,
    bool isAdd,
  ) async {
    return await favoritesRepo.addRemoveFavorites(id, type, isAdd);
  }
}
