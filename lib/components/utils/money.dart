import 'package:intl/intl.dart';

class FormatMoney {
  static String toVND(int text) {
    final oCcy = new NumberFormat("#,##0", "en_US");
    return '${oCcy.format(text)} đ';
  }
}
