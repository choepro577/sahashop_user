import 'package:intl/intl.dart';

import 'date_utils.dart';

class SahaStringUtils {
  static final SahaStringUtils _singleton = SahaStringUtils._internal();

  SahaStringUtils._internal();

  factory SahaStringUtils() {
    return _singleton;
  }


  String convertToMoney(dynamic price) {
    if (price is String) {
      price = double.parse(price);
    }
    return CURRENCY_FORMAT.format(price); // + "đ";
  }

  String convertToUnit(dynamic value) {
    if (value is String) {
      value = double.parse(value);
    }
    return UNIT_FORMAT.format(value); // + "đ";
  }

  String removeSeparateInString(String value) {
    return value.replaceAll(',', '');
  }

  String convertToDetailItem(double timeStart, double timeServing, String text) {
    return "${SahaDateUtils().getTimeByMinute(timeStart)} - ${SahaDateUtils().getTimeByMinute(timeStart + timeServing)}  $text\n$text";
  }

  num convertThousandToNumber(String price) {
    price = price.replaceAll(',', '');
    try {
      return num.parse(price);
    } catch (error) {
      return 0;
    }
  }

  String convertToK(dynamic price) {
    try {
      if (price is String) {
        price = double.parse(price);
      }
      price = price / 1000;
      return (double.parse(price.toString())).toStringAsFixed(0) + "k";
    } catch (e) {
      print(e);
      return price.toString();
    }
  }

  double getReverseValue(String value, bool isIgnore) {
    if (isIgnore) {
      return double.parse(value);
    }
    try {
      return double.parse(value) * -1;
    } catch (e) {
      return 0;
    }
  }

  String removeDecimalIfNeeded(dynamic value, {int decimal = 1}) {
    if (value is String) {
      try {
        value = double.parse(value);
      } catch (e) {
        return value;
      }
    }
    if (value is double) {
      if (value % 1 == 0) {
        return value.toInt().toString();
      }
      return value.toStringAsFixed(decimal);
    }
  }

  bool isNotEmpty(dynamic item) {
    if (item == null) return false;
    if (item is String) {
      return item.isNotEmpty;
    }
    return false;
  }

  bool isEmpty(String s) {
    return !isNotEmpty(s);
  }

  final CURRENCY_FORMAT = new NumberFormat("#,##0 đ", "en_US");

  final UNIT_FORMAT = new NumberFormat("#,##0", "en_US");

  String getAssetPath(String asset) {
    return "assets/$asset";
  }

  String removeLeading(String pattern, String from) {
    int i = 0;
    while (pattern == from[i]) {
      i++;
      if (i == from.length) break;
    }
    if (i == from.length) {
      return "0";
    } else {
      return from.substring(i, from.length);
    }
  }
}