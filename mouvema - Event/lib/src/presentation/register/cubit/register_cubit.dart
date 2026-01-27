import 'package:flutter/material.dart' show TextEditingController;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/repository_impl.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repositoryImpl)
      : super(const RegisterState(status: Status.initial));

  final RepositoryImpl _repositoryImpl;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register() async {
    emit(const RegisterState(status: Status.loading));

    var result = await _repositoryImpl.register(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    result.fold(
      (failure) => emit(RegisterState(
          status: Status.registerFailed, errorMessage: failure.errrorMessage)),
      (vd) {
        emit(const RegisterState(status: Status.registerSuccess));
      },
    );
  }
}
