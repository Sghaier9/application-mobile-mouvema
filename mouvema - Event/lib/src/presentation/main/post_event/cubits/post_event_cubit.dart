import 'dart:io';

import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mouvema/src/core/internet_checker.dart';
import 'package:mouvema/src/presentation/main/post_event/cubits/post_event_state.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/failure.dart';
import '../../../../data/models/event.dart';
import '../../../../domain/repositories/repositories.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._repository) : super(const PostState(status: Status.initial));

  final Repository _repository;
  String? truckType;
  LatLng? origin;
  LatLng? destination;
  File? image;
  Uint8List? bytes;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        // Utilise pickedFile.readAsBytes() au lieu de File.readAsBytes()
        bytes = await pickedFile.readAsBytes();
        emit(PostState(
            status: Status.imageSelected, img: bytes, data: [origin]));
      } catch (e) {
        print("Erreur lors de la lecture de l'image : $e");
        emit(PostState(status: Status.failed));
      }
    }
  }

  Future<bool> isConnected() async {
    return await InternetCheckerImpl().isConnected();
  }

  void onPositionChanged(LatLng? origin) async {
    emit(PostState(
        status: Status.onPositionChanged, data: [origin], img: bytes));
  }

  void postLoad(Event event, Uint8List img) async {
    emit(const PostState(status: Status.loading));

    Either<Failure, void> result =
        await _repository.postLoad(event.toFirestore(), img);

    result.fold(
        (l) => emit(PostState(status: Status.failed, message: l.errrorMessage)),
        (r) => emit(const PostState(status: Status.success)));
  }
}
