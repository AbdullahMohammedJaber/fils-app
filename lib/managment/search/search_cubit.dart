import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/product/item_product.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(currentRangeValues: RangeValues(1, 1000)));

  changeTypeSection(dynamic section) {
    if (section != state.typeSection) {
      emit(state.copyWith(typeSection: section));
    }
  }

  changeTypeValidity(dynamic section) {
    if (section != state.typeValidity) {
      emit(state.copyWith(typeValidity: section));
    }
  }

  changeTypeAuction(dynamic section) {
    if (section != state.typeAuction) {
      emit(state.copyWith(typeAuction: section));
    }
  }

  changeDateFilter(DateTime dateTime) {
    emit(state.copyWith(dataFilter: dateTime));
  }

  changeTimeFilter(TimeOfDay dateTime) {
    emit(state.copyWith(timeFilter: dateTime));
  }

  changeRangePrice(RangeValues price) {
    emit(state.copyWith(currentRangeValues: price));
  }

  List<Map<String, dynamic>> rateList = [
    {"id": 1, "select": false},
    {"id": 2, "select": false},
    {"id": 3, "select": false},
    {"id": 4, "select": false},
    {"id": 5, "select": false},
  ];

  functionOnClickStar(dynamic id) {
    if (id >= 1) {
      for (dynamic index = 0; index < id; index++) {
        rateList[index]['select'] = true;
      }
      for (dynamic index = id; index < rateList.length; index++) {
        rateList[index]['select'] = false;
      }
    }
    emit(
      state.copyWith(
        countRate: rateList.lastIndexWhere((element) => element['select']) + 1,
      ),
    );
  }

  changeCategory({required String name, required dynamic id}) {
    emit(state.copyWith(categoryName: name, categoryId: id));
  }

  changeStore({required String name, required dynamic id}) {
    emit(state.copyWith(storeName: name, storeId: id));
  }

  Map<String, dynamic> filterStore(String search) {
    return {
      if (search.isNotEmpty) "name": search,
      "is_auction": state.typeSection == 1 ? "0" : "1",
      if (state.categoryId != null) "categories": state.categoryId,
      "min": state.currentRangeValues.start,
      "max": state.currentRangeValues.end,
      if (state.storeId != null) "shop_id": state.storeId,
      if (state.countRate != null) "rating": state.countRate,
    };
  }

  Map<String, dynamic> filterAuction(String search) {
    return {
      if (search.isNotEmpty) "name": search,
      "is_auction": state.typeSection == 2 ? "1" : "0",
      if (state.countRate != null) "rating": state.countRate,
      if (state.dataFilter != null && state.timeFilter != null)
        "auction_end_date": mergeDateTime(state.dataFilter, state.timeFilter),
      "action_type": state.typeAuction == 1 ? "live" : "normal",
    };
  }

  String mergeDateTime(DateTime? date, TimeOfDay? time) {
    final dynamic hour = time!.hour;
    final dynamic minute = time.minute;

    final DateTime combinedDateTime = DateTime(
      date!.year,
      date.month,
      date.day,
      hour,
      minute,
    );

    return "${combinedDateTime.year.toString().padLeft(4, '0')}-"
        "${combinedDateTime.month.toString().padLeft(2, '0')}-"
        "${combinedDateTime.day.toString().padLeft(2, '0')} "
        "${combinedDateTime.hour.toString().padLeft(2, '0')}:"
        "${combinedDateTime.minute.toString().padLeft(2, '0')}:00";
  }

  bool _loading = false;
  bool _hasMore = true;
  int _page = 1;
  List<ProductListModel> _items = [];

  Future<void> getDataSearch({
    bool refresh = false,
    required String search,
  }) async {
    if (refresh) {
      _hasMore = true;
      _page = 1;
      _items.clear();
      emit(state.copyWith(loading: true));
    }else{
      if (_loading || !_hasMore) return;

    }
    _loading = true;

    final result = await UserCase().searchUserCase.callGetSearch(
      data:
          state.typeSection == 2 ? filterAuction(search) : filterStore(search),
      page: _page,
    );
    _loading = false;
    result.handle(
      onSuccess: (data) {
        final data = result.data;

        final List list = data!['data'];

        _items.addAll(list.map((e) => ProductListModel.fromJson(e)).toList());

        _hasMore = data['meta']['current_page'] < data['meta']['last_page'];
        _page++;
        emit(
          state.copyWith(
            loading: false,
            listSearch: List.from(_items),
            error: null,
            hasMore: _hasMore,
          ),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(error: message, loading: false));
      },
      onNoInternet: () {
        emit(state.copyWith(error: StringApp.noInternet, loading: false));
      },
    );
  }
}
