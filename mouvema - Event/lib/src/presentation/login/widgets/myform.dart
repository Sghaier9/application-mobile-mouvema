import 'package:flutter/material.dart';

import '../../shared/text_field.dart';

class MyForm extends StatelessWidget {
  const MyForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isEmailError,
    required this.isPasswordError,
    required this.loginPressed,
    required this.registerPressed,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isEmailError;
  final bool isPasswordError;
  final VoidCallback loginPressed;
  final VoidCallback registerPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextField(
            errorMessage: 'email required',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
            controller: emailController,
            hintText: 'user@example.com',
            isError: isEmailError),
        const SizedBox(height: 20),
        MyTextField(
            isPassword: true,
            errorMessage: 'password is required',
            keyboardType: TextInputType.text,
            icon: Icons.key_sharp,
            controller: passwordController,
            hintText: 'Enter Your Password',
            isError: isPasswordError),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: loginPressed,
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account ? '),
            TextButton(
                onPressed: registerPressed, child: const Text('Register'))
          ],
        )
      ],
    );
  }
}
