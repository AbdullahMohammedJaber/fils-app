import 'package:fils/core/data/data_source/customer/auction/auction_data_source.dart';
import 'package:fils/core/data/response/auction/auction_response.dart';
import 'package:fils/core/data/response/auction/details_auction_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class AuctionRepo {
  Future<ApiResult<AllAuctionResponse>> getAllAuction({int page});
  Future<ApiResult<Map<String , dynamic>>> addAuction({
    required Map<String , dynamic> data,
  });

  Future<ApiResult<DetailsAuctionResponse>> getAuctionDetails({
    required dynamic id,
  });

  Future<ApiResult<Map<String, dynamic>>> placeBid({
    required int productId,
    required double amount,
    required double bid,
  });

  Future<ApiResult<AllAuctionResponse>> getAuctionCategory({
    int page,
    required int categoryId,
  });
}

class AuctionRepoImpl extends AuctionRepo {
  AuctionDataSourceImpl auctionDataSourceImpl;

  AuctionRepoImpl(this.auctionDataSourceImpl);

  @override
  Future<ApiResult<AllAuctionResponse>> getAllAuction({int page = 1}) async {
    final result = await auctionDataSourceImpl.getAllAuction(page: page);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(message: result.message);
    } else {
      AllAuctionResponse allAuctionResponse = AllAuctionResponse.fromJson(
        result.data!,
      );
      return ApiResult.success(allAuctionResponse);
    }
  }

  @override
  Future<ApiResult<AllAuctionResponse>> getAuctionCategory({
    int page = 1,
    required int categoryId,
  }) async {
    final result = await auctionDataSourceImpl.getAuctionCategory(
      page: page,
      categoryId: categoryId,
    );
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(message: result.message);
    } else {
      AllAuctionResponse allAuctionResponse = AllAuctionResponse.fromJson(
        result.data!,
      );
      return ApiResult.success(allAuctionResponse);
    }
  }

  @override
  Future<ApiResult<DetailsAuctionResponse>> getAuctionDetails({
    required dynamic id,
  }) async {
    final result = await auctionDataSourceImpl.getAuctionDetails(id: id);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(message: result.message);
    } else {
      DetailsAuctionResponse detailsAuctionResponse =
          DetailsAuctionResponse.fromJson(result.data!);
      return ApiResult.success(detailsAuctionResponse);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> placeBid({
    required int productId,
    required double amount,
    required double bid,
  }) async {
    final result = await auctionDataSourceImpl.placeBid(
      bid: bid,
      amount: amount,
      productId: productId,
    );
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(message: result.message);
    } else {
      return ApiResult.success(result.data!);
    }
  }
  
  @override
  Future<ApiResult<Map<String , dynamic>>> addAuction({required Map<String, dynamic> data}) async{
  final result = await auctionDataSourceImpl.addAuction(
      data: data
    );
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(message: result.message);
    } else {
      return ApiResult.success(result.data!);
    }
  }
}
