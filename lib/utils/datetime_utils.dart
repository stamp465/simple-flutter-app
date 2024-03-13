import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateFormat get dobDateFormat => DateFormat("yyyy-MM-dd");

  static String dobDateToString(DateTime date) =>
      DateTimeUtils.dobDateFormat.format(date);

  static DateTime dobStringToDate(String date) =>
      DateTimeUtils.dobDateFormat.parse(date);
}
