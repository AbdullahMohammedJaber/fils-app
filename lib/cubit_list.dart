import 'package:fils/managment/address_manage/address_cubit.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:fils/managment/auction/auction_seller_cubit.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/category/category_cubit.dart';
import 'package:fils/managment/chat_bot/chat_bot_cubit.dart';
import 'package:fils/managment/favorites/favorites_cubit.dart';
import 'package:fils/managment/haraj/haraj_cubit.dart';
import 'package:fils/managment/home/cubit/haraj_home_cubit.dart';
import 'package:fils/managment/home/home_cubit.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/order/order_seller_cubit.dart';
import 'package:fils/managment/product/seller/product_seller_cubit.dart';
import 'package:fils/managment/reels_manage/cubit/reels_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/managment/theme/theme_cubit.dart';
import 'package:fils/managment/update/cubit/update_cubit.dart';
import 'package:fils/managment/wallet/wallet_seller_cubit.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:fils/managment/store/store_cubit.dart';
import 'package:fils/managment/support_manage/support_cubit.dart';
import 'package:fils/managment/user/user_cubit.dart';
import 'package:fils/managment/wallet/wallet_cubit.dart';
import 'managment/cart/cart_cubit.dart';
import 'managment/order/order_cubit.dart';
import 'managment/product/product_cubit.dart';
import 'managment/subscriptions/subscriptions_cubit.dart';

List<BlocProvider> cubieList = [
  ...sharedCubits,

  BlocProvider<HarajCubit>(create: (_) => HarajCubit()),
  BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
  BlocProvider<ProductCubit>(create: (_) => ProductCubit()),
  BlocProvider<FavoritesCubit>(create: (_) => FavoritesCubit()),
  BlocProvider<AuctionCubit>(create: (_) => AuctionCubit()),
  BlocProvider<OrderCubit>(create: (_) => OrderCubit()),
  BlocProvider<StoreCubit>(create: (_) => StoreCubit()),
  BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
  BlocProvider<AddressCubit>(create: (_) => AddressCubit()),
  BlocProvider<CartCubit>(create: (_) => CartCubit()),
  BlocProvider<HomeSellerCubit>(create: (_) => HomeSellerCubit()),
  BlocProvider<SubscriptionsCubit>(create: (_) => SubscriptionsCubit()),
  BlocProvider<ProductSellerCubit>(create: (_) => ProductSellerCubit()),
  BlocProvider<ShopsCubit>(create: (_) => ShopsCubit()),
  BlocProvider<WalletSellerCubit>(create: (_) => WalletSellerCubit()),
  BlocProvider<AuctionSellerCubit>(create: (_) => AuctionSellerCubit()),
  BlocProvider<ReelsCubit>(create: (_) => ReelsCubit()),
  BlocProvider<UpdateCubit>(create: (_) => UpdateCubit()),
  BlocProvider<OrderSellerCubit>(create: (_) => OrderSellerCubit()),
  BlocProvider<HarajHomeCubit>(create: (_) => HarajHomeCubit()),




 


];

List<BlocProvider> sharedCubits = [
  BlocProvider<CategoryCubit>(create: (_) => CategoryCubit()),
  BlocProvider<ChatBotCubit>(create: (_) => ChatBotCubit()),
  BlocProvider<SupportCubit>(create: (_) => SupportCubit()),
  BlocProvider<AppCubit>(create: (_) => AppCubit()),
  BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
  BlocProvider<LanguageCubit>(create: (_) => LanguageCubit()..loadLanguage()),
  BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
  BlocProvider<UserCubit>(create: (_) => UserCubit()..startRealtimeUpdate()),
  BlocProvider<WalletCubit>(create: (_) => WalletCubit()),
];

List<BlocProvider> getCubitRoot() {
  if (!isLogin()) {
    return [...cubieList];
  }

  final type = getUser()!.user!.type;

  if (type == UserType.customer.name) {
    return [...cubieList];
  } else {
    return [...cubieList];
  }
}
