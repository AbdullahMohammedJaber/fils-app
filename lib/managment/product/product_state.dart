part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductAllLoading extends ProductState {}

class ProductAllLoaded extends ProductState {
  final List<ProductListModel> items;
  final bool hasMore;

  ProductAllLoaded({required this.items, required this.hasMore});
}

class ProductAllError extends ProductState {
  final String error;

  ProductAllError({required this.error});
}
