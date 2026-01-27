import 'dart:io';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum Status { initial, success, loading, failed, onPositionChanged , imageSelected }

class PostState extends Equatable {
  const PostState({this.message, this.data, required this.status ,this.img});
  final Status status;
  final String? message;
  final List<LatLng?>? data;
  final Uint8List? img ;
  @override
  get props => [status, message, data,img];
}
