import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/failure.dart';
import '../../data/models/event.dart';
import '../../data/models/user.dart';

abstract class Repository {
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> continueWithFacebook();
  Future<Either<Failure, void>> register({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> fillProfil(
      {required String username,
      required String birthdate,
      required String tel,
      required Uint8List? image});
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, bool>> isFirstTime();
  Future<Either<Failure, List<Event?>>> fetchLoads();
  Future<Either<Failure, void>> postLoad(
      Map<String, dynamic> load, Uint8List img);
  Future<Either<Failure, MyUser>> getCurrentUserInformation();
  Future<Either<Failure, void>> addLoadToFavorites(String loadRef);
  Future<Either<Failure, void>> removeLoadFromFavorites(String loadRef);
  Future<Either<Failure, List<Event>>> readFavoriteLoads();
  Future<Either<Failure, List<Event>>> readMyLoads();
  Future<Either<Failure, void>> sendPasswordResetEmail({required String email});
  Future<Either<Failure, void>> deleteLoads({required List<String> loads});
  Future<Either<Failure, List<Event>>> getFiltredLoads(
      {String? adress, RangeValues? price});
}
