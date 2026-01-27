import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/forgot_password/pages/reset_account.dart';
import 'package:mouvema/src/presentation/shared/show_alert.dart';

import '../../../core/utils/image_manager.dart';
import '../widgets/option_button.dart';

/// ? authenticat user with phone number or emial
/// ?  mean sign in with email or phone number
/// ?  then prompt the set new password

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // bool smsPressed = false;
  bool emailPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(children: [
          // Confused Photo
          Expanded(flex: 2, child: Image.asset(ImageManager.forgortPassword)),
          const SizedBox(height: 20),
          Text(
            'Select Which contact details should we use to reset your password',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),

          Expanded(
            flex: 3,
            child: Column(
              children: [
                // OptionButton(
                //   isPressed: smsPressed,
                //   via: 'SMS',
                //   value: '+216 ******58',
                //   iconData: Icons.sms,
                //   onPressed: () {
                //     setState(() {
                //       smsPressed ^= true;
                //       emailPressed = false;
                //     });
                //   },
                // ),
                const SizedBox(height: 20),
                OptionButton(
                  isPressed: emailPressed,
                  via: 'Email',
                  value: 'user@example.com',
                  iconData: Icons.email,
                  onPressed: () {
                    setState(() {
                      emailPressed ^= true;
                    });
                  },
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (emailPressed) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => ResetAccountScreen())));
                        } else {
                          showAlert(
                              message: 'You need to choose an option',
                              context: context,
                              title: 'Error');
                        }
                      },
                      child: const Text('Continue')),
                )
              ],
            ),
          )

          // guidance text

          //via SMS

          // via Email
        ]),
      ),
    );
  }
}
