import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/data/models/user.dart';
import 'package:mouvema/src/data/repository/repository_impl.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_state.dart';

import '../../../../core/failure.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repositoryImpl)
      : super(const ProfileState(status: Status.initial, errorMessage: null)) {
    getProfile();
  }

  final RepositoryImpl repositoryImpl;
  bool darkTheme = false;

  void getProfile({bool isRefresh = false}) async {
    if (!isClosed) {
      if (!isRefresh) {
        emit(const ProfileState(status: Status.loading));
      }
      Either<Failure, MyUser> result =
          await repositoryImpl.getCurrentUserInformation();
      result.fold((l) {
        emit(
            ProfileState(status: Status.failed, errorMessage: l.errrorMessage));
      }, (r) {
        emit(ProfileState(status: Status.success, data: r));
      });
    }
  }

  void logOut() async {
    const ProfileState(status: Status.loading);
    emit(const ProfileState(status: Status.loading));
    if (!isClosed) {
      emit(const ProfileState(status: Status.loading));
      Either<Failure, void> result = await repositoryImpl.logOut();
      result.fold((l) {
        emit(
            ProfileState(status: Status.failed, errorMessage: l.errrorMessage));
      }, (r) {
        emit(const ProfileState(status: Status.logOut));
      });
    }
  }
}
