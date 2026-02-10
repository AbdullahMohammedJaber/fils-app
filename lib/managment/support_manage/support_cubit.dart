import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());

  Future<void> supportTicket({required String message}) async {
    emit(SupportLoading());
    try {
     
      await UserCase().profileUseCase.supportTicket(message: message);

      emit(SupportSuccess());
    } catch (e) {
      emit(SupportFailure());
    }
  }
}
