part of 'haraj_home_cubit.dart';

class HarajHomeState {
  final bool loading;
  final String? error;
  final List<MarketOpenResponse> products;
  final bool hasMore;
  HarajHomeState({this.loading = false, this.error, required this.products , this.hasMore = true});

  HarajHomeState copyWith({
    bool? loading,

    String? error,

    bool? hasMore,

    List<MarketOpenResponse>? product,
  }) {
    return HarajHomeState(
      loading: loading ?? this.loading,
      error: error,
hasMore: hasMore??this.hasMore,
      products: product ?? products,
    );
  }
}
