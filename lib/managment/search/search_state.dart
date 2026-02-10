part of 'search_cubit.dart';

@immutable
class SearchState {
  final int typeSection; //  1. store 2. auction
  final int typeValidity; //  1. exp  2. valid
  final int typeAuction; //  1. normal  2. live
  final DateTime? dataFilter;
  final TimeOfDay? timeFilter;
  final RangeValues currentRangeValues;
  final int? countRate;
  final String? categoryName;
  final int? categoryId;
  final String? storeName;
  final int? storeId;
  final bool loading;
  final bool hasMore;
  final String? error;
  final List<ProductListModel>? listSearch;

  const SearchState({
    this.typeSection = 1,
    this.loading = true,
    this.typeValidity = 2,
    this.hasMore = false,
    this.typeAuction = 1,
    this.dataFilter,
    this.timeFilter,
    required this.currentRangeValues,
    this.countRate,
    this.categoryName,
    this.categoryId,
    this.storeName,
    this.storeId,
    this.error,
    this.listSearch,
  });

  SearchState copyWith({
    int? typeSection,
    int? typeValidity,
    DateTime? dataFilter,
    TimeOfDay? timeFilter,
    RangeValues? currentRangeValues,
    int? countRate,
    String? categoryName,
    int? categoryId,
    String? storeName,
    int? storeId,
    int? typeAuction,
    bool? loading,
    bool? hasMore,
    String? error,
    List<ProductListModel>? listSearch,
  }) {
    return SearchState(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      storeName: storeName ?? this.storeName,
      storeId: storeId ?? this.storeId,
      countRate: countRate,
      currentRangeValues: currentRangeValues ?? this.currentRangeValues,
      dataFilter: dataFilter ?? DateTime.now(),
      timeFilter: timeFilter ?? TimeOfDay.now(),
      typeAuction: typeAuction ?? this.typeAuction,
      typeSection: typeSection ?? this.typeSection,
      typeValidity: typeValidity ?? this.typeValidity,
      loading: loading ?? this.loading,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      listSearch: listSearch ?? [],
    );
  }
}
