import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/repository_impl.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required this.repositoryImpl})
      : super(const FavoritesState(status: Status.intital)) {
    getMyFavoritesLoads();
  }
  final RepositoryImpl repositoryImpl;

  void getMyFavoritesLoads({bool refresh = false}) async {
    if (!refresh) {
      emit(const FavoritesState(status: Status.loading));
    }

    var readingLoadsResult = await repositoryImpl.readFavoriteLoads();

    if (!isClosed) {
      readingLoadsResult.fold(
        (l) {
          emit(FavoritesState(status: Status.failed, message: l.errrorMessage));
        },
        (r) {
          emit(FavoritesState(status: Status.success, data: r));
        },
      );
    }
  }
}
