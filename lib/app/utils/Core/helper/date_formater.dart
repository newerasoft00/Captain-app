import 'package:intl/intl.dart';

String formattedDate(DateTime date) {
 DateTime currentDate = DateTime.now();

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(currentDate);
}