import '../../core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.errorMessage,
      required this.keyboardType,
      required this.icon,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      required this.isError,
      this.isEnabled = true});

  final IconData? icon;
  final bool isError;
  final bool isPassword;

  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String errorMessage;
  final bool isEnabled;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isVisible = false;

  final Icon invisibleIcon = const Icon(
    Icons.remove_red_eye_outlined,
    color: ColorManager.mouvemaTeal,
  );
  final Icon visibleIcon = const Icon(
    Icons.panorama_fish_eye,
    color: ColorManager.mouvemaBrown,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.isEnabled,
      keyboardType: widget.keyboardType,
      obscuringCharacter: '*',
      controller: widget.controller,
      obscureText: widget.isPassword ? !isVisible : isVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        hintText: widget.hintText,
        errorText: widget.isError ? widget.errorMessage : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisible ^= true;
                  });
                },
                icon: isVisible ? visibleIcon : invisibleIcon)
            : null,
      ),
    );
  }
}
