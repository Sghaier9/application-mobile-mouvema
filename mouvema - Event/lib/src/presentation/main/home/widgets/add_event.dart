import 'package:flutter/material.dart';

import '../../../../config/routes/routes.dart';

class AddLoad extends StatelessWidget {
  const AddLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      height: 100,
      child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, Routes.postLoad);
          },
          icon: const Icon(
            Icons.add_road,
            size: 50,
          ),
          label: Text(
            'Add a Load',
            style: Theme.of(context).textTheme.headlineLarge,
          )),
    );
  }
}
