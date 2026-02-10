part of 'suggest_product_cubit.dart';

@immutable
sealed class SuggestProductState {}

final class SuggestProductInitial extends SuggestProductState {}

class SuggestedProductsLoading extends SuggestProductState {}

class SuggestedProductsLoaded extends SuggestProductState {
  final List<ProductListModel> items;
  final bool hasMore;

  SuggestedProductsLoaded({required this.items, required this.hasMore});
}

class SuggestedProductsError extends SuggestProductState {
  final String message;

  SuggestedProductsError(this.message);
}
