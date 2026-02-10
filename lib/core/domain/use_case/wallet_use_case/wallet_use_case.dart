import 'package:fils/core/data/response/wallet/wallet_balance_response.dart';
import 'package:fils/core/data/response/wallet/wallet_seller.dart';
import 'package:fils/core/data/response/wallet/wallet_transaction.dart';
import 'package:fils/core/domain/reposetry/wallet/coustomer/wallet_repostary.dart';
import 'package:fils/core/domain/reposetry/wallet/seller/wallet_seller.dart';
import 'package:fils/core/server/result.dart';

class WalletUseCase {
  WalletRepoImpl walletRepo;

  WalletUseCase(this.walletRepo);

  Future<ApiResult<BalanceResponse>> callWallet() async {
    return await walletRepo.getWallet();
  }

  Future<ApiResult<TransactionHistoryResponse>> callWalletTransaction() async {
    return await walletRepo.getWalletTransaction();
  }

  Future<ApiResult<Map<String, dynamic>>> addMoneyWallet(String value) async {
    return await walletRepo.addMoneyWallet(value);
  }
}

class WalletSellerUseCase {
  WalletSellerRepoImpl walletSellerRepoImpl;
  WalletSellerUseCase(this.walletSellerRepoImpl);
  Future<ApiResult<WalletSellerResponse>> callGetWallet() async {
    return await walletSellerRepoImpl.getWallet();
  }
}
