part of 'login_cubit.dart';

enum Status { initial, loading, success, failed, emailEmpty, passwordEmpty }

class LoginScreenState extends Equatable {
  const LoginScreenState({required this.status, this.errorMessage, this.data});

  final Status status;
  final String? errorMessage;
  final String? data;

  @override
  List<Object?> get props => [status, errorMessage, data];
}
