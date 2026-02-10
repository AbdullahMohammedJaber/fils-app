import 'package:fils/core/data/data_source/customer/search/search_data_source.dart';
import 'package:fils/utils/string.dart';

import '../../../server/result.dart';

abstract class SearchRepo {
  Future<ApiResult<Map<String, dynamic>>> getSearch({
    int page,
    required Map<String, dynamic> data,
  });
}

class SearchRepoImpl extends SearchRepo {
  SearchDataSourceImpl searchDataSourceImpl;

  SearchRepoImpl(this.searchDataSourceImpl);

  @override
  Future<ApiResult<Map<String, dynamic>>> getSearch({
    int page = 1,
    required Map<String, dynamic> data,
  }) async {
    final result = await searchDataSourceImpl.getSearch(data: data, page: page);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(message: result.message);
    } else {
      return ApiResult.success(result.data!);
    }
  }
}
