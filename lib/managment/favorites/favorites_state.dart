part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

class FavoritesProductsLoading extends FavoritesState {}

class FavoritesChangeTapBar extends FavoritesState {}

class FavoritesProductsLoaded extends FavoritesState {
  final List<ProductListModel> items;
  final bool hasMore;

  FavoritesProductsLoaded({required this.items, required this.hasMore});
}

class FavoritesProductsError extends FavoritesState {
  final String message;

  FavoritesProductsError(this.message);
}

class AddRemoveFav extends FavoritesState {}
