import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure.dart';
import '../../../../data/models/event.dart';
import '../../../../domain/repositories/repositories.dart';
import 'my_events_state.dart';

class MyLoadsCubit extends Cubit<MyloadsState> {
  MyLoadsCubit(this._repository)
      : super(const MyloadsState(status: Status.initial)) {
    fetchMyLoads();
  }

  final Repository _repository;

  void fetchMyLoads({bool refresh = false}) async {
    if (!refresh) {
      emit(const MyloadsState(status: Status.loading));
    }

    Either<Failure, List<Event>> result = await _repository.readMyLoads();

    result.fold(
        (l) =>
            emit(MyloadsState(status: Status.failed, message: l.errrorMessage)),
        (r) => emit(MyloadsState(status: Status.success, data: r)));
  }

  void deleteLoads(List<String> loads) async {
    Either<Failure, void> result = await _repository.deleteLoads(loads: loads);
    result.fold((l) {
      emit(MyloadsState(status: Status.failed, message: l.errrorMessage));
    }, (r) {
      fetchMyLoads();
    });
  }
}
