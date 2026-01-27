import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart' show ScrollController;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/presentation/main/home/cubit/home_state.dart';
import '../../../../core/failure.dart';
import '../../../../data/models/event.dart';
import '../../../../data/repository/repository_impl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repos) : super(const HomeState(status: Status.initial)) {
    filterLoads();
    _checkFirstTime();
  }
  final RepositoryImpl repos;
  // final ScrollController _scrollController = ScrollController();
  List<Event> listLoads = [];
  bool isFirstTime = false;

  void _checkFirstTime() async {
    var result = await repos.isFirstTime();
    result.fold((l) {
      emit(
          HomeState(status: Status.fetchFailed, errorMessage: l.errrorMessage));
    }, (r) {
      isFirstTime = r;
    });
  }

  void filterLoads({String? adress, RangeValues? price}) async {
    if (!isClosed) {
      emit(const HomeState(status: Status.loading));

      Either<Failure, List<Event>> result =
          await repos.getFiltredLoads(adress: adress, price: price);
      result.fold(
        (failure) {
          emit(HomeState(
              status: Status.fetchFailed, errorMessage: failure.errrorMessage));
        },
        (loads) {
          listLoads = loads;
          emit(HomeState(status: Status.fetchSuccess, data: loads));
        },
      );
    }
  }

  void fetchLoads({bool isrefresh = false}) async {
    if (!isClosed) {
      if (!isrefresh) {
        emit(const HomeState(status: Status.loading));
      }
      Either<Failure, List<Event>> result = await repos.fetchLoads();
      result.fold(
        (failure) {
          emit(HomeState(
              status: Status.fetchFailed, errorMessage: failure.errrorMessage));
        },
        (loads) {
          listLoads.addAll(loads);
          emit(HomeState(status: Status.fetchSuccess, data: loads));
        },
      );
    }
  }
}
