import 'package:flutter/material.dart';

Future<dynamic> showAlert(
    {required String message,
    required BuildContext context,
    required String title}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
              child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
          )),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            )
          ],
        );
      });
}
