import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  const IconTextField({
    super.key,
    required this.icon,
    required this.keyboard,
    required this.hint,
    required this.errorText,
    this.isError = false,
    required this.getValue,
    required this.isValid,
  });
  final void Function(String) getValue;
  final Icon icon;
  final TextInputType keyboard;
  final String hint;
  final String errorText;
  final bool isError;
  final bool Function(String?) isValid;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: TextFormField(
          onSaved: (newValue) {
            getValue(newValue!);
          },
          validator: (value) {
            if (!isValid(value)) {
              return errorText;
            } else {
              return null;
            }
          },

          // controller: inputController,
          decoration: InputDecoration(
            filled: true,
            //  errorText: isError ? errorText : null,
            hintText: hint,
          ),
          keyboardType: keyboard),
    );
  }
}
