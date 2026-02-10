import 'package:fils/core/data/data_source/customer/address/address_data_source.dart';
import 'package:fils/core/data/data_source/customer/auction/auction_data_source.dart';
import 'package:fils/core/data/data_source/customer/cart/cart_data_source.dart';
import 'package:fils/core/data/data_source/customer/favorites/favorites_data_source.dart';
import 'package:fils/core/data/data_source/customer/home/home_data_source.dart';
import 'package:fils/core/data/data_source/profile/profile_data_source.dart';
import 'package:fils/core/data/data_source/customer/reels/reels_data_source.dart';
import 'package:fils/core/data/data_source/customer/wallet/wallet_data_source.dart';
import 'package:fils/core/domain/reposetry/address/address_repo.dart';
import 'package:fils/core/domain/reposetry/auth_repo/auth_repo.dart';
import 'package:fils/core/domain/reposetry/cart/cart_repo.dart';
import 'package:fils/core/domain/reposetry/favorites/favorites_repo.dart';
import 'package:fils/core/domain/reposetry/home_repo/coustomer/home_repo.dart';
import 'package:fils/core/domain/reposetry/profile/profile_repo.dart';
import 'package:fils/core/domain/reposetry/reels/reels_repo.dart';
import 'package:fils/core/domain/reposetry/wallet/coustomer/wallet_repostary.dart';
import 'package:fils/core/domain/use_case/address_use_case/address_use_case.dart';
import 'package:fils/core/domain/use_case/auth_use_case/auth_usecase.dart';
import 'package:fils/core/domain/use_case/cart_use_case/cart_use_case.dart';
import 'package:fils/core/domain/use_case/favorites_use_case/favorites_use_case.dart';
import 'package:fils/core/domain/use_case/home_use_case/home_use_case.dart';
import 'package:fils/core/domain/use_case/notifications_use_case/notification_use_case.dart';
import 'package:fils/core/domain/use_case/profile_use_case/profile_use_case.dart';
import 'package:fils/core/domain/use_case/reel_use_case/reel_use_case.dart';
import 'package:fils/core/domain/use_case/wallet_use_case/wallet_use_case.dart';
import 'package:fils/core/server/dio_helper.dart';

 import '../../data/data_source/auth/auth_data_source.dart';
import '../../data/data_source/customer/category/category_data_source.dart';
import '../../data/data_source/customer/chat_bot/bot_data_source.dart';
import '../../data/data_source/customer/details_product/details_product_data_source.dart';
import '../../data/data_source/customer/haraj/haraj_data_source.dart';
import '../../data/data_source/customer/notifications/notification_data_source.dart';
import '../../data/data_source/customer/order/order_data_source.dart';
import '../../data/data_source/customer/search/search_data_source.dart';
import '../../data/data_source/customer/store/store_data_source.dart';
import '../../domain/reposetry/auction/coustomer/auction_repo.dart';
import '../../domain/reposetry/category_repo/category_repo.dart';
import '../../domain/reposetry/chat_bot/chat_bot_repo.dart';
import '../../domain/reposetry/details_product_repo/details_product_repo.dart';
import '../../domain/reposetry/haraj/haraj_repo.dart';
import '../../domain/reposetry/notifications/notifications_repo.dart';
import '../../domain/reposetry/order/coustomer/order_repo.dart';
import '../../domain/reposetry/search/search_repo.dart';
import '../../domain/reposetry/store/store_repo.dart';
import '../../domain/use_case/auction_use_case/auction_use_case.dart';
import '../../domain/use_case/category_use_case/category_use_case.dart';
import '../../domain/use_case/chat_bot_use_case/chat_bot_use_case.dart';
import '../../domain/use_case/details_product_use_case/details_product_use_case.dart';
import '../../domain/use_case/haraj_use_case/haraj_use_case.dart';
import '../../domain/use_case/order_use_case/order_use_case.dart';
import '../../domain/use_case/search_use_case/search_use_case.dart';
import '../../domain/use_case/store_use_case/store_use_case.dart';

class UserCase {
  final authUserCase = AuthUseCase(
    AuthRepoImpl(AuthDataSourceImpl(DioClient())),
  );
  final homeUserCase = HomeUseCase(
    HomeRepoImpl(HomeDataSourceImp(DioClient())),
  );
  final cartUserCase = CartUseCase(
    CartRepoImpl(CartDataSourceImpl(DioClient())),
  );
  final walletUserCase = WalletUseCase(
    WalletRepoImpl(WalletDataSourceImpl(DioClient())),
  );
  final favoritesUserCase = FavoritesUseCase(
    FavoritesRepoImpl(FavoritesDataSourceImpl(DioClient())),
  );
  final detailsProductUserCase = DetailsProductUseCase(
    DetailsProductRepoImpl(DetailsProductDataSourceImpl(DioClient())),
  );
  final categoryUserCase = CategoryUseCase(
    CategoryRepoImpl(CategoryDataSourceImpl(DioClient())),
  );
  final storeUserCase = StoreUseCase(
    StoreRepoImpl(StoreDataSourceImpl(DioClient())),
  );
  final notificationsUserCase = NotificationUseCase(
    NotificationsRepoImpl(NotificationsDataSourceImpl(DioClient())),
  );
  final auctionUserCase = AuctionUseCase(
    AuctionRepoImpl(AuctionDataSourceImpl(DioClient())),
  );
  final searchUserCase = SearchUseCase(
    SearchRepoImpl(SearchDataSourceImpl(DioClient())),
  );
  final botUserCase = ChatBotUseCase(
    ChatBotRepoImpl(ChatBotDataSourceImpl(DioClient())),
  );
  final harajUserCase = HarajUseCase(
    HarajRepoImpl(HarajDataSourceImpl(DioClient())),
  );
  final orderUserCase = OrderUseCase(
    OrderRepoImpl(OrderDataSourceImpl(DioClient())),
  );

  final profileUseCase = ProfileUseCase(
     ProfileRepoImpl( ProfileDataSourceImpl(DioClient())),
    
  );

  final addressUseCase = AddressUseCase(
    AddressRepositoryImpl(AddressDataSourceImpl(DioClient())),
  );

  final reelUseCase = ReelUseCase(
    ReelsRepositoryImpl(ReelsDataSourceImpl(DioClient())),
  );
}
