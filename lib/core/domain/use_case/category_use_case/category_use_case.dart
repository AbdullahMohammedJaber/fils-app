import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/core/domain/reposetry/category_repo/category_repo.dart';
import 'package:fils/core/server/result.dart';

class CategoryUseCase {
  CategoryRepoImpl categoryRepoImpl;

  CategoryUseCase(this.categoryRepoImpl);

  Future<ApiResult<CategoryResponse>> callCategory() async {
    return await categoryRepoImpl.getCategory();
  }
    Future<ApiResult<CategoryResponse>> callSubCategory({required int categoryId}) async {
    return await categoryRepoImpl.getSubCategory(categoryId: categoryId);
  }
}
