import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/image_manager.dart';

class ProfilePhotoSelector extends StatelessWidget {
  const ProfilePhotoSelector(
      {super.key, required this.pictureFile, required this.onPressed});

  final Uint8List? pictureFile;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipOval(
        child: (pictureFile == null)
            ? SvgPicture.asset(
                ImageManager.profile,
                // ignore: deprecated_member_use
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            : Image.memory(pictureFile!,
                width: 200, height: 200, fit: BoxFit.cover),
      ),
      Positioned(
          bottom: 120,
          right: 10,
          child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.add_a_photo_outlined)))
    ]);
  }
}
