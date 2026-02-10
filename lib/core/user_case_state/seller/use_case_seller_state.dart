import 'package:fils/core/data/data_source/seller/auction/auction_seller.dart';
import 'package:fils/core/data/data_source/seller/home_seller/home_seller.dart';
import 'package:fils/core/data/data_source/seller/product_seller/product_data_source.dart';
import 'package:fils/core/data/data_source/seller/shops_seller/package_seller.dart';
import 'package:fils/core/data/data_source/seller/shops_seller/shops_seller.dart';
import 'package:fils/core/data/data_source/seller/wallet/wallet_seller.dart';
import 'package:fils/core/domain/reposetry/auction/seller/auction_seller.dart';
import 'package:fils/core/domain/reposetry/home_repo/seller/home_seller_repo.dart';
import 'package:fils/core/domain/reposetry/order/seller/order_repo.dart';
import 'package:fils/core/domain/reposetry/product_seller/product_seller_repo.dart';
import 'package:fils/core/domain/reposetry/shops/package.dart';
import 'package:fils/core/domain/reposetry/shops/shops_seller.dart';
import 'package:fils/core/domain/reposetry/wallet/seller/wallet_seller.dart';
import 'package:fils/core/domain/use_case/auction_use_case/auction_use_case.dart';
import 'package:fils/core/domain/use_case/home_use_case/home_use_case.dart';
import 'package:fils/core/domain/use_case/product_seller_use_case/product_seller_use_case.dart';
import 'package:fils/core/domain/use_case/shops_use_case/shops_seller_use_case.dart';
import 'package:fils/core/domain/use_case/subscriptions_use_case/subscription_use_case.dart';
import 'package:fils/core/domain/use_case/wallet_use_case/wallet_use_case.dart';
import 'package:fils/core/server/dio_helper.dart';

import '../../data/data_source/seller/order/order_data_source.dart';
import '../../data/data_source/seller/subscriptions/subscriptions_data_source.dart';
import '../../domain/reposetry/subscriptions/subscriptions.dart';
import '../../domain/use_case/order_use_case/order_use_case.dart';

class UserCaseSeller {
  final homeSellerUseCase = HomeSellerUseCase(
    HomeSellerRepoImpl(HomeSellerDataSourceImpl(DioClient(seller: true))),
  );
  final subscriptionUseCase = SubscriptionUseCase(
    SubscriptionsRepoImpl(SubscriptionsDataSourceImpl(DioClient(seller: true))),
  );
   final productSellerUseCase = ProductSellerUseCase(
    ProductSellerRepoImpl(ProductSellerDataSourceImpl(DioClient(seller: true))),
  );
    final shopsSellerUseCase = ShopsSellerUseCase(
    ShopsSellerRepoImpl(ShopsSellerDataSourceImpl(DioClient(seller: true))),
    PackageSellerRepoImpl(PackageSellerDataSourceImpl(DioClient(seller: true))),
  );
    final walletSellerUseCase = WalletSellerUseCase(
    WalletSellerRepoImpl(WalletSellerDataSourceImpl(DioClient(seller: true))),
    
  );
   final auctionSellerUseCase = AuctionSellerUseCase(
    AuctionSellerRepoImpl(AuctionSellerDataSourceImpl(DioClient(seller: true))),
    
  );
   final orderSellerUseCase = OrderSellerUseCase(
    OrderSellerRepoImpl(OrderSellerDataSourceImpl(DioClient(seller: true))),
  );
}
