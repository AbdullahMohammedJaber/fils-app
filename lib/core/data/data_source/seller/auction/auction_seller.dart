import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class AuctionSellerDataSource {
  Future<ApiResult<Map<String, dynamic>>> getAllAuctionSeller({
    required int page,
  });
  Future<ApiResult<Map<String, dynamic>>> addAuctionSeller({
    required Map<String, dynamic> data,
  });
}

class AuctionSellerDataSourceImpl extends AuctionSellerDataSource {
  DioClient dioClient;
  AuctionSellerDataSourceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> getAllAuctionSeller({
    required int page,
  }) async {
    return await dioClient.request(
      path: ApiServiceSeller.auctionSeller,
      method: 'GET',
      queryParameters: {'page': page},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addAuctionSeller({
    required Map<String, dynamic> data,
  }) async {
    return await dioClient.request(
      path: ApiServiceSeller.addAuctionSeller,
      method: 'POST',
      data: data,
    );
  }
}
