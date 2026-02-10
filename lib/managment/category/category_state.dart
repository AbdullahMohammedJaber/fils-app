part of 'category_cubit.dart';

class CategoryState {
  final bool loading;
  final CategoryResponse? categoryResponse;
  final String? error;

  CategoryState({this.loading = false, this.categoryResponse, this.error});

  CategoryState copyWith({
    bool? loading,
    String? error,
    CategoryResponse? categoryResponse,
  }) {
    return CategoryState(
      error: error,
      loading: loading ?? this.loading,
      categoryResponse: categoryResponse ?? this.categoryResponse,
    );
  }
}
