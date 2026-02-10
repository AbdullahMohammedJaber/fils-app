import 'package:fils/core/data/response/haraj/haraj_response.dart';
import 'package:fils/core/domain/reposetry/haraj/haraj_repo.dart';
import 'package:fils/core/server/result.dart';

import '../../../data/response/haraj/details_haraj.dart';

class HarajUseCase {
  HarajRepoImpl harajRepoImpl;

  HarajUseCase(this.harajRepoImpl);

  Future<ApiResult<AllProductMarketOpenResponse>> getAllHaraj({
    required int page,
  }) async {
    return await harajRepoImpl.getAllHaraj(page: page);
  }

  Future<ApiResult<AllProductMarketOpenResponse>> getHarajInCategory({
    required int page,
    required int categoryId,
  }) async {
    return await harajRepoImpl.getHarajInCategory(
      page: page,
      idCategory: categoryId,
    );
  }

  Future<ApiResult<DetailsOpenMarketResponse>> getDetailsHaraj({
    required String slug,
  }) async {
    return await harajRepoImpl.getDetailsHaraj(slug: slug);
  }

  Future<ApiResult<Map<String, dynamic>>> addHaraj({
    required Map<String, dynamic> harajData,
  }) async {
    return await harajRepoImpl.addHaraj(harajData: harajData);
  }
}
