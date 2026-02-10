import 'package:fils/core/data/response/wallet/wallet_transaction.dart';
import 'package:flutter/material.dart';

import '../../core/data/response/wallet/wallet_balance_response.dart';

@immutable
class WalletState {
  final bool isLoadingWallet;
  final bool isLoadingTransaction;
  final bool isLoadingAddMoneyWallet;
  final BalanceResponse? balance;
  final TransactionHistoryResponse? transactions;
  final String? walletError;
  final String? transactionError;

  const WalletState({
    this.isLoadingWallet = false,
    this.isLoadingTransaction = false,
    this.isLoadingAddMoneyWallet = false,
    this.balance,
    this.transactions,
    this.walletError,
    this.transactionError,
  });

  WalletState copyWith({
    bool? isLoadingWallet,
    bool? isLoadingTransaction,
    bool? isLoadingAddMoneyWallet,
    BalanceResponse? balance,
    TransactionHistoryResponse? transactions,
    String? walletError,
    String? transactionError,
  }) {
    return WalletState(
      isLoadingWallet: isLoadingWallet ?? this.isLoadingWallet,
      isLoadingTransaction: isLoadingTransaction ?? this.isLoadingTransaction,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      walletError: walletError,
      transactionError: transactionError,
      isLoadingAddMoneyWallet:
          isLoadingAddMoneyWallet ?? this.isLoadingAddMoneyWallet,
    );
  }
}
