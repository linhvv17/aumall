import 'package:intl/intl.dart';

class Utils {
  static String convertPrice(String price) {
    return '\đ ${NumberFormat(',000,000,000').format(double.parse(price).toInt())}';
  }
}
