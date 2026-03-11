// ignore_for_file: unused_field

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/auction_response.dart';
import 'package:fils/core/data/response/auction/details_auction_response.dart';
import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/features/coustamer/wallet/done_pay.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/global_function/attachment_manage.dart';
import 'package:fils/utils/global_function/printer.dart';
import 'package:fils/utils/global_function/timer_format.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import '../../core/data/response/auction/bids_response.dart';
import '../../utils/global_function/number_format.dart';

part 'auction_state.dart';

class AuctionCubit extends Cubit<AuctionState> {
  AuctionCubit() : super(AuctionState());

  int _page = 1;
  bool _haseMore = false;
  bool _loading = false;
  final List<AuctionResponse> _items = [];

  Future<void> getAllAuction({refresh = false}) async {
    if (refresh) {
      _page = 1;
      _haseMore = true;

      _items.clear();
      emit(state.copyWith(loading: true));
    }

    if (_loading || !_haseMore) return;
    _loading = true;
    final result = await UserCase().auctionUserCase.callAllAuction(page: _page);
    result.handle(
      onSuccess: (data) {
        final data = result.data!;
        _items.addAll(data.data);
        _haseMore = data.meta.currentPage < data.meta.lastPage;
        _page++;
        emit(
          state.copyWith(
            hasMore: _haseMore,
            loading: false,
            auctionList: List.from(_items),
          ),
        );
      },
      onNoInternet: () {
        emit(state.copyWith(error: StringApp.noInternet, loading: false));
      },
      onFailed: (message) {
        emit(state.copyWith(error: message, loading: false));
      },
    );
    _loading = false;
  }

  int _pageAuctionCategory = 1;
  bool _haseMoreAuctionCategory = false;
  bool _loadingAuctionCategory = false;
  final List<AuctionResponse> _itemsAuctionCategory = [];

  Future<void> getAllAuctionCategory({
    refresh = false,
    required int categoryId,
  }) async {
    if (refresh) {
      _pageAuctionCategory = 1;
      _haseMoreAuctionCategory = true;

      _itemsAuctionCategory.clear();
      emit(state.copyWith(loadingAuctionCategory: true));
    }

    if (_loadingAuctionCategory || !_haseMoreAuctionCategory) return;
    _loadingAuctionCategory = true;
    final result = await UserCase().auctionUserCase.callAllAuctionCategory(
      page: _page,
      categoryId: categoryId,
    );
    result.handle(
      onSuccess: (data) {
        final data = result.data!;
        _itemsAuctionCategory.addAll(data.data);
        _haseMoreAuctionCategory = data.meta.currentPage < data.meta.lastPage;
        _pageAuctionCategory++;
        emit(
          state.copyWith(
            hasMoreAuctionCategory: _haseMoreAuctionCategory,
            loadingAuctionCategory: false,
            auctionListAuctionCategory: List.from(_itemsAuctionCategory),
          ),
        );
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            errorAuctionCategory: StringApp.noInternet,
            loadingAuctionCategory: false,
          ),
        );
      },
      onFailed: (message) {
        emit(
          state.copyWith(
            errorAuctionCategory: message,
            loadingAuctionCategory: false,
          ),
        );
      },
    );
    _loadingAuctionCategory = false;
  }

  Future<void> fetchAuctionDetails(dynamic id) async {
    emit(state.copyWith(loadingDetails: true, errorDetails: null));
    final result = await UserCase().auctionUserCase.callAuctionDetails(id: id);
    result.handle(
      onSuccess: (data) {
        final data = result.data!;
        emit(
          state.copyWith(loadingDetails: false, detailsAuctionResponse: data),
        );
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            loadingDetails: false,
            errorDetails: StringApp.noInternet,
          ),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(loadingDetails: false, errorDetails: message));
      },
    );
  }

  StreamSubscription<DatabaseEvent>? _bidsSubscription;

  double totalPriceBid = 0.0;

   changeListenerToPriceBid() {
    totalPriceBid = 0.0;
    List<double> bidAmounts = [];
    if(state.bids.isNotEmpty){
      for (var element in state.bids) {
        bidAmounts.add(extractDouble(element.bid.amount));
      }
      totalPriceBid = bidAmounts[0];

      for (int i = 0; i < bidAmounts.length; i++) {
        if (bidAmounts[i] > totalPriceBid) {
          totalPriceBid = bidAmounts[i];
        }
      }
    }
   

    emit(state.copyWith(totalPriceBid: totalPriceBid));
  }

  void fetchBids(dynamic auctionId) {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    _bidsSubscription = FirebaseDatabase.instance
        .ref()
        .child('bids/$auctionId')
        .onValue
        .listen(
          (event) {
            try {
              List<BidResponse> updatedBids = [];

              if (event.snapshot.value != null) {
                final Map<dynamic, dynamic> data =
                    event.snapshot.value as Map<dynamic, dynamic>;

                updatedBids =
                    data.entries
                        .map(
                          (entry) => BidResponse.fromJson(
                            Map<String, dynamic>.from(entry.value),
                          ),
                        )
                        .toList();

                updatedBids.sort((a, b) => b.bid.bidAt.compareTo(a.bid.bidAt));
              }

              emit(
                state.copyWith(
                  bids: updatedBids,
                  isLoading: false,
                  errorMessage: null,
                ),
              );
              changeListenerToPriceBid();
            } catch (e) {
              emit(
                state.copyWith(
                  isLoading: false,
                  errorMessage: "Failed to fetch bids: $e",
                ),
              );
            }
          },
          onError: (error) {
            emit(
              state.copyWith(isLoading: false, errorMessage: "Error: $error"),
            );
          },
        );
  }

  StreamSubscription<DatabaseEvent>? _giftsSubscription;
  Timer? _giftBoxTimer;

  void fetchGift(dynamic auctionId) {
    _giftsSubscription?.cancel();
    emit(state.copyWith(loadingGift: true));

    _giftsSubscription = FirebaseDatabase.instance
        .ref()
        .child('gifts/$auctionId')
        .onValue
        .listen(
          (event) {
            try {
              if (event.snapshot.value == null) {
                emit(
                  state.copyWith(
                    gifts: [],
                    giftsId: [],
                    showGiftBox: false,
                    loadingGift: false,
                  ),
                );
                return;
              }

              final Map<dynamic, dynamic> data =
                  event.snapshot.value as Map<dynamic, dynamic>;

              final List<Map<String, dynamic>> fetchedGifts =
                  data.entries
                      .map((entry) => Map<String, dynamic>.from(entry.value))
                      .where((gift) => gift['status'].toString() == 'Pending')
                      .where(
                        (gift) =>
                            gift['receiver_id'].toString() ==
                            getUser()!.user!.id,
                      )
                      .toList();

              List<String> updatedGiftsId = List.from(state.giftsId);
              bool showGiftBox = state.showGiftBox;
              String messageNewGift = state.messageNewGift;
              String amountNewGift = state.amountNewGift;

              for (var element in fetchedGifts) {
                final giftId = element['gift_id'].toString();
                if (!updatedGiftsId.contains(giftId)) {
                  messageNewGift = element['message'];
                  amountNewGift = element['amount'].toString();
                  showGiftBox = true;

                  _giftBoxTimer?.cancel();
                  _giftBoxTimer = Timer(const Duration(seconds: 5), () {
                    emit(state.copyWith(showGiftBox: false));
                  });

                  updatedGiftsId.add(giftId);
                }
              }

              emit(
                state.copyWith(
                  gifts: fetchedGifts,
                  giftsId: updatedGiftsId,
                  showGiftBox: showGiftBox,
                  messageNewGift: messageNewGift,
                  amountNewGift: amountNewGift,
                  loadingGift: false,
                ),
              );
            } catch (e) {
              emit(
                state.copyWith(
                  loadingGift: false,
                  errorMessageGift: "Failed to fetch gifts: $e",
                ),
              );
            }
          },
          onError: (error) {
            emit(
              state.copyWith(
                loadingGift: false,
                errorMessageGift: "Error: $error",
              ),
            );
          },
        );
  }

  closeGiftBox() {
    emit(state.copyWith(showGiftBox: false));
    _giftBoxTimer?.cancel();
  }

  void disposeGiftListener() {
    emit(state.copyWith(showGiftBox: false));

    _giftsSubscription?.cancel();
    _giftBoxTimer?.cancel();
  }

  void validateBid({required double bid}) async {
    double amount = 0.0;
    print(state.detailsAuctionResponse!.data.assuranceFee);
    if (bid > 0 && state.detailsAuctionResponse!.data.assuranceFee == 0) {
      if (state.bids.isNotEmpty) {
        amount = bid + state.totalPriceBid;
      } else {
        amount =
            bid + extractDouble(state.detailsAuctionResponse!.data.minBidPrice);
      }
      if (checkBid(bid)) {
        printGreen("Done Place Bid");
        sendBidServer(
          idAuction: state.detailsAuctionResponse!.data.id,
          amount: amount,
          bid: bid,
        );
      } else {
        print("=============> error");
      }
    } else {
      print(state.detailsAuctionResponse!.data.isPaidAssuranceFee);
      if (!state.detailsAuctionResponse!.data.isPaidAssuranceFee) {
        showMessage(
          "${"You must pay a deposit of ".tr()}${state.detailsAuctionResponse!.data.assuranceFee}${" KWD to be able to bid in this room.".tr()}",
          value: false,
        );
        Future.delayed(Duration(seconds: 1), () async {
          await payFee(state.detailsAuctionResponse!.data.id);
        });
      } else {
        if (state.bids.isNotEmpty) {
          amount = bid + state.totalPriceBid;
        } else {
          amount =
              bid +
              extractDouble(state.detailsAuctionResponse!.data.minBidPrice);
        }
        if (checkBid(bid)) {
          printGreen("Done Place Bid");
          sendBidServer(
            idAuction: state.detailsAuctionResponse!.data.id,
            amount: amount,
            bid: bid,
          );
        } else {
          print("error2");
        }
      }
    }
  }

  bool checkBid(double bid) {
    if (state.totalPriceBid > 0 && state.totalPriceBid <= 100) {
      return true;
    } else if (state.totalPriceBid > 100 && state.totalPriceBid <= 500) {
      if (bid < 10) {
        showMessage("${"The Min Bid 10".tr()}KWD", value: false);

        return false;
      } else {
        return true;
      }
    } else if (state.totalPriceBid > 500 && state.totalPriceBid <= 1000) {
      if (bid < 50) {
        showMessage("${"The Min Bid 50".tr()}KWD", value: false);

        return false;
      } else {
        return true;
      }
    } else if (state.totalPriceBid > 1000) {
      if (bid < 100) {
        showMessage("${"The Min Bid 100".tr()}KWD", value: false);
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  Future<void> payFee(int id) async {
    showBoatToast();
    DioClient dioClient = DioClient();
    final result = await dioClient.request(
      path: 'auction/assurance-fee/$id/pay',
      method: 'POST',
      data: {"payment_provider": "ecom"},
    );
    closeAllLoading();
    if (result.isSuccess) {
      ToWithFade(
        AppRoutes.webViewAuction,
        arguments: [result.data['link'], PaymentType.auction],
      );
    }
  }

  Future<void> functionWebView({
    required String url,
    PaymentType paymentType = PaymentType.cart,
  }) async {
    final DioClient dioClient = DioClient();

    Navigator.pop(NavigationService.navigatorKey.currentContext!);
    showBoatToast();
    final response = await dioClient.request(path: url, method: 'GET');
    closeAllLoading();
    if (response.statusCode == 200) {
      showMessage("Done".tr(), value: true);
      state.detailsAuctionResponse!.data.isPaidAssuranceFee = true;
    } else {
      showModalBottomSheet(
        context: NavigationService.navigatorKey.currentContext!,
        elevation: 1,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: white,
        constraints: BoxConstraints(maxHeight: heigth * 0.6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return const faieldPay();
        },
      );
    }
  }

  Future<void> sendBidServer({
    required int idAuction,
    required double amount,
    required double bid,
  }) async {
    showBoatToast();

    final result = await UserCase().auctionUserCase.placeBid(
      productId: idAuction,
      amount: amount,
      bid: bid,
    );
    closeAllLoading();
    result.handle(
      onSuccess: (data) {},
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  @override
  Future<void> close() {
    _bidsSubscription?.cancel();
    _giftsSubscription?.cancel();
    _giftBoxTimer?.cancel();
    return super.close();
  }

  clearList() {
    emit(AuctionState.clearList());
  }

  // Control Form Add Auction

  changeCategoryData({required int id, required String name}) {
    emit(state.copyWith(idCategory: id, nameCategory: name));
  }

  functionChangeCategoryListData(List<Category> categorys) {
    emit(
      state.copyWith(
        categoresId: categorys.map((e) => int.parse(e.id.toString())).toList(),
        nameCategores: categorys.map((e) => e.name).toList().join(', '),
      ),
    );
  }

  functionSelectImage(BuildContext context) async {
    try {
      emit(state.copyWith(idImage: null, imageProduct: null));
      final result = await pickEditAndUploadImage(
        context: context,
        endpoint: "file/upload",
        fileKey: "aiz_file",
      );
      if (result != null) {
        emit(
          state.copyWith(
            imageProduct: result.file,
            idImage: int.parse(result.imageId),
          ),
        );
      } else {
        emit(state.copyWith(idImage: null, imageProduct: null));
      }
    } catch (e) {
      emit(state.copyWith(idImage: null, imageProduct: null));
    }
  }

  clearAttachment() {
    emit(AuctionState.clearAttachment());
  }

  clearForm() {
    emit(AuctionState.clearForm());
  }

  Future<void> addAuction({
    required String name,
    required String price,
    required String fee,
    required String descreption,
    required DateTime dataStart,
    required DateTime dataEnd,
    required TimeOfDay timeStart,
    required TimeOfDay timeEnd,
  }) async {
    if (dataStart.isAfter(dataEnd)) {
      showMessage(
        "The start date cannot be greater than the end date".tr(),
        value: false,
      );
    } else {
      List<int> ids = [];
      for (var element in state.categoresId!) {
        ids.add(element);
      }
      ids.add(state.idCategory!);

      emit(state.copyWith(loadingForm: true));
      final result = await UserCase().auctionUserCase.addAuction(
        data: {
          "name": name,
          "brand_id": "1", // static
          "unit": "kg", // static
          "weight": "0.5", // static

          "tags": [
            "[{\"value\": \"auction\"}, {\"value\": \"exclusive\"}, {\"value\": \"rare\"}]",
          ],

          "thumbnail_img": state.idImage,
          "starting_bid": price,
          "description": descreption,
          "auction_date_range":
              "${formatDate2(dataStart)} ${formatTimeOfDay2(timeStart)} to ${formatDate2(dataEnd)} ${formatTimeOfDay2(timeEnd)}",
          "category_ids":
              ids.map((e) {
                return e;
              }).toList(),
          "category_id": state.idCategory,
          "auction_type": "normal",
          "assurance_fee": fee.isEmpty ? "0" : fee,
          "lang": getLocal(),
        },
      );
      emit(state.copyWith(loadingForm: false));

      result.handle(
        onSuccess: (data) {
          showMessage(data['message'], value: true);
          Navigator.pop(NavigationService.navigatorKey.currentContext!);
          getAllAuction(refresh: true);
        },
        onFailed: (message) {
          showMessage(message, value: false);
        },
        onNoInternet: () {
          showMessage(StringApp.noInternet, value: false);
        },
      );
    }
  }
}
