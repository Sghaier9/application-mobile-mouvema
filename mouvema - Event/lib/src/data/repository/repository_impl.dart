import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/failure.dart';
import '../../core/internet_checker.dart';
import '../../domain/repositories/repositories.dart';
import '../data_source/remote_data_source/cloud_firestore.dart';
import '../data_source/remote_data_source/firebase_auth.dart';
import '../data_source/remote_data_source/firebase_storage.dart';
import '../models/event.dart';
import '../models/user.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl({required this.internetChecker});

  final FirebaseAuthentication auth = FirebaseAuthentication();
  final CloudStorage storage = CloudStorage();
  final CloudFiresore firestore = CloudFiresore();

  final InternetCheckerImpl internetChecker;

  List<Event> _toLoad(List<Map<String, dynamic>> listmaps) {
    return listmaps.map((e) {
      return Event.fromfirestore(e);
    }).toList();
  }

  @override
  Future<Either<Failure, void>> continueWithFacebook() async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.continueWithFacebook();
        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.signIn(email: email, password: password);

        return right(null);
      } on FirebaseAuthException catch (e) {
        return Left(Failure(errrorMessage: e.code));
      }
    } else {
      return Left(Failure(errrorMessage: ' There is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, MyUser>> getCurrentUserInformation() async {
    if (await internetChecker.isConnected()) {
      try {
        var user = await firestore
            .getCurrentUserInformation(await auth.getCurrentUserId());

        return right(MyUser.fromFirestore(user));
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    } else {
      return left(Failure(errrorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.logOut();
        return right(null);
      } on FirebaseAuthException catch (error) {
        return left(Failure(errrorMessage: error.code));
      }
    } else {
      return Left(Failure(errrorMessage: ' There is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> fillProfil(
      {required String username,
      required String birthdate,
      required String tel,
      required Uint8List? image}) async {
    String urlimage = '';
    if (await internetChecker.isConnected()) {
      try {
        User? usr = FirebaseAuth.instance.currentUser;

        if (image != null) {
          urlimage = await storage.storeImage(
              child: 'usersProfileImages', uid: usr!.uid, image: image);
        }
        await firestore.addNewUserInformations(
            tel: tel,
            uid: usr!.uid,
            email: usr.email!,
            username: username,
            favoriteLoads: [],
            birdhdate: birthdate,
            imageLink: urlimage);

        return const Right(null);
      } on FirebaseAuthException catch (error) {
        return Left(Failure(errrorMessage: error.code));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String email,
    required String password,
  }) async {
    try {
      await auth.register(email, password);

      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(errrorMessage: error.code));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> fetchLoads() async {
    if (await internetChecker.isConnected()) {
      try {
        List<Map<String, dynamic>> list = await firestore.fetchLoads();
        var listz = _toLoad(list);

        return (right(listz));
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    }
    return left(Failure(errrorMessage: 'There is no internet connection'));
  }

  @override
  Future<Either<Failure, List<Event>>> getFiltredLoads(
      {String? adress, RangeValues? price}) async {
    if (await internetChecker.isConnected()) {
      try {
        List<Map<String, dynamic>> list =
            await firestore.getFiltredLoads(adress: adress, price: price);
        var listz = _toLoad(list);

        return (right(listz));
      } catch (e) {
        print(e);
        return left(Failure(errrorMessage: e.toString()));
      }
    }
    return left(Failure(errrorMessage: 'There is no internet connection'));
  }

  @override
  Future<Either<Failure, void>> postLoad(
      Map<String, dynamic> load, Uint8List img) async {
    if (await internetChecker.isConnected()) {
      try {
        final String imageName = '${DateTime.now().millisecondsSinceEpoch}';

        final ref =
            FirebaseStorage.instance.ref().child('images/$imageName.jpg');
        UploadTask uploadTask =
            ref.putData(img, SettableMetadata(contentType: 'image/jpeg'));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        load['image'] = downloadUrl;

        await firestore.postLoad(load, await auth.getCurrentUserId());
        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: 'Something Went Wrong'));
      }
    } else {
      return left(Failure(errrorMessage: 'There is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> addLoadToFavorites(String loadRef) async {
    if (await internetChecker.isConnected()) {
      try {
        await firestore.addToFavorites(
            loadRef: loadRef, uid: await auth.getCurrentUserId());

        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: e.toString()));
      }
    } else {
      return left(Failure(errrorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> removeLoadFromFavorites(String loadRef) async {
    if (await internetChecker.isConnected()) {
      try {
        await firestore.removeFromFavorites(
            loadRef: loadRef, uid: await auth.getCurrentUserId());

        return right(null);
      } catch (e) {
        return left(Failure(errrorMessage: 'remove load from favorite error'));
      }
    } else {
      return left(Failure(errrorMessage: 'remove load from favorite error'));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> readFavoriteLoads() async {
    if (await internetChecker.isConnected()) {
      try {
        Map<String, dynamic> user = await firestore
            .getCurrentUserInformation(await auth.getCurrentUserId());
        List<Event> favoriteLoads =
            await firestore.fetchFavoriteLoads(MyUser.fromFirestore(user));
        return right(favoriteLoads);
      } catch (e) {
        return left(Failure(errrorMessage: 'Something went wrong ,Try Later'));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> readMyLoads() async {
    if (await internetChecker.isConnected()) {
      try {
        List<Event> loads = await firestore.fetchMyPosts(
            brokerUid: await auth.getCurrentUserId());
        return right(loads);
      } catch (e) {
        return left(Failure(errrorMessage: 'Some thing Went Wrong'));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFirstTime() async {
    if (await internetChecker.isConnected()) {
      bool f = await firestore.isFirstTime(await auth.getCurrentUserId());
      return right(f);
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(
      {required String email}) async {
    if (await internetChecker.isConnected()) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        return right(null);
      } on FirebaseAuthException catch (e) {
        return left(Failure(errrorMessage: e.code));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLoads(
      {required List<String> loads}) async {
    if (await internetChecker.isConnected()) {
      try {
        await firestore.deleteLoad(loads);
        return right(null);
      } on FirebaseAuthException catch (e) {
        return left(Failure(errrorMessage: e.code));
      }
    } else {
      return left(Failure(errrorMessage: 'there is no internet connection'));
    }
  }
}
