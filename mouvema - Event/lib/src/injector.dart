import 'package:get_it/get_it.dart';

import '../src/presentation/login/cubit/login_cubit.dart';
import 'presentation/main/favorite_events/cubit/favorites_cubit.dart';
import '../src/presentation/main/home/cubit/home_cubit.dart';
import 'presentation/main/post_event/cubits/post_event_cubit.dart';
import '../src/presentation/register/cubit/register_cubit.dart';
import '../src/presentation/main/fill_profil/cubit/fill_profile_cubit.dart';
import 'core/internet_checker.dart';
import 'data/data_source/remote_data_source/cloud_firestore.dart';
import 'data/data_source/remote_data_source/firebase_auth.dart';
import 'data/data_source/remote_data_source/firebase_storage.dart';
import 'data/repository/repository_impl.dart';

GetIt instance = GetIt.instance;

Future<void> globalInstances() async {
  instance
      .registerLazySingleton<InternetCheckerImpl>(() => InternetCheckerImpl());

  instance.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthentication());

  instance.registerLazySingleton<CloudFiresore>(() => CloudFiresore());

  instance.registerLazySingleton<CloudStorage>(() => CloudStorage());

  instance.registerLazySingleton<RepositoryImpl>(
      () => RepositoryImpl(internetChecker: instance()));
}

void loginInstances() {
  if (!GetIt.I.isRegistered<LoginScreenCubit>()) {
    instance
        .registerFactory<LoginScreenCubit>(() => LoginScreenCubit(instance()));
  }
}

void favorisInstances() {
  if (!GetIt.I.isRegistered<FavoritesCubit>()) {
    instance.registerFactory<FavoritesCubit>(
        () => FavoritesCubit(repositoryImpl: instance()));
  }
}

void registerInstances() {
  if (!GetIt.I.isRegistered<RegisterCubit>()) {
    instance.registerFactory<RegisterCubit>(() => RegisterCubit(instance()));
  }
}

void homeInstances() {
  if (!GetIt.I.isRegistered<HomeCubit>()) {
    instance.registerFactory<HomeCubit>(() => HomeCubit(instance()));
  }
}

void postInstances() {
  if (!GetIt.I.isRegistered<PostCubit>()) {
    instance.registerFactory<PostCubit>(() => PostCubit(instance()));
  }
}

void fillProfileInstances() {
  if (!GetIt.I.isRegistered<FillProfilCubit>()) {
    instance
        .registerFactory<FillProfilCubit>(() => FillProfilCubit(instance()));
  }
}
