import 'package:flutter/material.dart';
import 'package:mouvema/src/presentation/forgot_password/pages/reset_account.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _pinController = TextEditingController();
  // ignore: unused_field
  String _pin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text("Verification Code"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Code Has been send to +216****99",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              backgroundColor: Colors.transparent,
              appContext: context,
              length: 4,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                // not being used
                inactiveFillColor: const Color.fromARGB(255, 132, 209, 200),
                inactiveColor: const Color.fromARGB(255, 132, 209, 200),
                // being used
                selectedFillColor: const Color.fromARGB(255, 132, 209, 200),
                selectedColor: Colors.teal,
                // complet using
                activeFillColor: const Color.fromARGB(255, 132, 209, 200),
                activeColor: const Color.fromARGB(255, 132, 209, 200),

                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
              ),
              animationDuration: const Duration(milliseconds: 200),
              enableActiveFill: true,
              controller: _pinController,
              onCompleted: (v) {},
              onChanged: (value) {
                setState(() {
                  _pin = value;
                });
              },
            ),
            TextButton(onPressed: () {}, child: const Text('Resend Code')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => ResetAccountScreen())));
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
