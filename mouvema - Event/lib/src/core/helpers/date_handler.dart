class DateHandler {

  static DateTime convertStringToDate({required String date}) {
    List<String> dateParts = date.split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    return DateTime(year, month, day);
  }

  static Duration diffBetween2Dates({
    required DateTime start,
    required DateTime end,
  }) {
    return end.difference(start);
  }

  static String handleAge(Duration age) {
    int d = age.inDays;

    if (d > 0) {
      if (d == 1) {
        return "$d Day";
      }
      return "$d Days";
    } else {
      return 'Today';
    }
  }


   static  String formatDate(String date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Juin',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final parts = date.split('-');

    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    return '$day ${months[month - 1]}';
  }
}
