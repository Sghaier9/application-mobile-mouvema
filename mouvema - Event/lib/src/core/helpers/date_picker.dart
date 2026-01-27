import 'package:flutter/material.dart' show showDatePicker, BuildContext;

Future<DateTime?> pickDate(BuildContext ctx) async {
  DateTime lastdate = DateTime(DateTime.now().year - 18, 12, 31, 0, 0, 0, 0, 0);
  DateTime initialdate =
      DateTime(DateTime.now().year - 80, 12, 31, 0, 0, 0, 0, 0);

  return await showDatePicker(
      context: ctx,
      initialDate: initialdate,
      firstDate: initialdate,
      lastDate: lastdate);
}
