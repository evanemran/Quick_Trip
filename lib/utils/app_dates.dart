import 'package:intl/intl.dart';

class AppDates {
  static List<DateTime> dateTimeListFromForm({
    required String dateRange,
    required String times,
  }) {
    final DateFormat dateFormat = DateFormat("d/M/yyyy");
    final DateFormat timeFormat = DateFormat("h:mm a");

    // 1️⃣ Parse date range
    final parts = dateRange.split('-');
    final startDate = dateFormat.parse(parts[0].trim());
    final endDate = dateFormat.parse(parts[1].trim());

    // 2️⃣ Parse times
    final timeStrings = times.split(',');
    final parsedTimes = timeStrings
        .map((t) => timeFormat.parse(t.trim()))
        .toList();

    // 3️⃣ Generate DateTime list
    List<DateTime> result = [];

    for (DateTime date = startDate;
    !date.isAfter(endDate);
    date = date.add(const Duration(days: 1))) {
      for (final time in parsedTimes) {
        result.add(DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        ));
      }
    }

    return result;
  }
}