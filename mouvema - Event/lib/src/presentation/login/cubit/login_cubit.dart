import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/failure.dart';
import '../../../data/repository/repository_impl.dart';

part 'login_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(this.repositoryImpl)
      : super(const LoginScreenState(status: Status.initial));
  RepositoryImpl repositoryImpl;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  bool _isvalid() {
    bool valid = true;
    if (_emailController.text.isEmpty) {
      emit(const LoginScreenState(status: Status.emailEmpty));

      valid = false;
    }

    if (_passwordController.text.isEmpty) {
      emit(const LoginScreenState(status: Status.emailEmpty));
      valid = false;
    }
    return valid;
  }

  void logIn() async {
    if (!_isvalid()) {
      return;
    }
    emit(const LoginScreenState(status: Status.loading));
    Either<Failure, void> result = await repositoryImpl.signIn(
        _emailController.text, _passwordController.text);

    result.fold(
        (failure) => emit(LoginScreenState(
            status: Status.failed,
            errorMessage: failure.errrorMessage)), (complete) async {
      emit(const LoginScreenState(status: Status.success));
    });
  }

  void continueWithFacebook() async {
    emit(const LoginScreenState(status: Status.loading));

    Either<Failure, void> result = await repositoryImpl.continueWithFacebook();
    result.fold((failure) {
      emit(LoginScreenState(
          status: Status.failed, errorMessage: failure.errrorMessage));
    }, (success) {
      emit(const LoginScreenState(status: Status.success));
    });
  }
}
