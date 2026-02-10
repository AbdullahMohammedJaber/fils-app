import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class AuctionDataSource {
  Future<ApiResult<Map<String, dynamic>>> getAllAuction({int page});

  Future<ApiResult<Map<String, dynamic>>> getAuctionDetails({
    required dynamic id,
  });

  Future<ApiResult<Map<String, dynamic>>> placeBid({
    required int productId,
    required double amount,
    required double bid,
  });

  Future<ApiResult<Map<String, dynamic>>> getAuctionCategory({
    int page,
    required int categoryId,
  });
  Future<ApiResult<Map<String, dynamic>>> addAuction({required Map<String , dynamic> data});

}

class AuctionDataSourceImpl extends AuctionDataSource {
  DioClient dioClient;

  AuctionDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getAllAuction({int page = 1}) async {
    return await dioClient.request(
      path: '${ApiService.auction}?is_auction=1&page=$page',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getAuctionCategory({
    int page = 1,
    required int categoryId,
  }) async {
    return await dioClient.request(
      path:
          '${ApiService.auctionInCategory}/$categoryId?is_auction=1&page=$page',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getAuctionDetails({
    required dynamic id,
  }) async {
    return await dioClient.request(
      path: '${ApiService.auction}/$id?is_auction=1',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> placeBid({
    required int productId,
    required double amount,
    required double bid,
  }) async {
    return await dioClient.request(
      path: ApiService.placeBid,
      method: 'POST',
      data: {"product_id": productId, "amount": amount, "customer_bid": bid},
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> addAuction({required Map<String, dynamic> data}) async{
    return await dioClient.request(
      path: ApiService.addAuctionForm,
      method: 'POST',
      data: data,
    );
  }
}
