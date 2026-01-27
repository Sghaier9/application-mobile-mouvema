part of 'register_cubit.dart';

enum Status { initial, loading, registerSuccess, registerFailed }

class RegisterState extends Equatable {
  const RegisterState({required this.status, this.errorMessage});

  final Status status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];
}
