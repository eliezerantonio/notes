import 'package:intl/intl.dart';

class HelperDateFormat {
  static String format(DateTime date) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedDate = formatter.format(date);

    return formattedDate;
  }
}
