import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/event.dart';
import '../../models/user.dart';

class CloudFiresore {
  final _firestore = FirebaseFirestore.instance;
  String collectionrRef = 'users';
  String documentRef = '';

  Future<bool> isFirstTime(String uid) async {
    // Check if the user exists in Firestore by their UID
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return false; // User is registered in Firestore
    }

    return true; // User is not registered in Firestore
  }

  Future<List<Event>> fetchMyPosts({required String brokerUid}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('loads')
        .where('respUid', isEqualTo: brokerUid)
        .get();

    return querySnapshot.docs.map((load) {
      return Event.fromfirestore(load.data());
    }).toList();
  }

  Future<void> addToFavorites(
      {required String loadRef, required String uid}) async {
    await _firestore.collection('users').doc(uid).update({
      'favoriteLoads': FieldValue.arrayUnion([loadRef]),
    });
  }

  Future<void> removeFromFavorites(
      {required String loadRef, required String uid}) async {
    await _firestore.collection('users').doc(uid).update({
      'favoriteLoads': FieldValue.arrayRemove([loadRef]),
    });
  }

  Future<List<Event>> fetchFavoriteLoads(MyUser user) async {
    print("+++++++++++++++++++++++++++++");
    print(user);
    List<dynamic> favoriteLoadsRef = user.favoriteLoads;
    List<Event> favoriteLoads = [];
    for (String loadRef in favoriteLoadsRef) {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firestore.collection('loads').doc(loadRef).get();
      if (docSnapshot.exists) {
        favoriteLoads.add(Event.fromfirestore(docSnapshot.data()!));
      } else {
        removeFromFavorites(loadRef: loadRef, uid: user.uid);
        throw (Exception('event deleted'));
      }
    }
    return favoriteLoads;
  }

  Future<Map<String, dynamic>> getCurrentUserInformation(String uid) async {
    Map<String, dynamic>? user = await _firestore
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => value.data());
    return user!;
  }

  Future<void> addNewUserInformations(
      {required String uid,
      required String imageLink,
      required String username,
      required String email,
      required String birdhdate,
      required String tel,
      required List<String> favoriteLoads}) async {
    Map<String, dynamic> user = {
      'uid': uid,
      'image': imageLink,
      'email': email,
      'tel': tel,
      'username': username,
      'birthdate': birdhdate,
      'favoriteLoads': []
    };
    await _firestore.collection(collectionrRef).doc(uid).set(user);
  }

  Future<void> postLoad(Map<String, dynamic> load, String respUid) async {
    var refdoc = _firestore.collection('loads').doc();
    load['eventRef'] = refdoc.id;
    load['respUid'] = respUid;
    await refdoc.set(load);
  }

  Future<List<Map<String, dynamic>>> fetchLoads() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('loads')
        .orderBy(descending: true, 'loadDate')
        .get();

    List<Map<String, dynamic>> loadsList =
        querySnapshot.docs.map((documentSnapshot) {
      return documentSnapshot.data();
    }).toList();

    return loadsList;
  }

  Future<void> deleteLoad(List<String> loads) async {
    for (String loadRef in loads) {
      if (loadRef != '') {
        await _firestore.collection('loads').doc(loadRef).delete();
      }
    }
  }

  Future<List<Map<String, dynamic>>> getFiltredLoads(
      {String? adress, RangeValues? price}) async {
    var query = FirebaseFirestore.instance.collection('loads').limit(10);

    if (adress != null) {
      query = query
          .where('adress', isGreaterThanOrEqualTo: adress)
          .where('adress', isLessThanOrEqualTo: '$adress\uf8ff');
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();

    List<Map<String, dynamic>> loadsList =
        querySnapshot.docs.map((documentSnapshot) {
      return documentSnapshot.data();
    }).toList();

    loadsList.removeWhere((e) {
      return (price != null &&
          (e['price'] < price.start || e['price'] > price.end));
    });

    return loadsList;
  }
}
