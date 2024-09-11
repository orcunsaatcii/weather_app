import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime convertToDateTime(int unixTime) {
    return DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
  }

  static String showCurrentDateTime(DateTime date) {
    return DateFormat('EEE, MMMM d').format(date);
  }

  final dateProvider = StateProvider<DateTime>((ref) {
    return DateTime.now();
  });

  static String convertTime(DateTime time) {
    return DateFormat.jm().format(time);
  }
}
