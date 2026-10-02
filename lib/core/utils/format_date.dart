import 'package:intl/intl.dart';

String formatDateBYdMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM,yyyy").format(dateTime);
}
