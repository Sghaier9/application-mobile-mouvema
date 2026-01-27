import 'package:flutter/material.dart' show showDatePicker, BuildContext;

Future<DateTime?> pickDate(BuildContext ctx) async {
  DateTime lastDate = DateTime(2030, 12, 31, 0, 0, 0, 0, 0);
  DateTime firestDate = DateTime.now();

  return await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: firestDate,
      lastDate: lastDate);
}
