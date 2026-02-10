import 'package:fils/core/data/response/auction/auction_response.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/core/data/response/auction/details_auction_response.dart';
import 'package:fils/core/domain/reposetry/auction/coustomer/auction_repo.dart';
import 'package:fils/core/domain/reposetry/auction/seller/auction_seller.dart';
import 'package:fils/core/server/result.dart';

class AuctionUseCase {
  final AuctionRepoImpl auctionRepoImpl;

  AuctionUseCase(this.auctionRepoImpl);

  Future<ApiResult<AllAuctionResponse>> callAllAuction({int page = 1}) async {
    return await auctionRepoImpl.getAllAuction(page: page);
  }

  Future<ApiResult<AllAuctionResponse>> callAllAuctionCategory({
    int page = 1,
    required int categoryId,
  }) async {
    return await auctionRepoImpl.getAuctionCategory(
      page: page,
      categoryId: categoryId,
    );
  }

  Future<ApiResult<DetailsAuctionResponse>> callAuctionDetails({
    required dynamic id,
  }) async {
    return await auctionRepoImpl.getAuctionDetails(id: id);
  }

  Future<ApiResult<Map<String, dynamic>>> placeBid({
    required int productId,
    required double amount,
    required double bid,
  }) async {
    return await auctionRepoImpl.placeBid(
      productId: productId,
      amount: amount,
      bid: bid,
    );
  }

  Future<ApiResult<Map<String, dynamic>>> addAuction({
    required Map<String, dynamic> data,
  }) async {
    return await auctionRepoImpl.addAuction(data: data);
  }
}

class AuctionSellerUseCase {
  AuctionSellerRepoImpl auctionSellerRepoImpl;
  AuctionSellerUseCase(this.auctionSellerRepoImpl);
  Future<ApiResult<AllAuctionSellerResponse>> getAllAuctionSeller({
    required int page,
  }) async {
    return await auctionSellerRepoImpl.getAllAuctionSeller(page: page);
  }

  Future<ApiResult<Map<String, dynamic>>> addAuctionSeller({
    required Map<String, dynamic> data,
  }) async {
    return await auctionSellerRepoImpl.addAuctionSeller(data: data);
  }
}
