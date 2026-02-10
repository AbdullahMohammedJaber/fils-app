import 'package:fils/core/data/data_source/customer/wallet/wallet_data_source.dart';
import 'package:fils/core/data/response/wallet/wallet_balance_response.dart';
import 'package:fils/core/data/response/wallet/wallet_transaction.dart';
import 'package:fils/core/server/result.dart';

import '../../../../../utils/string.dart';

abstract class WalletRepo {
  Future<ApiResult<BalanceResponse>> getWallet();

  Future<ApiResult<TransactionHistoryResponse>> getWalletTransaction();

  Future<ApiResult<Map<String, dynamic>>> addMoneyWallet(String value);
}

class WalletRepoImpl extends WalletRepo {
  WalletDataSource walletDataSource;

  WalletRepoImpl(this.walletDataSource);

  @override
  Future<ApiResult<BalanceResponse>> getWallet() async {
    final result = await walletDataSource.getWallet();
    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      final balance = BalanceResponse.fromJson(result.data!);
      return ApiResult.success(
        balance,
        message: result.message,
        statusCode: result.statusCode,
      );
    }

    return ApiResult.failed(
      statusCode: result.statusCode,
      message: result.message,
    );
  }

  @override
  Future<ApiResult<TransactionHistoryResponse>> getWalletTransaction() async {
    final result = await walletDataSource.getWalletTransaction();
    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      final transaction = TransactionHistoryResponse.fromJson(result.data!);
      return ApiResult.success(
        transaction,
        message: result.message,
        statusCode: result.statusCode,
      );
    }

    return ApiResult.failed(
      statusCode: result.statusCode,
      message: result.message,
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addMoneyWallet(String value) async {
    final result = await walletDataSource.addMoneyWallet(value);
    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        message: result.message,
        statusCode: result.statusCode,
      );
    }

    return ApiResult.failed(
      statusCode: result.statusCode,
      message: result.message,
    );
  }
}
