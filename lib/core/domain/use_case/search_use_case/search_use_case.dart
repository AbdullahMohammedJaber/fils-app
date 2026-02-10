import 'package:fils/core/domain/reposetry/search/search_repo.dart';

import '../../../server/result.dart';

class SearchUseCase {
  SearchRepoImpl searchRepoImpl;

  SearchUseCase(this.searchRepoImpl);

  Future<ApiResult<Map<String, dynamic>>> callGetSearch({
    int page = 1,
    required Map<String, dynamic> data,
  }) async {
    return await searchRepoImpl.getSearch(data: data, page: page);
  }
}
