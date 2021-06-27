import 'package:intl/intl.dart';

class FormatMoney {
  static String toVND(double? text) {
    final oCcy = new NumberFormat("#,##0", "en_US");
    return '${oCcy.format(text)} đ';
  }
}
