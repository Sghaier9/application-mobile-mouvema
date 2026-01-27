import 'package:flutter/material.dart';

class HintText extends StatelessWidget {
  const HintText({
    super.key,
    required this.hint,
  });
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Text(
      hint,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
