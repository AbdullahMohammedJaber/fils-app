 import 'package:fils/features/coustamer/cart/cart_screen.dart';
import 'package:fils/features/coustamer/reels/reels_screen.dart';
import 'package:fils/features/root/profile/profile.dart';
import 'package:fils/features/coustamer/wallet/wallet_screen_coustamer.dart';
import 'package:fils/features/seller/auction/auction_seller.dart';
import 'package:fils/features/seller/home/home_seller.dart';
import 'package:fils/features/seller/order/order_seller.dart';
import 'package:fils/features/seller/product/product_seller.dart';
import 'package:fils/managment/reels_manage/cubit/reels_cubit.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/coustamer/home/home_root.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  List<Widget> screenListCoustomer = [
    HomeRoot(),
    WalletScreenCoustamer(),
    ReelsScreen(),
    CartScreen(),
    ProfileScreen(
      userType: isLogin() ? getUser()!.user!.type : UserType.customer.name,
    ),
  ];
  List<Map<String, dynamic>> screenIconsCoustomer = [
    {"icons": "assets/icons/home_nav.svg", "title": "Home" },
    {"icons": "assets/icons/wallet.svg", "title": "Wallet" },
    {"icons": "assets/icons/reels.svg", "title": "Reels" },
    {"icons": "assets/icons/cart_nav.svg", "title": "Cart" },
    {"icons": "assets/icons/user_nav.svg", "title": "Profile" },
  ];

  onClickBottomNavigationBar(dynamic index , int currentIndex) {
    if(index!=2 && currentIndex ==2){
      NavigationService.navigatorKey.currentContext!.read<ReelsCubit>().close();
    }
    emit(state.copyWith(selectPageRoot: index));
  }

  List<Widget> screenListSeller = [
    HomeSeller(),
    const ProductSellerScreen(),
    const AuctionSeller(),
    const OrderSeller(),
    ProfileScreen(
      userType: isLogin() ? getUser()!.user!.type : UserType.seller.name,
    ),
  ];
  List<Map<String, dynamic>> screenIconsSeller = [
    {"icons": "assets/icons/home_nav.svg", "title": "Home" },
    {"icons": "assets/icons/product.svg", "title": "Product" },
    {"icons": "assets/icons/auction_nav.svg", "title": "Auctions" },
    {"icons": "assets/icons/cart_nav.svg", "title": "Orders" },
    {"icons": "assets/icons/user_nav.svg", "title": "Profile" },
  ];

  bool _showButton = true;

  bool get showButton => _showButton;

  void show() {
    _showButton = true;
    emit(state.copyWith(showButton: _showButton));
  }

  void hide() {
    _showButton = false;
    emit(state.copyWith(showButton: _showButton));
  }
}
