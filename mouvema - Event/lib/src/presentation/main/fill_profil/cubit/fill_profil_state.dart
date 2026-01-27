part of 'fill_profile_cubit.dart';

enum Status { initial, loading, dateAdded, photoAdded, failed, success }

class FillProfilState extends Equatable {
  const FillProfilState({required this.status, this.errorMessage, this.data});

  final Status status;
  final String? errorMessage;
  final dynamic data;

  @override
  List<Object?> get props => [status, data, errorMessage];
}
