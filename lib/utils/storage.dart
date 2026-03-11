import 'package:fils/core/data/response/order/shipping_address_response.dart';
import 'package:fils/core/data/response/package/package_response.dart';
import 'package:fils/core/data/response/shops/shop_info_seller_response.dart';
import 'package:fils/core/data/response/shops/shops_response.dart';
import 'package:get_storage/get_storage.dart';

import '../core/data/response/auth/user_response.dart';

/////////////////////////// USER SECTION ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

setUserToken(String token) {
  GetStorage().write("token", token);
}

String? getUserToken() {
  return GetStorage().read("token") ?? "";
}

setUserStorage(UserResponse user) {
  if (user.accessToken != null) {
    setUserToken(user.accessToken!);
  }

  if (user.user!.emailVerified) {
    setLogin(true);
  }
  GetStorage().write("user", user.toJson());
}

UserResponse? getUser() {
  if (!isLogin()) {
    return null;
  }
  return UserResponse.fromJson(GetStorage().read("user"));
}

setLogin(bool login) {
  GetStorage().write("isLogin", login);
}

bool isLogin() {
  return GetStorage().read("isLogin") ?? false;
}

removeUser() {
  GetStorage().remove("user");
  GetStorage().remove("isLogin");
  GetStorage().remove("token");
}

/////////////////////////// SHOP SECTION ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

setLang(String lang) {
  GetStorage().write("lang", lang);
}

getLang() {
  return GetStorage().read("lang") ?? "ar";
}

setLocal(String lang) {
  GetStorage().write("local", lang);
}

getLocal() {
  return GetStorage().read("local") ?? "ar";
}

selectLanguage(bool isSelect) {
  GetStorage().write("selectLanguage", isSelect);
}

bool isSelectLanguage() {
  return GetStorage().read("selectLanguage") ?? false;
}
// //////////////////////////////////////////////////////////////////////////
///////////////////////////// FCM SECTION ///////////////////////////////////

setFcmToken(String fcmToken) {
  GetStorage().write("fcm_token", fcmToken);
}

String? getFcmToken() {
  return GetStorage().read("fcm_token") ?? "";
}
// //////////////////////////////////////////////////////////////////////////
///////////////////////////// Setting SECTION ///////////////////////////////
setShippingAddress(ShippingAddress sh) {
  GetStorage().write("shipping", sh.toJson());
}

ShippingAddress getShippingAddress() {
  final data = GetStorage().read("shipping");
  return data != null
      ? ShippingAddress.fromJson(data)
      : ShippingAddress(id: null, address: null);
}

///// //////////////////////////////////////////////////////////////////////////
///////////////////////////// Setting SECTION ///////////////////////////////

setLanding(bool isSkip) {
  GetStorage().write("landing", isSkip);
}

bool isLanding() {
  return GetStorage().read("landing") ?? false;
}
////////////////////////////////////////////////////////////////////////////

setBalance(double balance) {
  GetStorage().write("balance", balance);
}

double getBalance() {
  return GetStorage().read("balance");
}
/////////////////////////////////////////////////////////////////////////////

setShowNotification(bool vibrations) {
  GetStorage().write("vibrations", vibrations);
}

bool isShowNotification() {
  return GetStorage().read("vibrations") ?? true;
}

///////////////// THEME //////////////////////
///
setTheme(bool theme) {
  GetStorage().write("isDark", theme);
}

bool getTheme() {
  return GetStorage().read("isDark") ?? false;
}

setTimeZoon(String zoon) {
  GetStorage().write("zoon", zoon);
}

String? getTimeZoon() {
  return GetStorage().read("zoon");
}

//////////////////////////////////////

setMyShopsDetails(Shop shopDetails) {
  GetStorage().write("myShopDetails", shopDetails.toJson());
}

Shop getMyShopsDetails() {
  final data = GetStorage().read("myShopDetails");
  if (data == null) {
    return Shop(
      id: 0,
      slug: "",
      name: "",
      logo: "",
      rating: 0,
      productsCount: 0,
      totalSales: 0,
      address: "",
      description: "",
    );
  }
  return Shop.fromJson(GetStorage().read("myShopDetails"));
}

setPackageInfo(PackageInfoResponse package) {
  GetStorage().write("PackageInfoResponse", package.toJson());
}

PackageInfoResponse? getPackageInfo() {
  final data = GetStorage().read("PackageInfoResponse");
  if(data!=null){
  return PackageInfoResponse.fromJson(GetStorage().read("PackageInfoResponse"));

  }
  return null;
}
setShopInfo(ShopInfoResponse shopResponse) {
  GetStorage().write("shopInfo", shopResponse.toJson());
}

ShopInfoResponse getShopInfo() {
  final data = GetStorage().read("shopInfo");
  return data != null
      ? ShopInfoResponse.fromJson(data)
      : ShopInfoResponse(data: null, success: true, status: 200);
}
removeDataSeller() {
  GetStorage().remove("myShopDetails");
  GetStorage().remove("PackageInfoResponse");
  GetStorage().remove("shopInfo");

  

}

 