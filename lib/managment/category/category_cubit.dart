import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/string.dart';
 
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState());

  Future<void> functionFetchCategory() async {
    emit(state.copyWith(loading: true, error: null));

    final result = await UserCase().categoryUserCase.callCategory();
    result.handle(
      onSuccess: (data) {
        emit(
          state.copyWith(error: null, loading: false, categoryResponse: data),
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

   Future<void> functionFetchSubCategory({required int categoryId}) async {
    emit(state.copyWith(loading: true, error: null));

    final result = await UserCase().categoryUserCase.callSubCategory(categoryId:categoryId );
    result.handle(
      onSuccess: (data) {
        emit(
          state.copyWith(error: null, loading: false, categoryResponse: data),
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
