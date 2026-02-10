import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/features/authentication/froget_password/create_new_password.dart';
import 'package:fils/features/authentication/froget_password/forget_password.dart';
import 'package:fils/features/authentication/froget_password/verification_code_forget_password.dart';
import 'package:fils/features/authentication/login/login_screen.dart';

import 'package:fils/features/coustamer/auction/details_auction.dart';
import 'package:fils/features/coustamer/auction/form_add_auction/form_add_auction_coustomer.dart';
import 'package:fils/features/coustamer/auction/room_auction/normal_auction/room_auction_screen.dart';
import 'package:fils/features/coustamer/auction/web_view_auction.dart';
import 'package:fils/features/coustamer/check_out/payment_methode.dart';
import 'package:fils/features/coustamer/haraj/details_haraj.dart';
import 'package:fils/features/coustamer/haraj/haraj_in_category.dart';
import 'package:fils/features/coustamer/home/home_root.dart';
import 'package:fils/features/coustamer/order/order_screen.dart';
import 'package:fils/features/coustamer/product/all_product/all_product_store.dart';
import 'package:fils/features/coustamer/reels/reels_screen.dart';
import 'package:fils/features/coustamer/search/all_product_filter.dart';
import 'package:fils/features/root/language_screen.dart';
import 'package:fils/features/root/profile/edit_profile.dart';
import 'package:fils/features/root/settings/cancel_order.dart';
import 'package:fils/features/root/settings/create_web.dart';
import 'package:fils/features/coustamer/store/all_store.dart';
import 'package:fils/features/coustamer/wallet/add_account_wallet.dart';
import 'package:fils/features/root/bottom_bar/root_app.dart';
import 'package:fils/features/root/settings/setings_screen.dart';
import 'package:fils/features/root/static_page.dart';
import 'package:fils/features/seller/auction/details_auction/details_auction_seller.dart';
import 'package:fils/features/seller/auction/form_add_auction.dart';
import 'package:fils/features/seller/auction/room/room_auction.dart';
import 'package:fils/features/seller/edit_product/edit_product.dart';
import 'package:fils/features/seller/order/add_shipping.dart';
import 'package:fils/features/seller/order/shipping_address.dart';
import 'package:fils/features/seller/product/details_product_seller.dart';
import 'package:fils/core/data/response/product/details_product_seller.dart';

import 'package:fils/features/seller/product/option/option_screen.dart';
import 'package:fils/features/seller/report/repordt_screen.dart';
import 'package:fils/features/seller/shops/form_shop.dart';
import 'package:fils/features/seller/wallet/bank_setting.dart';
import 'package:fils/features/seller/wallet/settings_wallet.dart';
import 'package:fils/features/seller/wallet/wallet_seller.dart';
import 'package:fils/features/splash_screen/splash_screen.dart';
import 'package:fils/main.dart';
import 'package:fils/features/seller/wallet/withdrow_screen.dart';
import 'package:fils/route/app_routes.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/sign_up/signup_screen.dart';
import '../../features/authentication/virefy_code/virefy_code_signup.dart';
import '../../features/coustamer/auction/all_auction_in_category.dart';
import '../../features/coustamer/auction/auction_root.dart';
import '../../features/coustamer/favorites/favourait_screen.dart';
import '../../features/coustamer/haraj/form_add_haraj.dart';
import '../../features/coustamer/haraj/haraj_root.dart';
import '../../features/coustamer/notification/notification_screen.dart';
import '../../features/coustamer/product/all_product/all_product_screen.dart';
import '../../features/coustamer/product/details_product/details_product_root.dart';
import '../../features/root/settings/support.dart';
import '../../features/coustamer/store/all_store_in_categpry.dart';
import '../../features/coustamer/wallet/add_money_wallet.dart';
import '../../features/coustamer/wallet/web_view_wallet.dart';
import '../../features/seller/product/form_add_product.dart';
import '../../features/seller/subsecribe/subsecribe_screen.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Widget getPage(String routeName, [Object? arguments]) {
    switch (routeName) {
      case AppRoutes.roomAuctionSeller:
      var details = arguments as AuctionSeller ;
      return RoomAuctionSellerScreen(detailsAuctionResponse: details);
      case AppRoutes.repordtScreen:
      return RepordtScreen();
      case AppRoutes.splash:
        return const SplashScreen();
      case AppRoutes.withdrowScreen:
      String wallet = arguments as String;
      return WithdrowScreen(wallet: wallet)  ;
        case AppRoutes.bankSetting:
        return BankSetting();
       case AppRoutes.settingWallet:
       return SettingsWallet();
      case AppRoutes.shippingAdress:

      int idOrder = arguments as int ;
      return ShippingAdress(order_id: idOrder);  
      case AppRoutes.addShippingAddress:
      return AddShippingAddress();
      case AppRoutes.detailsAuctionSeller:
        var data = arguments as AuctionSeller;
        return DetailsAuctionSeller(data: data);
      case AppRoutes.formAddAuctionSeller:
        return FormAddAuctionSeller();
      case AppRoutes.formAddAuctionCoustomer:
        return FormAddAuctionCoustomer();
      case AppRoutes.optionScreen:
        return const OptionScreen();
      case AppRoutes.detailsPriductSeller:
        int idProduct = arguments as int;
        return DetailsProductSellerScreen(idProduct: idProduct);
      case AppRoutes.walletSeller:
        return WalletSeller();
      case AppRoutes.formShop:
        return FormShop();
      case AppRoutes.formAddProduct:
        return FormAddProduct();
      case AppRoutes.subscriptionsScreen:
        return const SubscriptionsScreen();
      case AppRoutes.main:
        return const MyApp();
      case AppRoutes.roomAuctionScreen:
        return RoomAuctionScreen();
      case AppRoutes.createNewPassowrd:
        String code = arguments as String;
        return CreateNewPassword(code: code);
      case AppRoutes.forgetPassword:
        return ForgetPasswordScreen();
      case AppRoutes.editPersonalInformationScreen:
        return EditProfile();
      case AppRoutes.paymentMethode:
        return PaymentMethode();
      case AppRoutes.cancelRequestScreen:
        return CancelOrderScreen();
      case AppRoutes.reels:
        return ReelsScreen();
      case AppRoutes.aboutUsScreen:
        return AboutUsScreen();
      case AppRoutes.privacyPolicyScreen:
        return PrivacyPolicyScreen();
      case AppRoutes.settingsScreen:
        return const SetingsScreen();
      case AppRoutes.supportAndHelpTeam:
        return const SupportAndHelpTeam();
      case AppRoutes.detailsAuction:
        int id = arguments as int;
        return DetailsAuction(id: id);
      case AppRoutes.harajInCategory:
        int categoryId = arguments as int;
        return HarajInCategory(categoryId: categoryId);
      case AppRoutes.allStoreInCategory:
        int categoryId = arguments as int;
        return AllStoreInCategory(categoryId: categoryId);
      case AppRoutes.allAuctionInCategory:
        int categoryId = arguments as int;
        return AllAuctionInCategory(categoryId: categoryId);
      case AppRoutes.formAddHaraj:
        return FormAddHaraj();
      case AppRoutes.harajRoot:
        return const HarajRoot();
      case AppRoutes.createWeb:
        return const CreateWebScreen();
      case AppRoutes.virefyCodeSignup:
        String mobile = arguments as String;
        return VirefyCodeSignup(mobile: mobile);
      case AppRoutes.allProductFilter:
        dynamic search = arguments.toString();
        return AllProductFilter(search: search);
      case AppRoutes.auctionRoot:
        return const AuctionRoot();
      case AppRoutes.detailsHaraj:
        String slug = arguments as String;
        return DetailsHaraj(slug: slug);
      case AppRoutes.notificationScreen:
        return const NotificationScreen();
      case AppRoutes.allProductScreen:
        return const AllProductScreen();
      case AppRoutes.allStoreScreen:
        return const AllStoreScreen();
      case AppRoutes.detailsProductRoot:
        final id = arguments as int;
        return DetailsProductRoot(id: id);
      case AppRoutes.favorites:
        return const FavoritesScreen();
      case AppRoutes.login:
        return LoginScreen();
      case AppRoutes.rootGeneral:
        int? index;
        if (arguments != null) {
          index = arguments as int;
        }
       
        return RootAppScreen(currentIndex: index);
      case AppRoutes.privacyPolicy:
        return PrivacyPolicyScreen();
      case AppRoutes.home:
        return const HomeRoot();
      case AppRoutes.signupScreen:
        return SignupScreen();
      case AppRoutes.addMoneyWallet:
        double amount = arguments as double;
        return AddMoneyWallet(amount: amount);
      case AppRoutes.addAccountWallet:
        return const AddAccountWallet();
      case AppRoutes.orderC:
        return const OrderScreen();
      case AppRoutes.webViewWallet:
        final data = arguments as List;
        return PaymentWebViewWallet(urlPayment: data[0], paymentType: data[1]);
         case AppRoutes.webViewAuction:
        final data = arguments as List;
        return PaymentWebViewAuction(urlPayment: data[0], paymentType: data[1]);
      case AppRoutes.allProductStore:
        final store = arguments as List;
        return AllProductStore(idStore: store[0], nameStore: store[1]);
      case AppRoutes.verificationCodeForgetPassword:
        String mobile = arguments as String;
        return VerificationCodeForgetPassword(mobile: mobile);
      case AppRoutes.languageScreen:
        return const LanguageScreen();
      case AppRoutes.editProductScreen:
        var detailsProductSellerResponse = arguments as DetailsProductSeller;
        return EditProductScreen(
          detailsProductSellerResponse: detailsProductSellerResponse,
        );
      default:
        return const SplashScreen();
    }
  }
}
