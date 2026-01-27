import 'package:flutter/material.dart';

import '../../core/utils/color_manager.dart';
import 'text_field.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.isError,
    required this.label,
    required this.onPressed,
  });
  final bool isError;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                  errorMessage: 'Pick a date',
                  keyboardType: TextInputType.text,
                  icon: null,
                  controller: null,
                  hintText: 'sdfd',
                  isError: false,
                  isEnabled: false),
              const SizedBox(height: 5),
              isError
                  ? const Text(
                      'Date is Required',
                      style: TextStyle(
                        color: ColorManager.mouvemaError,
                        fontSize: 11,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(size: 30, Icons.calendar_month))
      ],
    );
  }
}
