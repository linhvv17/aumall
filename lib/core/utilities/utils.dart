import 'package:intl/intl.dart';

class Utils {
  static String convertPrice(String price) {
    return '${NumberFormat(',000,000,000').format(double.parse(price).toInt())} \đ';
  }
}
