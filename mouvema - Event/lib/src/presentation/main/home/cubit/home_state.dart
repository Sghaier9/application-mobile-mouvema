import 'package:equatable/equatable.dart';

import '../../../../data/models/event.dart';

enum Status { initial, loading, fetchSuccess, fetchFailed }

class HomeState extends Equatable {
  const HomeState({required this.status, this.errorMessage, this.data});
  final Status status;

  final String? errorMessage;
  final List<Event>? data;

  @override
  List<Object?> get props => [status, errorMessage, data];
}
