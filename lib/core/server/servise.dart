bool testMode = false;

class ApiService {
  ApiService._();

  static String domain =
      testMode
          ? "https://stage.fils.app/api/v1/"
          : "https://dashboard.fils.app/api/v1/";
  static String login = "auth/login";
  static String haraj = "classified/public";
  static String detailsHaraj = "classified/product-details";
  static String addHaraj = "classified/store";
  static String confirmCode = "auth/confirm_code";
  static String register = "auth/signup";
  static String logout = "auth/logout";
  static String home = "home";
  static String suggestProduct = "suggested-products";
  static String wallet = "wallet/balance";
  static String walletTransaction = "balance/transactions";
  static String walletCharge = "wallet/charge";
  static String cart = "carts";
  static String categories = "categories";
  static String subCategories = "sub-categories";
  static String favorites = "wishlists";
  static String favoritesRemove = "wishlists-remove-product";
  static String favoritesAdd = "wishlists-add-product";
  static String products = "products";
  static String deleteAccount = "delete-my-account";
  static String search = "products/search";
  static String chatBot = "chat";
  static String addCart = "carts/add";
  static String onlinePayment = "online-pay/init";
  static String reel = "reel";
  static String cartProcess = "carts/process";
  static String shops = "shops";
  static String auction = "auction/products";
  static String auctionInCategory = "auction/products/sub-category";
  static String productShops = "products/seller";
  static String storeInCategory = "category/sub-category/shops/find";
  static String notifications = "all-notification";
  static String verifyResetPassword = "auth/password/verify-reset-code";
  static String createNewPassword = 'auth/password/confirm_reset';
  static String productSellerCategories = "products/seller-categories";
  static String profileSwitchAccount = "profile/switch-account";
  static String supportTicket = "support-ticket";
  static String profileUpdate = "profile/update";
  static String validateCart = "cart/validate-before-payment";
  static String addresses = "addresses";
  static String paymentMethods = "payment-types?mode=order";
  static String createOrder = "order/store";
  static String forgetPassword = "auth/password/forget_request";
  static String resendCode = "auth/resend_code";
  static String placeBid = "auction/place-bid?is_auction=1";
  static String socialLogin = "auth/social-login";
  static String addAuctionForm = "auction/products/store";

  
}

class ApiServiceSeller {
  ApiServiceSeller._();

  static String domain =
      testMode
          ? "https://stage.fils.app/api/v2/seller/"
          : "https://dashboard.fils.app/api/v2/seller/";
  static String home = "home";
  static String packages = "seller-packages-list";
  static String payPackages = "seller-package/purchase-package";
  static String productsAdd = "products/add";
  static String productsEdit = "products/update";  
  static String myShops = "my-shops";
  static String allProduct = "products/all";
  static String createShop = "shop-store";
  static String packageInfo = "get-current-package";
  static String wallet = "wallet";
  static String detailsProductSeller = "products/edit";
  static String deleteProduct = "product/delete";
  static String colorList = "products/colors";
  static String sizeList = "products/attributes";
  static String auctionSeller = "auction-products";
  static String addAuctionSeller = "auction-products/create";
  static String orders = 'orders';
  static String listShippingAddress = 'shipping-adress/list';

}
