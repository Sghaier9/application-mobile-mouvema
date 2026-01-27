import 'package:equatable/equatable.dart';
import 'package:mouvema/src/data/models/user.dart';

enum Status { initial, loading, success, failed, logOut }

class ProfileState extends Equatable {
  const ProfileState({required this.status, this.data, this.errorMessage});

  final Status status;
  final MyUser? data;
  final String? errorMessage;
  @override
  List<Object?> get props => [status, errorMessage, data];
}
