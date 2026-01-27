import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Event extends Equatable {
  const Event({
    required this.eventRef,
    required this.respName,
    required this.respPhone,
    required this.postDate,
    required this.eventDate,
    required this.price,
    required this.description,
    required this.adress,
    required this.adressLat,
    required this.adressLng,
    required this.image,
  });

  final String eventRef;
  final String respName;
  final String respPhone;
  final String postDate;
  final String eventDate;
  final int price;
  final String description;
  final String adress;
  final double adressLat;
  final double adressLng;
  final String image;

  Map<String, dynamic> toFirestore() => {
        'respName': respName,
        'eventRef': eventRef,
        'respPhone': respPhone,
        'adress': adress,
        'adressLat': adressLat,
        'adressLng': adressLng,
        'postDate': postDate,
        'eventDate': eventDate,
        'price': price,
        'description': description,
        'image': image,
      };

  factory Event.fromfirestore(Map<String, dynamic> map) {
    return Event(
      respName: map['respName'],
      eventRef: map['eventRef'],
      respPhone: map['respPhone'],
      adress: map['adress'],
      adressLat: map['adressLat'],
      adressLng: map['adressLng'],
      postDate: map['postDate'],
      eventDate: map['eventDate'],
      price: map['price'],
      description: map['description'],
      image: (map['image'] is String) ? map['image'] : '',
    );
  }

  @override
  List<Object?> get props => [
        eventRef,
        respName,
        respPhone,
        adressLat,
        adressLng,
        postDate,
        eventDate,
        price,
        description,
        image
      ];
}
