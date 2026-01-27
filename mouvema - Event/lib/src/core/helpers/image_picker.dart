import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> takepicture() async {
  final imagePicker = ImagePicker();
  final XFile? pickedimage =
      await imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedimage != null) {
    return pickedimage.readAsBytes();
  }
  return null;
}
