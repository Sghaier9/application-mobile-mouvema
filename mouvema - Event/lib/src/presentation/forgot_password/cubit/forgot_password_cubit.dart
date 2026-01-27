import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/email_checker.dart';
import '../../../data/repository/repository_impl.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._repository)
      : super(const ForgotPasswordState(status: Status.initial));

  final RepositoryImpl _repository;
  bool isEmailEmpty = false;
  void sendPasswordResetEmail({required String email}) async {
    emit(const ForgotPasswordState(status: Status.loading));

    if (!isValidEmail(email)) {
      emit(const ForgotPasswordState(status: Status.failed));
    }

    var result = await _repository.sendPasswordResetEmail(email: email);

    result.fold(
        (l) => emit(ForgotPasswordState(
            status: Status.failed, errorMessage: l.errrorMessage)),
        (r) => emit(const ForgotPasswordState(status: Status.emailSent)));
  }
}
