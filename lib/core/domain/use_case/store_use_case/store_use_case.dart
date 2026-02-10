import 'package:fils/core/data/response/store/store_response.dart';
import 'package:fils/core/domain/reposetry/store/store_repo.dart';
import 'package:fils/core/server/result.dart';

import '../../../data/response/store/store_in_category.dart';

class StoreUseCase {
  StoreRepoImpl storeRepoImpl;

  StoreUseCase(this.storeRepoImpl);

  Future<ApiResult<StoreResponse>> callAllStore({int page = 1}) async {
    return await storeRepoImpl.getAllStore(page: page);
  }

  Future<ApiResult<Map<String, dynamic>>> callTabBar({required int id}) async {
    return await storeRepoImpl.getTabBar(id: id);
  }

  Future<ApiResult<Map<String, dynamic>>> callProductIntoStore({
    required int categoryId,
    required int page,
    required int idStore,
  }) async {
    return await storeRepoImpl.getProductInStore(
      page: page,
      idStore: idStore,
      categoryId: categoryId,
    );
  }

  Future<ApiResult<StoreInCategoryResponse>> callProductIntoStoreCategory({
    required int categoryId,
  }) async {
    return await storeRepoImpl.getProductInStoreCategory(
      categoryId: categoryId,
    );
  }
}
