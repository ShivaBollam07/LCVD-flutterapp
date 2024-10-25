String formatDateTime(DateTime dateTime) {
  String formattedDate =
      '${getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
  String formattedTime =
      '${padZero(dateTime.hour)}:${padZero(dateTime.minute)}';
  return '$formattedDate - $formattedTime';
}

String getMonthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return months[month - 1];
}

String padZero(int number) {
  return number < 10 ? '0$number' : '$number';
}
