import 'package:fils/core/data/data_source/customer/reels/reels_data_source.dart';
import 'package:fils/core/data/response/reel/reel_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';
 
abstract class ReelsRepository {
  Future<ApiResult<ReelResponse>> fetchReels({required int page});
}

class ReelsRepositoryImpl implements ReelsRepository {
  ReelsDataSourceImpl reelsDataSource;
  ReelsRepositoryImpl( this.reelsDataSource);
  @override
  Future<ApiResult<ReelResponse>> fetchReels({required int page}) async {
    final result = await reelsDataSource.fetchReels(page: page);
    if (result.isSuccess) {
      return ApiResult.success(ReelResponse.fromJson(result.data!));
    } else if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }
}
