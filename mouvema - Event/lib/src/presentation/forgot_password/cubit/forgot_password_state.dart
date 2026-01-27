part of 'forgot_password_cubit.dart';

enum Status { initial, loading, emailSent, failed }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState(
      {required this.status, this.errorMessage, this.data});
  final Status status;

  final String? errorMessage;
  final String? data;

  @override
  List<Object?> get props => [status, errorMessage, data];
}
