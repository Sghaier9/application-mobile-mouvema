import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';

class Or extends StatelessWidget {
  const Or({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: 100,
          color: ColorManager.mouvemaTeal,
        ),
        const SizedBox(
          width: 5,
        ),
        const Text('Or'),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 1,
          width: 100,
          color: ColorManager.mouvemaTeal,
        ),
      ],
    );
  }
}
